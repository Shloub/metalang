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

(** Error and Warning reporter
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)

let ploc f ((l1, c1), (l2, c2)) =
  if l1 = l2 then
    Format.fprintf f "(on %d:%d-%d)"
      l1 c1 c2
  else
    Format.fprintf f "(on %d:%d to %d:%d)"
    l1 c1 l2 c2


let loc_of li =
match li with
| hd::tl ->
  let a = List.hd li in
  let b = List.hd (List.rev li) in
  let a = Ast.PosMap.get (Ast.Instr.Fixed.annot a) in
  let b = Ast.PosMap.get (Ast.Instr.Fixed.annot b) in
  Ast.merge_positions a b
| [] ->  Ast.default_location

let warn funname msg =
  Format.fprintf Format.std_formatter
    "Warning : in function %s,@\n@[<h>  %a@]@\n" funname msg ()

exception Error of (Format.formatter -> unit);;

let err funname msg =
  raise (Error (fun f ->
    Format.fprintf f
      "Error : in function %s,@\n@[<h>  %a@]@\n" funname msg ()))
