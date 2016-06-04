(*
 * Copyright (c) 2016, Prologin
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
   Cette passe permet de transformer une boucle type pascal en boucle C

   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
 *)

open Stdlib
open Ast

type acc0 = unit
type 'a acc = unit
let init_acc () = ()

let process () li =
  (), List.map (fun i ->
    Instr.Writer.Deep.map (fun i -> match Instr.unfix i with
    | Instr.Loop (varname, startvalue, endvalue, li) ->
        let var () = Mutable.var varname in
        let accessvar () = Expr.access (var ()) in
        let declaration = Instr.declare varname Type.integer startvalue Instr.useless_declaration_option in
        let comparison = Expr.binop Expr.LowerEq (accessvar ()) endvalue in
        let incr = Instr.affect (var ()) (Expr.add (accessvar ()) (Expr.integer 1)) in
        let i' = Instr.ClikeLoop([declaration], comparison, [incr], li)
        in Instr.fixa (Instr.Fixed.annot i) i'
    | _ -> i ) i ) li
