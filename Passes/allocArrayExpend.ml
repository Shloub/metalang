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


(** Cette passe permet de supprimer la construction :
    def array<...> toto[len] with i do ... end
    Pour en faire une boucle for

    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib

open Ast
open Fresh
open PassesUtils

type acc0 = bool
type 'lex acc = {
    make_arrayconst : bool
  }
let init_acc b = {
  make_arrayconst = b;
}

let locate loc e =
  PosMap.add (Expr.Fixed.annot e) loc; e

let locatm loc m =
  PosMap.add (Mutable.Fixed.annot m) loc; m

let locati loc instr =
  PosMap.add (Instr.Fixed.annot instr) loc; instr


let mapret tab index instructions =
  let f tra i = match Instr.unfix i with
    | Instr.Return e -> Instr.affect
      (Mutable.array
         (Mutable.var tab
             |> locatm (PosMap.get (Expr.Fixed.annot e))
         ) [Expr.access (Mutable.var index
                            |> locatm (PosMap.get (Expr.Fixed.annot e))
         )
           |> locate (PosMap.get (Expr.Fixed.annot e))
           ]) e
    | Instr.AllocArray _ -> i
    | _ -> tra i
  in let instructions = List.map
       (f (Instr.Writer.Traverse.map f)) instructions in
     instructions

let get_const_expr e = match Expr.unfix e with
| Expr.Lief l -> Some l
| _ -> None

let get_const_return li =
  let li = List.filter (fun i -> match Instr.unfix i with
  | Instr.Comment _ -> false
  | _ -> true) li
  in match List.map Instr.unfix li with
  | [ Instr.Return e ] ->
      get_const_expr e
  | _ ->  None

let is_const_return li = None <> get_const_return li

let expand acc i = match Instr.unfix i with
  | Instr.AllocArray (b,t, len, Some (b2, instrs), opt)
    when acc.make_arrayconst &&
      is_const_return instrs ->
      let e = Option.extract (get_const_return instrs)
      and annot = Instr.Fixed.annot i
      in
      [ Instr.fixa annot (Instr.AllocArrayConst (b, t, len, e, opt)) ]
  | Instr.AllocArray (b,t, len, Some (b2, instrs), opt) ->
    let annot = Instr.Fixed.annot i in
    [ Instr.fixa annot (Instr.AllocArray (b, t, len, None, opt) )
    |> locati (PosMap.get (Instr.Fixed.annot i))
    ;
      Instr.loop b2 (Expr.integer 0)
        (Expr.binop Expr.Sub len (Expr.integer 1)
            |> locate (PosMap.get (Expr.Fixed.annot len))
        )
        (mapret b b2 instrs)
    |> locati (PosMap.get (Instr.Fixed.annot i))
    ]
  | _ -> [i]

let mapi acc i =
  Instr.deep_map_bloc
    (List.flatten @* (List.map (expand acc)))
    (Instr.unfix i) |> Instr.fixa (Instr.Fixed.annot i)

let process acc is = acc, List.map (mapi acc) (List.flatten (List.map (expand acc) is))
