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


(** Some expantion passes
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib

open Ast
open Fresh
open PassesUtils

module NoPend : SigPass with type acc0 = unit = struct
  type acc0 = unit
  type 'lex acc = unit

  let locate loc instr =
    PosMap.add (Instr.Fixed.annot instr) loc; instr

  let locatee loc e =
    PosMap.add (Expr.Fixed.annot e) loc; e

  let locatem loc m =
    PosMap.add (Mutable.Fixed.annot m) loc; m

  let rec process (acc:'lex acc) i =
    let rec inner_map t0 : 'lex Instr.t list =
      match Instr.unfix t0 with
        | Instr.AllocArray(
          _, _,
          Expr.Fixed.F (_, Expr.Access (
            Mutable.Fixed.F
              (_, Mutable.Var _))), _)
        | Instr.Print(_, Expr.Fixed.F
          (_,
           (Expr.Access ( Mutable.Fixed.F
                            (_, Mutable.Var _))
               | Expr.Char _
               | Expr.String _
               | Expr.Float _
               | Expr.Integer _
               | Expr.Bool _
           )
          )) ->
          [fixed_map t0]
        | Instr.Print(t, e) ->
	  let annot = Instr.Fixed.annot t0 in
          let loc = PosMap.get (Instr.Fixed.annot t0) in
          let b = fresh () in
          [
            Instr.Declare (b, t, e) |> Instr.fixa annot |> locate loc;
            Instr.Print(t, locatee loc (Expr.access (locatem loc (Mutable.var b))))
          |> Instr.fixa annot |> locate loc;
          ]
        | Instr.AllocArray(b0, t, e, lambdaopt) ->
	  let annot = Instr.Fixed.annot t0 in
          let lambdaopt = match lambdaopt with
            | None -> None
            | Some (name, li) ->
              let li = List.map inner_map li in
              let li = List.flatten li in
              Some (name, li)
          in
          let loc = PosMap.get (Instr.Fixed.annot t0) in
          let b = fresh () in
          [
            Instr.Declare (b, Type.integer, e) |> Instr.fixa annot;
            Instr.AllocArray(b0, t,
                             Expr.access (Mutable.var b),
                             lambdaopt) |> Instr.fixa annot  |> locate loc;
          ]
        | _ -> [fixed_map t0]
    and fixed_map (t:'lex Instr.t) =
      Instr.deep_map_bloc
        (List.flatten @* (List.map inner_map))
        (Instr.unfix t)
        |> Instr.fixa (Instr.Fixed.annot t)
    in acc, List.flatten (List.map inner_map i);;
  let init_acc _ = ();;
end


module AllocArrayExpend : SigPass with type acc0 = unit = struct
  type acc0 = unit
  type 'lex acc = unit;;
  let init_acc () = ();;

  let locate loc e =
    PosMap.add (Expr.Fixed.annot e) loc; e

  let locatm loc m =
    PosMap.add (Mutable.Fixed.annot m) loc; m

  let locati loc instr =
    PosMap.add (Instr.Fixed.annot instr) loc; instr


  let mapret tab index instructions =
    let f tra i = match Instr.unfix i with
      | Instr.Return e -> Instr.affect
        (Instr.mutable_array
           (Instr.mutable_var tab
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

  let expand i = match Instr.unfix i with
    | Instr.AllocArray (b,t, len, Some (b2, instrs)) ->
      let annot = Instr.Fixed.annot i in
      [ Instr.fixa annot (Instr.AllocArray (b, t, len, None) )
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

  let mapi i =
    Instr.deep_map_bloc
      (List.flatten @* (List.map expand) )
      (Instr.unfix i) |> Instr.fixa (Instr.Fixed.annot i)

  let process () is = (), List.map mapi (List.flatten (List.map expand is))
end

module ExpandReadDecl : SigPass with type acc0 = unit = struct
  type acc0 = unit
  type 'lex acc = unit;;
  let init_acc () = ();;

  let expand i = match Instr.unfix i with
    | Instr.DeclRead (t, binding) ->
      [ Instr.fixa (Instr.Fixed.annot i) (Instr.Declare (binding, t, Expr.default_value t) );
        Instr.fixa (Instr.Fixed.annot i) (Instr.Read (t, (Instr.mutable_var binding)));
      ]
    | _ -> [i]

  let mapi i =
    Instr.deep_map_bloc
      (List.flatten @* (List.map expand) )
      (Instr.unfix i) |> Instr.fixa (Instr.Fixed.annot i)

  let process () is = (), List.map mapi (List.flatten (List.map expand is))

end

module ExpandPrint : SigPass with type acc0 = unit = struct
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
end
