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
  functions : StringSet.t;
  parameters : BindingSet.t;
  variables : BindingSet.t;
  array : BindingSet.t;
  types : StringSet.t;
}
let init_acc _ =
  {
    functions = StringSet.empty;
    parameters = BindingSet.empty;
    variables = BindingSet.empty;
    array = BindingSet.empty;
    types = StringSet.empty;
  }

let pbinding f b = match b with
  | UserName s -> Format.fprintf f "%S" s
  | InternalName i -> Format.fprintf f "internal_%d" i

let check_name_0 mem pp funname acc name loc =
  if mem name acc then
    Warner.err funname (fun t () -> Format.fprintf t "%a is re-declared %a" pp name Location.pp loc)

let check_name_s0 funname acc name loc =
  check_name_0 StringSet.mem (fun f s -> Format.fprintf f "%S" s) funname acc name loc

let check_name_b0 funname acc name loc =
  check_name_0 BindingSet.mem pbinding funname acc name loc

let check_nameb funname acc name loc =
  begin
    Option.iter (fun name ->
        check_name_s0 funname acc.functions name loc;
        check_name_s0 funname acc.types name loc;
      ) (get_username name);
    check_name_b0 funname acc.parameters name loc;
    check_name_b0 funname acc.variables name loc;
    check_name_b0 funname acc.array name loc
  end
let check_names funname acc name loc = check_nameb funname acc (UserName name) loc

let add_type_in_acc funname name acc out loc =
  let () = check_names funname acc name loc in
  let acc = { acc with types = StringSet.add name acc.types }
  in acc, out

let add_fun_in_acc funname name acc out loc =
  let () = check_names funname acc name loc in
  let acc = { acc with functions = StringSet.add name acc.functions }
  in acc, out

let add_param_in_acc funname name acc loc =
  let () = check_nameb funname acc name loc in
  let acc = { acc with parameters = BindingSet.add name acc.parameters }
  in acc

let add_array_in_acc funname name acc loc =
  let () = check_nameb funname acc name loc in
  let acc = { acc with array = BindingSet.add name acc.array }
  in acc

let add_local_in_acc funname name acc loc =
  let () = check_nameb funname acc name loc in
  let acc = { acc with variables = BindingSet.add name acc.variables }
  in acc


let is_value funname acc name loc =
  (* TODO if is parameter, change message *)
  if not(BindingSet.mem name acc.variables) &&
     not(BindingSet.mem name acc.parameters) &&
     not(BindingSet.mem name acc.array)
  then
    Warner.err funname (fun t () -> Format.fprintf t "%a is not a local variable %a" pbinding name Ast.Location.pp loc)


let is_local funname acc name loc =
  (* TODO if is parameter, change message *)
  if not(BindingSet.mem name acc.variables) then
    Warner.err funname (fun t () -> Format.fprintf t "%a is not a local variable %a" pbinding name Ast.Location.pp loc)


let is_array funname acc name loc =
  if not(BindingSet.mem name acc.array)
  && not( BindingSet.mem name acc.parameters)
  then
    Warner.err funname (fun t () -> Format.fprintf t "%a is not an array %a" pbinding name Ast.Location.pp loc)

let is_fun funname acc name loc =
  if not(StringSet.mem name acc.functions)
  then
    Warner.err funname (fun t () -> Format.fprintf t "%s is not a function %a" name Ast.Location.pp loc)

let rec check_mutable funname acc mut =
  let loc = Ast.PosMap.get (Mutable.Fixed.annot mut) in
  match Mutable.unfix mut with
  | Mutable.Var (varname) ->
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
    check_expr funname acc e;
    add_local_in_acc funname var acc loc
  | Instr.SelfAffect (mut, _, e)
  | Instr.Affect (mut, e) ->
    check_mutable funname acc mut;
    check_expr funname acc e;
    acc
  | Instr.Incr m | Instr.Decr m -> check_mutable funname acc m; acc
  | Instr.Loop (v, e1, e2, li) ->
    check_expr funname acc e1;
    check_expr funname acc e2;
    let acc2 = add_param_in_acc funname v acc loc in
    let _acc2 = List.fold_left (check_instr funname) acc2 li
    in acc
  | Instr.ClikeLoop (init, cond, incr, li) ->
    let acc_in = List.fold_left (check_instr funname) acc init in
    let _ = List.fold_left (check_instr funname) acc incr in
    let _ = List.fold_left (check_instr funname) acc li in
    check_expr funname acc_in cond;
    acc
  | Instr.While (e, li) ->
    check_expr funname acc e;
    let _ = List.fold_left (check_instr funname) acc li
    in acc
  | Instr.Comment _ -> acc
  | Instr.Return e -> check_expr funname acc e; acc
  | Instr.AllocArrayConst (v, _t, e, _l, _opt) ->
    check_expr funname acc e;
    add_array_in_acc funname v acc loc
  | Instr.AllocArray (v, t, e, liopt, _) ->
    let () = check_expr funname acc e in
    let acc = match liopt with
      | None -> acc
      | Some (varname, li) ->
        check_nameb funname acc varname loc;
        let acc = add_param_in_acc funname varname acc loc in
        List.fold_left (check_instr funname) acc li
    in add_array_in_acc funname v acc loc
  | Instr.AllocRecord (varname, t, li, _) ->
    check_nameb funname acc varname loc;
    List.iter (fun (_field, expr) -> check_expr funname acc expr) li;
    let acc = add_local_in_acc funname varname acc loc in
    acc
  | Instr.If (e, li1, li2) ->
    check_expr funname acc e;
    let _ = List.fold_left (check_instr funname) acc li1 in
    let _ = List.fold_left (check_instr funname) acc li2
    in acc
  | Instr.Call (name, li) ->
    is_fun funname acc name loc;
    List.iter (check_expr funname acc) li;
    acc
  | Instr.Print li ->
    List.iter (function
        | Instr.PrintExpr (_, e) -> check_expr funname acc e
        | Instr.StringConst s -> ()
      ) li;
    acc
  | Instr.Read li ->
    List.fold_left (fun acc -> function
        | Instr.Separation -> acc
        | Instr.DeclRead (t, v, _) -> add_local_in_acc funname v acc loc
        | Instr.ReadExpr (ty, mut) -> check_mutable funname acc mut; acc)
      acc li
  | Instr.Unquote e -> check_expr funname acc e; acc
  | Instr.Untuple (li, e, _) ->
    check_expr funname acc e;
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
