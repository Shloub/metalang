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
   Crée un accumulateur qui contient les fonctions récursives.
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open PassesUtils

type acc0 = unit
type 'lex acc = StringSet.t
let init_acc () = StringSet.empty

let is_rec funname instrs =
  let is_rec i =
    Instr.Writer.Deep.fold (fun acc i -> match Instr.unfix i with
        | Instr.Call (name, _) -> acc || name = funname
        | _ -> acc
      ) false i ||
    Instr.Fixed.Deep.foldg (fun e acc ->
        Expr.Writer.Deep.fold (fun acc e -> match Expr.unfix e with
            | Expr.Call (name, _) -> acc || name = funname
            | _ -> acc
          ) acc e
      ) i false
  in List.fold_left (fun acc i -> acc || is_rec i) false instrs

let process_main acc instrs = acc, instrs

let process acc i = match i with
  | Prog.DeclarFun (name, _, _, instrs, _ ) ->
    let acc = if is_rec name instrs then StringSet.add name acc else acc in
    acc, i
  | _ -> acc, i
