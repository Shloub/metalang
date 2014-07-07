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
 *)

(** Some passes
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

type acc0 = unit
type 'a acc = BindingSet.t

let init_acc () = BindingSet.empty

let process_expr acc e =
  let f acc e = match Expr.Fixed.unfix e with
    | Expr.Call (funname, _) -> BindingSet.add funname acc
    | e -> acc
  in Expr.Writer.Deep.fold f acc e

let collect_instr acc i =
  let f acc i =
    match Instr.unfix i with
    | Instr.Call (name, li) -> BindingSet.add name acc
    | _ -> acc
  in
  let acc = Instr.Writer.Deep.fold f acc i
  in Instr.fold_expr process_expr acc i

let process_main acc m = (List.fold_left collect_instr acc m), m

let process acc p =
  let acc = match p with
    | Prog.DeclarFun (_funname, _t, _params, instrs, _) ->
      List.fold_left collect_instr (BindingSet.add _funname acc) instrs
    | _ -> acc
  in acc, p
