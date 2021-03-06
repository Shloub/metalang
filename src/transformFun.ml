(*
 * Copyright (c) 2012, Prologin
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
   Ce module transforme un ast metalang impératif en ast fonctionnel
   On concerve les effets de bords sur les records et les arrays.
   Aucune technique ne permet de se passer de ces effets de bords sans pourrir le code.
   Par contre, on supprime les références et les returns.
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ext

module F = AstFun
module A = Ast

module BindingSet = A.BindingSet

let may_return i =
  let f tra acc i =
    match A.Instr.unfix i with
    | A.Instr.Return i -> true
    | A.Instr.AllocArray _ -> acc
    | _ -> tra acc i
  in f (A.Instr.Writer.Traverse.fold f) false i

let bad_return li = List.exists may_return li

let rec must_return li =
  let f i =
    match A.Instr.unfix i with
    | A.Instr.Return i -> true
    | A.Instr.If (e, li1, li2) -> must_return li1 && must_return li2
    | _ -> false
  in List.exists f li

let bad_return li = List.exists may_return li

let rec name_of_mutable m = match A.Mutable.unfix m with
  | A.Mutable.Var (varname) -> Some varname
  | A.Mutable.Array (m, _)
  | A.Mutable.Dot (m, _) -> None

let lief = function
  | A.Expr.Char c -> F.Expr.Char c
  | A.Expr.String s -> F.Expr.String s
  | A.Expr.Integer i -> F.Expr.Integer i
  | A.Expr.Bool b -> F.Expr.Bool b
  | A.Expr.Enum e -> F.Expr.Enum e
  | A.Expr.Nil -> F.Expr.Nil

let rec mutable_type tyenv t = match A.Type.unfix t with
  | A.Type.Integer -> false
  | A.Type.String -> false
  | A.Type.Char -> false
  | A.Type.Array _ -> true
  | A.Type.Void -> false
  | A.Type.Option t -> mutable_type tyenv t
  | A.Type.Bool -> false
  | A.Type.Lexems -> false
  | A.Type.Struct _ -> true
  | A.Type.Enum _ -> false
  | A.Type.Named name -> mutable_type tyenv (Typer.byname name tyenv)
  | A.Type.Tuple li -> List.exists (mutable_type tyenv) li
  | A.Type.Auto -> assert false (* on a besoin d'un truc typế à ce moment de la compilation *)

let rec accessmut (m:F.Expr.t A.Mutable.t) : F.Expr.t = match A.Mutable.unfix m with
  | A.Mutable.Var (varname) -> F.Expr.binding varname
  | A.Mutable.Array (m, li) ->
    F.Expr.arrayaccess (accessmut m) li
  | A.Mutable.Dot (mut, field) ->
    let mut = accessmut mut in F.Expr.recordaccess mut field

let rec affect_mutable (cont:F.Expr.t) (m:F.Expr.t A.Mutable.t) (e:F.Expr.t) = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> F.Expr.apply cont [e]
  | A.Mutable.Array (mut, []) -> assert false
  | A.Mutable.Array (mut, item) -> F.Expr.arrayaffectin (accessmut mut) item e cont
  | A.Mutable.Dot (mut, field) -> F.Expr.recordaffectin (accessmut mut) field e cont

let affected li =
  List.fold_left (fun acc i ->
      A.Instr.Writer.Deep.fold (fun acc i -> match A.Instr.unfix i with
          | A.Instr.Read li ->
            List.fold_left (fun acc -> function
                | A.Instr.ReadExpr (_, m) -> begin match name_of_mutable m with
                    | None -> acc
                    | Some s -> BindingSet.add s acc
                  end
                | A.Instr.Separation -> acc
                | A.Instr.DeclRead _ -> acc ) acc li
          | A.Instr.Affect (m, _) -> begin match name_of_mutable m with
              | None -> acc
              | Some s -> BindingSet.add s acc
            end
          | _ -> acc
        ) acc i
    ) BindingSet.empty li

let rec instrs suite contsuite (contreturn:F.Expr.t option) env = function
  | [] ->
    if suite then contsuite
    else begin match contreturn with
      | Some c -> c
      | None -> F.Expr.unit
    end
  | hd::tl -> match A.Instr.unfix hd with
    | A.Instr.Declare (v, ty, e, _) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.apply (F.Expr.fun_ [v] tl) [e]
    | A.Instr.AllocRecord (v, ty, li, _) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.apply (F.Expr.fun_ [v] tl) [F.Expr.record (List.map (fun (a, b) -> b, a) li)]
    | A.Instr.Affect (m, e) ->
      let v = name_of_mutable m in
      let nenv = Option.map_default env (fun v -> if List.mem v env then env else v::env) v in
      let tl = instrs suite contsuite contreturn nenv tl in
      begin match v with
        | Some v -> affect_mutable (F.Expr.fun_ [v] tl) m e
        | None -> affect_mutable tl m e
      end
    | A.Instr.SelfAffect (m, op, e) ->
      let accesm = accessmut m in
      let v = name_of_mutable m in
      let nenv = Option.map_default env (fun v -> if List.mem v env then env else v::env) v in
      let tl = instrs suite contsuite contreturn nenv tl in
      begin match v with
        | Some v -> affect_mutable (F.Expr.fun_ [v] tl) m (F.Expr.binop accesm op e)
        | None -> affect_mutable tl m e
      end
    | A.Instr.Read li ->
      let rec continue env = function
        | [] -> instrs suite contsuite contreturn env tl
        | A.Instr.DeclRead (t, v, _) :: tl ->
          let tl = continue (v::env) tl in
          F.Expr.readin (F.Expr.fun_ [v] tl) t
        | A.Instr.Separation :: tl ->
          let next = continue env tl in
          F.Expr.skipin next
        | A.Instr.ReadExpr (ty, m) :: tl ->
          let v = name_of_mutable m in
          let nenv = Option.map_default env (fun v -> if List.mem v env then env else v::env) v in
          let tl = continue nenv tl in
          let f = Fresh.fresh_internal () in
          let cont = match v with
            | Some v -> affect_mutable (F.Expr.fun_ [v] tl) m (F.Expr.binding f)
            | None -> affect_mutable tl m (F.Expr.binding f)
          in F.Expr.readin (F.Expr.fun_ [f] cont) ty
      in continue env li
    | A.Instr.Return ( e) ->
      begin match contreturn with
        | Some contreturn -> F.Expr.apply contreturn [e]
        | None -> e
      end
    | A.Instr.Call (funname, eli) ->
      let next = instrs suite contsuite contreturn env tl in
      let call = F.Expr.apply (F.Expr.binding (A.UserName funname)) eli
      in F.Expr.block [call; next]
    | A.Instr.Comment str ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.comment str next
    | A.Instr.If (e, l1, l2) ->
      let affectedl1 = affected l1 in
      let affectedl2 = affected l2 in
      let affected = BindingSet.elements @$ BindingSet.union affectedl1 affectedl2 in
      let affected = List.filter (fun x -> List.mem x env) affected in
      let next = instrs suite contsuite contreturn env tl in
      let brl1 = bad_return l1 in
      let brl2 = bad_return l2 in
      let mrl1 = must_return l1 in
      let mrl2 = must_return l2 in
      if mrl2 || mrl1 || tl = [] then (* if terminal OU une seule branche renvoie *)
        let body1 = instrs true next contreturn env l1 in
        let body2 = instrs true next contreturn env l2 in
        F.Expr.if_ e body1 body2
      else if brl2 || brl1 then
        let next = F.Expr.fun_ affected next in
        let nextname = Fresh.fresh_internal () in
        let ncont = F.Expr.apply (F.Expr.binding nextname) (List.map F.Expr.binding affected) in
        let body1 = instrs true ncont contreturn env l1 in
        let body2 = instrs true ncont contreturn env l2 in
        F.Expr.apply
          (F.Expr.fun_ [nextname] (F.Expr.if_ e body1 body2))
          [next]
      else (* on renvoie un environement *)
        let next, ncont = match affected with
          | [affected] ->	F.Expr.fun_ [affected] next , F.Expr.binding affected
          | _ -> F.Expr.funtuple affected next ,F.Expr.tuple (List.map F.Expr.binding affected) in
        let body1 = instrs true ncont contreturn env l1 in
        let body2 = instrs true ncont contreturn env l2 in
        F.Expr.apply next [F.Expr.if_ e body1 body2]
    | A.Instr.Print li ->
      let next = instrs suite contsuite contreturn env tl in
      List.fold_right (fun item next -> match item with
          | A.Instr.PrintExpr (ty, e) ->
            F.Expr.print e ty next
          | A.Instr.StringConst str ->
            F.Expr.print (F.Expr.lief (F.Expr.String str)) A.Type.string next
        ) li next
    | A.Instr.While (e, li) ->
      let affected = List.filter (fun x -> List.mem x env) @$ BindingSet.elements @$ affected li in
      let next = instrs suite contsuite contreturn env tl in
      let loop = Fresh.fresh_internal () in
      let returnenv = List.map F.Expr.binding affected in
      let nextLoop = F.Expr.apply (F.Expr.binding loop) returnenv in
      let content = instrs true nextLoop contreturn env li in
      let contentif = F.Expr.if_ e content next in
      F.Expr.letrecin loop affected contentif (F.Expr.apply (F.Expr.binding loop) returnenv)
    | A.Instr.Loop (var, from_, end_, li) ->
      let affected = List.filter (fun x -> List.mem x env) @$ BindingSet.elements @$ affected li in
      let var_plus_un = F.Expr.binop (F.Expr.binding var) Ast.Expr.Add (F.Expr.integer 1) in
      let next = instrs suite contsuite contreturn env tl in
      let loop = Fresh.fresh_internal () in
      let returnenv = List.map F.Expr.binding affected in
      let calloop = F.Expr.apply (F.Expr.binding loop) ((var_plus_un)::returnenv) in
      let content = instrs true calloop contreturn env li in
      let c eto_ =
        let content = F.Expr.if_ (F.Expr.binop (F.Expr.binding var) Ast.Expr.LowerEq eto_ )
            content next in
        F.Expr.letrecin loop (var::affected) content
          (F.Expr.apply (F.Expr.binding loop) (from_::returnenv))
      in begin match F.Expr.unfix end_ with
        | F.Expr.BinOp (F.Expr.Fixed.F (_, F.Expr.Lief _), _, F.Expr.Fixed.F (_, F.Expr.Lief _)) (* les variables ne peuvent pas être écrasées là ou apparait c.*)
        | F.Expr.Lief _ -> c end_
        | _ ->
          let n = Fresh.fresh_internal () in
          F.Expr.apply (F.Expr.fun_ [n] (c (F.Expr.binding n))) [end_]
      end
    | A.Instr.AllocArrayConst(name0, t, e, l, _ ) ->
      let l = lief l |> F.Expr.lief in
      let name = Fresh.fresh_internal () in
      let f = F.Expr.fun_ [name] l in
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.apply (F.Expr.fun_ [name0] next) [F.Expr.arrayinit e f]
    | A.Instr.AllocArray (name, t, e, Some (varname, li), _) ->
      let affected = List.filter (fun x -> List.mem x env) @$ BindingSet.elements @$ affected li in
      let o = Fresh.fresh_internal () in
      let envname = Fresh.fresh_internal () in
      let next = instrs suite contsuite contreturn env tl in

      let make, returncont, returnenv, next =
        match affected with
        | [] -> (fun len f _ -> F.Expr.arrayinit len f), None, F.Expr.tuple [], F.Expr.fun_ [name] next
        | [a] ->
          let returncont = F.Expr.fun_ [o] (F.Expr.tuple [F.Expr.binding a; F.Expr.binding o] ) in
          F.Expr.arraymake, Some returncont, F.Expr.binding a, F.Expr.funtuple [a; name] next
        | _ ->
          let returnenv = F.Expr.tuple (List.map F.Expr.binding affected) in
          let returncont = F.Expr.fun_ [o] (F.Expr.tuple [returnenv; F.Expr.binding o] ) in
          F.Expr.arraymake, Some returncont, returnenv, (F.Expr.funtuple [envname; name]
                                                           (F.Expr.apply (F.Expr.funtuple affected next) [F.Expr.binding envname]))
      in
      let content = instrs false contsuite returncont (varname::env) li in
      let content =
        match affected with
        | [] -> content
        | [a] -> F.Expr.fun_ [a] content
        | _ -> F.Expr.funtuple affected content in
      let content = F.Expr.fun_ [varname] content in
      F.Expr.apply next
        [ make e content returnenv]
    | A.Instr.AllocArray (name, t, e, None, _) -> assert false
    | A.Instr.Untuple (vars, e, _) ->
      let vars = List.map (function (_, u) -> u ) vars in
      let tl = instrs suite contsuite contreturn (List.append vars env) tl in
      F.Expr.apply (F.Expr.funtuple vars tl) [e]
    | A.Instr.Tag _ -> assert false      
    | A.Instr.Incr _ | A.Instr.Decr _ -> assert false
    | A.Instr.Unquote _ -> assert false
    | A.Instr.ClikeLoop _ -> assert false
let rec expr e =
  let e = A.Expr.Fixed.Surface.map expr (A.Expr.unfix e) in
  match e with
  | A.Expr.Just e -> F.Expr.just e
  | A.Expr.UnOp (e, op) -> F.Expr.unop e op
  | A.Expr.BinOp (e1, op, e2) -> F.Expr.binop e1 op e2
  | A.Expr.Lief l -> F.Expr.lief (lief l)
  | A.Expr.Access m -> accessmut m
  | A.Expr.Call(funname, params) -> F.Expr.apply (F.Expr.binding (A.UserName funname)) params
  | A.Expr.Tuple li -> F.Expr.tuple li
  | A.Expr.Record r -> F.Expr.record (List.map (fun (a, b) -> b, a) r)
  | A.Expr.Lexems _ -> assert false

let rec instr_to_finstr i = A.Instr.Fixed.Deep.mapg expr i

let instrs suite contsuite contreturn env li =
  let li = List.map instr_to_finstr li in
  instrs suite contsuite contreturn env li

let transform (tyenv, prog) =
  let fonctions = List.filter_map (function
      | Ast.Prog.DeclarFun (name, _, params, is, _) ->
        let params = List.map (fun (n, _) -> n) params in
        let e = instrs false (F.Expr.unit) None params is in
        Some (F.Declaration (A.UserName name, F.Expr.fun_ params e))
      | Ast.Prog.DeclareType (typename, ty) ->
        Some (F.DeclareType (typename, ty))
      | Ast.Prog.Macro (name, ty, params, code) ->
        let params = List.map (fun (n, t) -> n, t) params in
        Some (F.Macro (A.UserName name, ty, params, code))
      | _ -> None) prog.Ast.Prog.funs
  in let declarations = match prog.Ast.Prog.main with
      | None -> fonctions
      | Some m ->
        let main = instrs false (F.Expr.unit) None [] m in
        List.append fonctions [F.Declaration (A.UserName "main", main)]
  in { AstFun.declarations = declarations;
       options = {
         AstFun.reads = prog.Ast.Prog.reads;
         AstFun.hasSkip = prog.Ast.Prog.hasSkip;
       };
       side_effects = IntMap.empty
     }
