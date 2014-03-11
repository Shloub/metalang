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


(** Cette passe effectue une normalisation du printing de booleans
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib

open Ast
open Fresh
open PassesUtils

  type acc0 = unit

  let rec write_bool e =
    Instr.if_ (Expr.access (Mutable.var e))
      [ Instr.print Type.string (Expr.string "True") ]
      [ Instr.print Type.string (Expr.string "False") ]

  let rec rewrite (i : 'lex Instr.t) : 'lex Instr.t list = match
  Instr.unfix i with
    | Instr.Print(Type.Fixed.F (_, Type.Bool), Expr.Fixed.F (annot,
                                                 Expr.Access ( Mutable.Fixed.F
                                                                 (_, Mutable.Var b))
    ) ) ->
      [write_bool b]
    | j -> [ Instr.deep_map_bloc (List.flatten @* List.map rewrite) j |> Instr.fixa (Instr.Fixed.annot i) ]

  type 'lex acc = unit
  let init_acc _ = ()
  let process acc i =
    acc, List.map rewrite i |> List.flatten

