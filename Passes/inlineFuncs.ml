(*
 * Copyright (c) 2014, Prologin
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *)


(**
   Cette passe permet d'inliner des fonctions
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib
open Ast
open Fresh
open PassesUtils

type 'a function_t =
  { content : Utils.instr list;
    params : (varname * Type.t) list;
    retype : Type.t
  }

type acc0 = unit
type 'lex acc = 'lex function_t StringMap.t


let init_acc () = StringMap.empty

let map_return t name instrs =
  let f g i =
    let annot = Instr.Fixed.annot i in
    match Instr.unfix i with
    | Instr.Return e ->
      Instr.Declare (name, t, e, Instr.useless_declaration_option) |> Instr.fixa annot
    | Instr.AllocArray _ -> i
    | _ -> g i
  in List.map (fun i ->
      f (Instr.Writer.Traverse.map f) i) instrs

(* renomme les variables de mut, suivant la map acc *)
let rec rename_mut acc mut =
  let annot = Mutable.Fixed.annot mut in
  match Mutable.unfix mut with
  | Mutable.Var varname ->
    begin match BindingMap.find_opt varname acc with
      | None -> mut
      | Some s -> Mutable.Var s |> Mutable.Fixed.fixa annot
    end
  | Mutable.Array (m, li) ->
    let m = rename_mut acc m in
    let li = List.map (rename_e acc) li in
    Mutable.Array(m, li) |> Mutable.Fixed.fixa annot
  | Mutable.Dot (m, n) ->
    let m = rename_mut acc m in
    Mutable.Dot (m, n) |> Mutable.Fixed.fixa annot
(* renomme les variables de e, suivant la map acc *)
and rename_e acc e =
  let f g e =
    match Expr.unfix e with
    | Expr.Access mut ->
      Expr.Access (rename_mut acc mut) |> Expr.Fixed.fixa (Expr.Fixed.annot e)
    | _ -> g e
  in f (Expr.Writer.Traverse.map f) e

let rec rename_instr acc (instr:Utils.instr) =
  let annot = Instr.Fixed.annot instr in
  match Instr.unfix instr with
  | Instr.Call (name, li) ->
    let li = List.map (rename_e acc) li in
    acc, Instr.Call (name, li) |> Instr.fixa annot
  | Instr.Declare (var, t, e, opt) ->
    let newname = Fresh.fresh_internal () in
    let e = rename_e acc e in
    let acc = BindingMap.add var newname acc in
    acc, Instr.Declare (newname, t, e, opt) |> Instr.fixa annot
  | Instr.Affect (mut, e) ->
    let e = rename_e acc e in
    let mut = rename_mut acc mut
    in acc, Instr.Affect (mut, e) |> Instr.fixa annot
  | Instr.SelfAffect (mut, op, e) ->
    let e = rename_e acc e in
    let mut = rename_mut acc mut
    in acc, Instr.SelfAffect (mut, op, e) |> Instr.fixa annot
  | Instr.Loop (var, e1, e2, li) ->
    let e1 = rename_e acc e1 in
    let e2 = rename_e acc e2 in
    let newname = Fresh.fresh_internal () in
    let acc = BindingMap.add var newname acc in
    let li = rename_instrs acc li in
    acc, Instr.Loop (newname, e1, e2, li) |> Instr.fixa annot
  | Instr.ClikeLoop (init, cond, incr, li) ->
    let cond = rename_e acc cond in
    let init = rename_instrs acc init in
    let incr = rename_instrs acc incr in
    let li = rename_instrs acc li in
    acc, Instr.ClikeLoop (init, cond, incr, li) |> Instr.fixa annot
  | Instr.Incr mut -> acc, Instr.Incr (rename_mut acc mut) |> Instr.fixa annot
  | Instr.Decr mut -> acc, Instr.Decr (rename_mut acc mut) |> Instr.fixa annot
  | Instr.While (e, li) ->
    let e = rename_e acc e in
    let li = rename_instrs acc li in
    acc, Instr.While (e, li) |> Instr.fixa annot
  | Instr.Comment _s -> acc, instr
  | Instr.Tag _s ->  acc, instr
  | Instr.Return e ->
    acc, Instr.Return (rename_e acc e) |> Instr.fixa annot
  | Instr.AllocArray (name, t, e, None, opt) ->
    let e = rename_e acc e in
    let newname = Fresh.fresh_internal () in
    let acc = BindingMap.add name newname acc in
    acc, Instr.AllocArray (newname, t, e, None, opt) |> Instr.fixa annot
  | Instr.AllocArrayConst (name, t, e, lief, opt) ->
    let e = rename_e acc e in
    let newname = Fresh.fresh_internal () in
    let acc = BindingMap.add name newname acc in
    acc, Instr.AllocArrayConst (newname, t, e, lief, opt) |> Instr.fixa annot
  | Instr.AllocArray (name, t, e, Some (name2, li), opt) ->
    let e = rename_e acc e in
    let newname = Fresh.fresh_internal () in
    let acc = BindingMap.add name newname acc in
    let newname2 = Fresh.fresh_internal () in
    let acc = BindingMap.add name2 newname2 acc in
    let li = rename_instrs acc li in
    acc, Instr.AllocArray (newname, t, e, Some (newname2, li), opt) |> Instr.fixa annot
  | Instr.AllocRecord (name, t, fields, opt) ->
    let fields = List.map (fun (fieldname, expr) -> fieldname, rename_e acc expr) fields in
    let newname = Fresh.fresh_internal () in
    let acc = BindingMap.add name newname acc in
    acc, Instr.AllocRecord (newname, t, fields, opt) |> Instr.fixa annot
  | Instr.If (e, l1, l2) ->
    let e = rename_e acc e in
    let l1 = rename_instrs acc l1 in
    let l2 = rename_instrs acc l2 in
    acc, Instr.If (e, l1, l2) |> Instr.fixa annot
  | Instr.Print li ->
    let li = List.map (function
        | Instr.StringConst str -> Instr.StringConst str
        | Instr.PrintExpr (t, e) -> Instr.PrintExpr (t, rename_e acc e)) li
    in
    acc, Instr.Print li |> Instr.fixa annot
  | Instr.Read li ->
    let acc, li = List.fold_left_map (fun acc -> function
        | Instr.DeclRead (t, name, opt) ->
          let newname = Fresh.fresh_internal () in
          let acc = BindingMap.add name newname acc in
          acc, (Instr.DeclRead (t, newname, opt))
        | Instr.Separation -> acc, Instr.Separation
        | Instr.ReadExpr (t, mut) -> acc, Instr.ReadExpr (t, rename_mut acc mut)) acc li in
    acc, Instr.Read li |> Instr.fixa annot
  | Instr.Untuple (li, e, opt) ->
    let e = rename_e acc e in
    let acc, li = List.fold_left_map (fun acc (ty, name) ->
        let newname = Fresh.fresh_internal () in
        let acc = BindingMap.add name newname acc in
        acc, (ty, newname) ) acc li
    in
    acc, Instr.Untuple (li, e, opt) |> Instr.fixa annot
  | Instr.Unquote e -> acc, instr (* normalement, ça n'arrive pas... l'evaluation des macros devrait déjà avoir eu lieu. *)
and rename_instrs acc instrs =
  let _, instrs = List.fold_left_map rename_instr acc instrs in
  instrs

let rec map_e acc e =
  let annot = Expr.Fixed.annot e in
  match Expr.unfix e with
  | Expr.Just e -> let addon, e = map_e acc e in addon, Expr.Just e |> Expr.Fixed.fixa annot
  | Expr.BinOp (e1, bop, e2) ->
    let addon1, e1 = map_e acc e1 in
    let addon2, e2 = map_e acc e2 in
    List.append addon1 addon2, Expr.BinOp (e1, bop, e2) |> Expr.Fixed.fixa annot
  | Expr.UnOp (e, op) ->
    let addon, e = map_e acc e in
    addon, Expr.UnOp (e, op) |> Expr.Fixed.fixa annot
  | Expr.Lief _ -> [], e
  | Expr.Access m ->
    let addon, m =  map_mut acc m
    in addon, Expr.Access m |> Expr.Fixed.fixa annot
  | Expr.Call (name, li) ->
    let addon, li = List.fold_left_map (fun addon0 e -> let addon, e = map_e acc e in List.append addon0 addon, e ) [] li in
    begin match StringMap.find_opt name acc with
      | Some {content=content; params=params; retype=retype} ->
        let out = Fresh.fresh_internal () in
        let mout = Mutable.var out in
        let li = insert content retype params li (Some out) in
        let addon = List.append addon li in
        addon, Expr.Access mout |> Expr.Fixed.fixa annot
      | None -> addon, Expr.Call (name, li) |> Expr.Fixed.fixa annot
    end
  | Expr.Tuple li ->
    let addon, li =
      List.fold_left_map (fun addon e ->
          let addon0, e = map_e acc e in
          List.append addon addon0, e) [] li
    in addon, Expr.Tuple li |> Expr.Fixed.fixa annot
  | Expr.Record li ->
    let addon, li =
      List.fold_left_map (fun addon (name, e) ->
          let addon0, e = map_e acc e in
          List.append addon addon0, (name, e)) [] li
    in addon, Expr.Record li |> Expr.Fixed.fixa annot
  | Expr.Lexems _ -> assert false

and map_mut acc mut =
  let annot = Mutable.Fixed.annot mut in
  match Mutable.unfix mut with
  | Mutable.Var _varname -> [], mut
  | Mutable.Array (m, li) ->
    let addon, m = map_mut acc m in
    let addon, li = List.fold_left_map (fun addon e ->
        let addon0, e = map_e acc e in
        List.append addon addon0, e
      ) addon li in
    addon, Mutable.Array(m, li) |> Mutable.Fixed.fixa annot
  | Mutable.Dot (m, n) ->
    let addon, m = map_mut acc m in
    addon, Mutable.Dot (m, n) |> Mutable.Fixed.fixa annot

and insert content retype params values optionreturn =
  let paramscouples = List.zip params values in
  let acc0, declares = List.fold_left_map (fun acc ((name, type_), expr) ->
      match Expr.unfix expr with
      | Expr.Access (Mutable.Fixed.F (_, Mutable.Var newname)) -> (* on évite un déclare quand c'est possible *)
        BindingMap.add name newname acc, None
      | _ ->
        let newname = Fresh.fresh_internal () in
        let declare = Some (Instr.declare newname type_ expr Instr.useless_declaration_option) in
        BindingMap.add name newname acc, declare
    ) BindingMap.empty paramscouples in
  let declares = List.filter_map (fun x -> x) declares in
  let content = rename_instrs acc0 content in
  let content = match optionreturn with
    | None -> content
    | Some name -> map_return retype name content in
  List.append declares content

let rec map_instrs acc (instrs : Utils.instr list) : Utils.instr list =
  List.flatten (List.map (map_instr acc) instrs)
and map_instr acc instr =
  let annot = Instr.Fixed.annot instr in
  match Instr.unfix instr with
  | Instr.Call (name, li) ->
    let addon, li = List.fold_left_map (fun addon0 e ->
        let addon, e = map_e acc e in
        (List.append addon0 addon), e
      ) [] li in
    begin match StringMap.find_opt name acc with
      | Some {content=content; params=params; retype=retype} ->
        let li = insert content retype params li None in
        List.append addon li
      | None -> List.append addon [Instr.Call (name, li) |> Instr.fixa annot]
    end
  | Instr.Declare (var, t, e, opt) ->
    let addon, e = map_e acc e in
    List.append addon [Instr.Declare (var, t, e, opt) |> Instr.fixa annot ]
  | Instr.Affect (mut, e) ->
    let addon1, mut = map_mut acc mut in
    let addon2, e = map_e acc e in
    List.append addon1 (List.append addon2 [Instr.Affect (mut, e) |> Instr.fixa annot ])
  | Instr.SelfAffect (mut, op, e) ->
    let addon1, mut = map_mut acc mut in
    let addon2, e = map_e acc e in
    List.append addon1 (List.append addon2 [Instr.SelfAffect (mut, op, e) |> Instr.fixa annot ])
  | Instr.Incr mut ->
    let addon1, mut = map_mut acc mut in
    List.append addon1 [Instr.Incr mut |> Instr.fixa annot ]
  | Instr.Decr mut ->
    let addon1, mut = map_mut acc mut in
    List.append addon1 [Instr.Decr mut |> Instr.fixa annot ]
  | Instr.Loop (v, e1, e2, li) ->
    let addon1, e1 = map_e acc e1 in
    let addon2, e2 = map_e acc e2 in
    let li = map_instrs acc li in
    List.append addon1 (List.append addon2 [Instr.Loop (v, e1, e2, li) |> Instr.fixa annot ])
  | Instr.ClikeLoop (init, cond, incr, li) ->
    let addon, cond = map_e acc cond in
    let init = map_instrs acc init in
    let incr = map_instrs acc incr in
    let li = map_instrs acc li in
    List.append addon [Instr.ClikeLoop (init, cond, incr, li) |> Instr.fixa annot ]
  | Instr.While (e, li) ->
    let addon, e = map_e acc e in
    let li = map_instrs acc li in
    List.append addon [Instr.While (e, li) |> Instr.fixa annot]
  | Instr.Comment _s -> [instr]
  | Instr.Tag _s -> [instr]
  | Instr.Return e ->
    let addon, e = map_e acc e in
    List.append addon [Instr.Return e |> Instr.fixa annot]
  | Instr.AllocArray (name, t, e, None, opt) ->
    let addon, e = map_e acc e in
    List.append addon [Instr.AllocArray (name, t, e, None, opt) |> Instr.fixa annot]
  | Instr.AllocArrayConst (name, t, e, lief, opt) ->
    let addon, e = map_e acc e in
    List.append addon [Instr.AllocArrayConst (name, t, e, lief, opt) |> Instr.fixa annot]
  | Instr.AllocArray (name, t, e, Some (name2, li), opt) ->
    let addon, e = map_e acc e in
    let li = map_instrs acc li in
    List.append addon [Instr.AllocArray (name, t, e, Some (name2, li), opt) |> Instr.fixa annot]
  | Instr.AllocRecord (name, t, fields, opt) ->
    let addon, fields = List.fold_left_map (fun addon0 (name, e) ->
        let addon, e = map_e acc e in
        (List.append addon0 addon), (name, e)
      ) [] fields in
    List.append addon [Instr.AllocRecord (name, t, fields, opt) |> Instr.fixa annot]
  | Instr.If (e, l1, l2) ->
    let addon, e = map_e acc e in
    let l1 = map_instrs acc l1 in
    let l2 = map_instrs acc l2 in
    List.append addon [Instr.If (e, l1, l2) |> Instr.fixa annot]
  | Instr.Print li ->
    let addon, li = List.fold_left_map (fun addon -> function
        | Instr.StringConst str -> addon, Instr.StringConst str
        | Instr.PrintExpr (t, e) -> let addon, e = map_e acc e in
          addon, Instr.PrintExpr (t, e)) [] li
    in
    List.append addon [Instr.Print li |> Instr.fixa annot]
  | Instr.Read li ->
    let addon, li = List.fold_left_map (fun addon -> function
        | Instr.Separation -> addon, Instr.Separation
        | Instr.DeclRead (t, name, opt) -> addon, Instr.DeclRead (t, name, opt) 
        | Instr.ReadExpr (t, mut) -> let addon, mut = map_mut acc mut in
          addon, Instr.ReadExpr(t, mut)) [] li in
    List.append addon [Instr.Read li |> Instr.fixa annot]
  | Instr.Untuple (li, e, opt) ->
    let addon, e = map_e acc e in
    List.append addon [Instr.Untuple(li, e, opt) |> Instr.fixa annot]
  | Instr.Unquote e -> [instr] (* normalement, ça n'arrive pas... l'evaluation des macros devrait déjà avoir eu lieu. *)

let process (acc: 'a acc) (i:Utils.t_fun) = match i with
  | Prog.DeclarFun (name, ty, params, instrs, opt ) ->
    let instrs = map_instrs acc instrs in
    let acc = begin match opt with
      | {Ast.Prog.useless=true} ->
        StringMap.add name
          {content=instrs; params=params; retype=ty} acc
      | _ -> acc
    end
    in acc, Prog.DeclarFun (name, ty, params, instrs, opt)
  | _ -> acc, i

let process_main acc instrs =
  acc, map_instrs acc instrs

