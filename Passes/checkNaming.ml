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


(** Name checking :
    cette passe vérifie que l'on utilise bien des noms de variable corrects
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

type acc0 = unit
type 'a acc = {
  functions : BindingSet.t;
  parameters : BindingSet.t;
  variables : BindingSet.t;
  array : BindingSet.t;
  types : BindingSet.t;
}
let init_acc _ =
  {
    functions = BindingSet.empty;
    parameters = BindingSet.empty;
    variables = BindingSet.empty;
    array = BindingSet.empty;
    types = BindingSet.empty;
  }

let check_name0 funname acc name loc =
  if BindingSet.mem name acc then
    Warner.err funname (fun t () -> Format.fprintf t "%s is re-declared %a" name Warner.ploc loc)

let check_name funname acc name loc =
  begin
    check_name0 funname acc.functions name loc;
    check_name0 funname acc.parameters name loc;
    check_name0 funname acc.variables name loc;
    check_name0 funname acc.types name loc;
    check_name0 funname acc.array name loc
  end

let add_type_in_acc funname name acc out loc =
  let () = check_name funname acc name loc in
  let acc = { acc with types = BindingSet.add name acc.types }
  in acc, out

let add_fun_in_acc funname name acc out loc =
  let () = check_name funname acc name loc in
  let acc = { acc with functions = BindingSet.add name acc.functions }
  in acc, out

let add_param_in_acc funname name acc loc =
  let () = check_name funname acc name loc in
  let acc = { acc with parameters = BindingSet.add name acc.parameters }
  in acc

let add_array_in_acc funname name acc loc =
  let () = check_name funname acc name loc in
  let acc = { acc with array = BindingSet.add name acc.array }
  in acc

let add_local_in_acc funname name acc loc =
  let () = check_name funname acc name loc in
  let acc = { acc with variables = BindingSet.add name acc.variables }
  in acc


let is_value funname acc name loc =
  (* TODO if is parameter, change message *)
  if not(BindingSet.mem name acc.variables) &&
    not(BindingSet.mem name acc.parameters) &&
    not(BindingSet.mem name acc.array)
  then
    Warner.err funname (fun t () -> Format.fprintf t "%s is not a local variable %a" name Warner.ploc loc)


let is_local funname acc name loc =
  (* TODO if is parameter, change message *)
  if not(BindingSet.mem name acc.variables) then
    Warner.err funname (fun t () -> Format.fprintf t "%s is not a local variable %a" name Warner.ploc loc)


let is_array funname acc name loc =
  if not(BindingSet.mem name acc.array)
    && not( BindingSet.mem name acc.parameters)
  then
    Warner.err funname (fun t () -> Format.fprintf t "%s is not an array %a" name Warner.ploc loc)

let is_fun funname acc name loc =
  if not(BindingSet.mem name acc.functions)
  then
    Warner.err funname (fun t () -> Format.fprintf t "%s is not a function %a" name Warner.ploc loc)

let rec check_mutable funname acc mut =
  let loc = Ast.PosMap.get (Mutable.Fixed.annot mut) in
  match Mutable.unfix mut with
  | Mutable.Var varname ->
    is_value funname acc varname loc
  | Mutable.Array (mut, li) ->
    begin
      check_mutable funname acc mut;
      List.iter (check_expr funname acc) li;
    end
  | Mutable.Dot (mut, field) ->
    check_mutable funname acc mut

and check_expr funname acc e =
  let f () e =
    let loc = Ast.PosMap.get (Expr.Fixed.annot e) in
    match Expr.unfix e with
    | Expr.Access m ->
      check_mutable funname acc m
    | Expr.Call (function_, _) ->
      is_fun funname acc function_ loc
    | _ -> ()
  in
  Expr.Writer.Deep.fold
    f
    (f () e)
    e

let rec check_instr funname acc instr =
  let loc = Ast.PosMap.get (Instr.Fixed.annot instr) in
  match Instr.unfix instr with
  | Instr.Tag _ -> acc
  | Instr.Declare (var, t, e, _) ->
    let () = check_expr funname acc e in
    add_local_in_acc funname var acc loc
  | Instr.Affect (mut, e) ->
    let () = check_mutable funname acc mut in
    let () = check_expr funname acc e in
    acc
  | Instr.Loop (v, e1, e2, li) ->
    let () = check_expr funname acc e1 in
    let () = check_expr funname acc e2 in
    let acc2 = add_param_in_acc funname v acc loc in
    let _acc2 = List.fold_left (check_instr funname) acc2 li
    in acc
  | Instr.While (e, li) ->
    let () = check_expr funname acc e in
    let _ = List.fold_left (check_instr funname) acc li
    in acc
  | Instr.Comment _ -> acc
  | Instr.Return e ->
    let () = check_expr funname acc e in acc
  | Instr.AllocArray (v, t, e, liopt, _) ->
    let () = check_expr funname acc e in
    let acc = match liopt with
      | None -> acc
      | Some (varname, li) ->
        let () = check_name funname acc varname loc in
        let acc = add_param_in_acc funname varname acc loc in
        List.fold_left (check_instr funname) acc li
    in add_array_in_acc funname v acc loc
  | Instr.AllocRecord (varname, t, li, _) ->
    let () = check_name funname acc varname loc in
    let () = List.iter (fun (_field, expr) ->
      check_expr funname acc expr) li
    in
    let acc = add_local_in_acc funname varname acc loc in
    acc
  | Instr.If (e, li1, li2) ->
    let () = check_expr funname acc e in
    let _ = List.fold_left (check_instr funname) acc li1 in
    let _ = List.fold_left (check_instr funname) acc li2
    in acc
  | Instr.Call (name, li) ->
    let () = is_fun funname acc name loc in
    let () = List.iter (check_expr funname acc) li
    in acc
  | Instr.Print (t, e) ->
    let () = check_expr funname acc e in acc
  | Instr.DeclRead (t, v, _) ->
    add_local_in_acc funname v acc loc
  | Instr.Read (t, mut) ->
    let () = check_mutable funname acc mut in
    acc
  | Instr.StdinSep -> acc
  | Instr.Unquote e ->
    let () = check_expr funname acc e in acc
  | Instr.Untuple (li, e, _) ->
    let () = check_expr funname acc e in
    List.fold_left (fun acc (_, name) ->
      add_local_in_acc funname name acc loc) acc li


let process acc f =
  match f with
  | Prog.Unquote e ->
    let () = check_expr "toplvl" acc e in acc, f
  | Prog.Macro (name, ty, _, _) ->
    add_fun_in_acc name name acc f (Ast.PosMap.get (Type.Fixed.annot ty))
  | Prog.Comment _ -> acc, f
  | Prog.DeclareType (name, ty) ->
    add_type_in_acc name name acc f (Ast.PosMap.get (Type.Fixed.annot ty))
  | Prog.DeclarFun (funname, t, params, instrs, _) ->
    let loc = Ast.PosMap.get (Type.Fixed.annot t) in
    let acc, f = add_fun_in_acc funname funname acc f loc in
    let acc0 = List.fold_left (fun acc (name, t) ->
      add_param_in_acc funname name acc loc
    ) acc params in
    let _ = List.fold_left (check_instr funname) acc0 instrs
    in acc, f
let process_main acc f =
  let _ = List.fold_left (check_instr "main") acc f in
  (acc, f)
