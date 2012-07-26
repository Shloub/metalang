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


(** Some checking passes like name checking
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

module CheckNaming : SigPassTop = struct
  type acc = {
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

  let check_name0 funname acc name =
    if BindingSet.mem name acc then
      Warner.err funname (fun t () -> Format.fprintf t "%s is re-declared" name)

  let check_name funname acc name =
    begin
      check_name0 funname acc.functions name;
      check_name0 funname acc.parameters name;
      check_name0 funname acc.variables name;
      check_name0 funname acc.types name;
      check_name0 funname acc.array name
    end

  let add_type_in_acc funname name acc out =
    let () = check_name funname acc name in
    let acc = { acc with types = BindingSet.add name acc.types }
    in acc, out

  let add_fun_in_acc funname name acc out =
    let () = check_name funname acc name in
    let acc = { acc with functions = BindingSet.add name acc.functions }
    in acc, out

  let add_param_in_acc funname name acc  =
    let () = check_name funname acc name in
    let acc = { acc with parameters = BindingSet.add name acc.parameters }
    in acc

  let add_array_in_acc funname name acc  =
    let () = check_name funname acc name in
    let acc = { acc with array = BindingSet.add name acc.array }
    in acc

  let add_local_in_acc funname name acc  =
    let () = check_name funname acc name in
    let acc = { acc with variables = BindingSet.add name acc.variables }
    in acc


  let is_value funname acc name =
    (* TODO if is parameter, change message *)
    if not(BindingSet.mem name acc.variables) &&
      not(BindingSet.mem name acc.parameters) &&
      not(BindingSet.mem name acc.array)
    then
      Warner.err funname (fun t () -> Format.fprintf t "%s is not a local variable" name)


  let is_local funname acc name =
    (* TODO if is parameter, change message *)
    if not(BindingSet.mem name acc.variables) then
      Warner.err funname (fun t () -> Format.fprintf t "%s is not a local variable" name)


  let is_array funname acc name =
    if not(BindingSet.mem name acc.array)
      && not( BindingSet.mem name acc.parameters)
    then
      Warner.err funname (fun t () -> Format.fprintf t "%s is not an array" name)

  let is_fun funname acc name =
    if not(BindingSet.mem name acc.functions)
    then
      Warner.err funname (fun t () -> Format.fprintf t "%s is not a function" name)

  let rec check_mutable funname acc mut =
    match Mutable.unfix mut with
      | Mutable.Var varname ->
        is_value funname acc varname
      | Mutable.Array (mut, li) ->
        begin
          check_mutable funname acc mut;
          List.iter (check_expr funname acc) li;
        end
      | Mutable.Dot (mut, field) ->
        check_mutable funname acc mut

  and check_expr funname acc e =
    let f () e =
      match Expr.unfix e with
        | Expr.Length m
        | Expr.Access m ->
          check_mutable funname acc m
        | Expr.Call (function_, _) ->
          is_fun funname acc function_
        | _ -> ()
    in
    Expr.Writer.Deep.fold
      f
      (f () e)
      e

  let rec check_instr funname acc instr =
    match Instr.unfix instr with
      | Instr.Declare (var, t, e) ->
        let () = check_expr funname acc e in
        add_local_in_acc funname var acc
      | Instr.Affect (mut, e) ->
        let () = check_mutable funname acc mut in
        let () = check_expr funname acc e in
        acc
      | Instr.Loop (v, e1, e2, li) ->
        let () = check_expr funname acc e1 in
        let () = check_expr funname acc e2 in
        let acc2 = add_param_in_acc funname v acc in
        let _acc2 = List.fold_left (check_instr funname) acc2 li
        in acc
      | Instr.While (e, li) ->
        let () = check_expr funname acc e in
        let _ = List.fold_left (check_instr funname) acc li
        in acc
      | Instr.Comment _ -> acc
      | Instr.Return e ->
        let () = check_expr funname acc e in acc
      | Instr.AllocArray (v, t, e, liopt) ->
        let () = check_expr funname acc e in
        let _ = match liopt with
          | None -> acc
          | Some (varname, li) ->
            let () = check_name funname acc varname in
            let acc = add_param_in_acc funname varname acc in
            List.fold_left (check_instr funname) acc li
        in add_array_in_acc funname v acc
      | Instr.AllocRecord (varname, t, li) ->
        let () = check_name funname acc varname in
        let () = List.iter (fun (_field, expr) ->
          check_expr funname acc expr) li
        in
        let acc = add_local_in_acc funname varname acc in
        acc
      | Instr.If (e, li1, li2) ->
        let () = check_expr funname acc e in
        let _ = List.fold_left (check_instr funname) acc li1 in
        let _ = List.fold_left (check_instr funname) acc li2
        in acc
      | Instr.Call (name, li) ->
        let () = is_fun funname acc name in
        let () = List.iter (check_expr funname acc) li
        in acc
      | Instr.Print (t, e) ->
        let () = check_expr funname acc e in acc
      | Instr.DeclRead (t, v) ->
        add_local_in_acc funname v acc
      | Instr.Read (t, mut) ->
        let () = check_mutable funname acc mut in
        acc
      | Instr.StdinSep -> acc

  let process acc f =
    match f with
      | Prog.Macro (name, _, _, _) ->
        add_fun_in_acc name name acc f
      | Prog.Comment _ -> acc, f
      | Prog.DeclareType (name, _) ->
        add_type_in_acc name name acc f
      | Prog.DeclarFun (funname, t, params, instrs) ->
        let acc, f = add_fun_in_acc funname funname acc f in
        let acc0 = List.fold_left (fun acc (name, t) ->
          add_param_in_acc funname name acc
        ) acc params in
        let _ = List.fold_left (check_instr funname) acc0 instrs
        in acc, f
  let process_main acc f =
    let _ = List.fold_left (check_instr "main") acc f in
    (acc, f)
end
