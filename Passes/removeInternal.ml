(*
 * Copyright (c) 2017, Prologin
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
 *)

(** passe qui sert à nommer les variables internes
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)


open Ext

open Ast
open Fresh
open PassesUtils

type acc0 = unit
type 'lex acc = varname IntMap.t

let init_acc () = IntMap.empty

let map_name acc = function
  | InternalName i -> begin match IntMap.find_opt i acc with
      | Some s -> acc, s
      | None ->
        let newname = UserName (Fresh.fresh_user ()) in
        let acc = IntMap.add i newname acc in
        acc, newname
    end
  | x -> acc, x

let map_mut acc mut = Mutable.Writer.Deep.map (fun m -> match Mutable.unfix m with
    | Mutable.Var v ->
      let annot = Mutable.Fixed.annot m in
      let _, v = map_name acc v in
      Mutable.Var v |> Mutable.Fixed.fixa annot
    | _ -> m) mut

let map_expr acc e =
  Expr.Writer.Deep.map (fun e -> match Expr.unfix e with
      | Expr.Access mut ->
        let annot = Expr.Fixed.annot e in
        Expr.Access (map_mut acc mut) |> Expr.Fixed.fixa annot
      | _ -> e) e

let fold_map_instr acc instr =
  let annot = Instr.Fixed.annot instr in
  match Instr.unfix instr with
  | Instr.Declare (name, ty, e, opt) ->
    let acc, name = map_name acc name in
    acc, Instr.Declare (name, ty, e, opt) |> Instr.fixa annot
  | Instr.Loop (v, e1, e2, li) ->
    let acc, v = map_name acc v in
    acc, Instr.Loop (v, e1, e2, li) |> Instr.fixa annot
  | Instr.AllocArray (name, ty, e, Some ((name2, li)), opt) ->
    let acc, name = map_name acc name in
    let acc, name2 = map_name acc name2 in
    acc, Instr.AllocArray (name, ty, e, Some ((name2, li)), opt) |> Instr.fixa annot
  | Instr.AllocArray (name, ty, e, None, opt) ->
    let acc, name = map_name acc name in
    acc, Instr.AllocArray (name, ty, e, None, opt) |> Instr.fixa annot
  | Instr.AllocRecord (name, ty, fields, opt) ->
    let acc, name = map_name acc name in
    acc, Instr.AllocRecord (name, ty, fields, opt) |> Instr.fixa annot
  | Instr.Untuple (li, e, opt) ->
    let acc, li = List.fold_left_map (fun acc (ty, name) ->
        let acc, name = map_name acc name in
        acc, (ty, name)) acc li in
    acc, Instr.Untuple (li, e, opt) |> Instr.fixa annot
  | Instr.Affect (mut, e) ->
    let mut = map_mut acc mut in
    acc, Instr.Affect(mut, e) |> Instr.fixa annot
  | Instr.Read li ->
    let acc, li = List.fold_left_map (fun acc -> function
        | Instr.DeclRead (ty, name, opt) ->
          let acc, name = map_name acc name in
          acc, Instr.DeclRead (ty, name, opt)
        | Instr.Separation -> acc, Instr.Separation
        | Instr.ReadExpr (ty, mut) ->
          let mut = map_mut acc mut in
          acc, Instr.ReadExpr (ty, mut) ) acc li
    in acc, Instr.Read li |> Instr.fixa annot
  | _ -> acc, instr

let fold_map_instr acc instr =
  let acc, instr = fold_map_instr acc instr in
  let acc, instr = Instr.Writer.Deep.foldmap fold_map_instr acc instr in
  let instr = Instr.Fixed.Deep.mapg (map_expr acc) instr in
  acc, instr

let rec fold_map_instrs acc (instrs : Utils.instr list) =
  List.fold_left_map fold_map_instr acc instrs

let process (acc: 'a acc) (i:Utils.t_fun) = match i with
  | Prog.DeclarFun (name, ty, params, instrs, opt ) ->
    let acc, params = List.fold_left_map (fun acc (name, ty) ->
        let acc, name = map_name acc name in
        acc, (name, ty)
      ) acc params in
    let acc, instrs = fold_map_instrs acc instrs in
    acc, Prog.DeclarFun (name, ty, params, instrs, opt)
  | _ -> acc, i

let process_main acc instrs =
  fold_map_instrs acc instrs
