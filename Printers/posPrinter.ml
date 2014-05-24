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


(** positions printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Printer

class posPrinter = object(self)
  inherit printer as super

  method hidden func f p =
    Format.fprintf f "\x1b[2m%a\x1b[22m" func p

  method typed f e =
    if not ( Typer.typed typerEnv e) then
      Format.fprintf f "\x1b[31mNot Typed\x1b[0m"

  method annot f i =
    Format.fprintf f "\x1b[32m[%i]\x1b[0m" i

  method ploc (f : Format.formatter) (loc : Ast.location) : unit = self#hidden Warner.ploc f loc

  method expr f e =
    let loc = Ast.PosMap.get (Expr.Fixed.annot e) in
    Format.fprintf f "%a%a%a%a"
      self#ploc loc
      self#annot (Expr.Fixed.annot e)
      self#typed e
      super#expr e

  method instr f e =
    let loc = Ast.PosMap.get (Instr.Fixed.annot e) in
    Format.fprintf f "%a%a%a"
      self#ploc loc
      self#annot (Instr.Fixed.annot e)
      super#instr e

  method ptype f e =
    let loc = Ast.PosMap.get (Type.Fixed.annot e) in
    Format.fprintf f "%a%a"
      self#ploc loc super#ptype e

  method mutable_ f e =
    let loc = Ast.PosMap.get (Mutable.Fixed.annot e) in
    Format.fprintf f "%a%a"
      self#ploc loc super#mutable_ e

end
