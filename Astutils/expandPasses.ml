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
* @see http://prologin.org
* @author Prologin <info@prologin.org>
* @author Maxime Audouin <coucou747@gmail.com>
*
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

module NoPend : SigPass = struct
  type acc = unit
  let process (acc:acc) i =
    let rec inner_map t : Instr.t list =
      match Instr.unfix t with

	| Instr.AllocArray(_, _, Expr.F (_, Expr.Binding _), _)
	| Instr.Print(_, Expr.F (_, Expr.Binding _)) ->
	  [fixed_map t]
	| Instr.Print(t, e) ->
	  let b = fresh () in
	  [
	    Instr.Declare (b, t, e) |> Instr.fix;
	    Instr.Print(t, Expr.binding b) |> Instr.fix;
	  ]
	| Instr.AllocArray(b0, t, e, lambdaopt) ->
	  let b = fresh () in
	  [
	    Instr.Declare (b, Type.integer, e) |> Instr.fix;
	    Instr.AllocArray(b0, t, Expr.binding b, lambdaopt) |> Instr.fix;
	  ]
	| _ -> [fixed_map t]
    and fixed_map (t:Instr.t) =
      Instr.map_bloc
	(List.flatten @* (List.map inner_map))
	(Instr.unfix t)
	|> Instr.fix
    in acc, List.flatten (List.map inner_map i)
  let init_acc _ = ();;
end


module AllocArrayExpend : SigPass = struct
  type acc = unit;;
  let init_acc () = ();;

  let mapret tab index instructions =
    let f tra i = match Instr.unfix i with
      | Instr.Return e -> Instr.affect (Instr.mutable_array (Instr.mutable_var tab) [Expr.binding index]) e
      | Instr.AllocArray _ -> i
      | _ -> tra i
    in let instructions = List.map (f (Instr.Writer.Traverse.map f)) instructions in
     instructions

  let expand i = match Instr.unfix i with
    | Instr.AllocArray (b,t, len, Some (b2, instrs)) ->
      [ Instr.fix (Instr.AllocArray (b, t, len, None) );
	Instr.loop b2 (Expr.integer 0) (Expr.binop Expr.Sub len (Expr.integer 1))
	  (mapret b b2 instrs)
      ]
    | _ -> [i]

  let mapi i =
    Instr.map_bloc
      (List.flatten @* (List.map expand) )
      (Instr.unfix i) |> Instr.fix

  let process () is = (), List.map mapi (List.flatten (List.map expand is))
end


module ExpandReadDecl : SigPass = struct
  type acc = unit;;
  let init_acc () = ();;

  let expand i = match Instr.unfix i with
    | Instr.DeclRead (t, binding) ->
      [ Instr.fix (Instr.Declare (binding, t, Expr.default_value t) );
	Instr.read t (Instr.mutable_var binding);
      ]
    | _ -> [i]

  let mapi i =
    Instr.map_bloc
      (List.flatten @* (List.map expand) )
      (Instr.unfix i) |> Instr.fix

  let process () is = (), List.map mapi (List.flatten (List.map expand is))

end

module ExpandPrint : SigPass = struct
  
  let rec write_bool e =
    Instr.if_ (Expr.binding e)
      [ Instr.print Type.string (Expr.string "True") ]
      [ Instr.print Type.string (Expr.string "False") ]

  let rec write t b =
    let i = fresh () in
    let b2 = fresh () in
    let b2e = Expr.access (Mutable.array (Mutable.var b) [Expr.binding i]) in
    let b2i = Instr.declare b2 t b2e
    in
    [
	 (* Instr.declare i Type.integer (Expr.integer 0); *)
      Instr.loop i (Expr.integer 0)
	(Expr.binop
	   Expr.Sub
	   (Expr.length b)
	   (Expr.integer 1))
	(
	  match t with
	    | Type.F ( Type.Array t2) -> (b2i) :: (write t2 b2)
	    | Type.F Type.Bool -> [b2i ; write_bool b2]
	    | _ -> [ Instr.print t b2e]
	)
    ]

  let rec rewrite (i : Instr.t) : Instr.t list = match Instr.unfix i with
    | Instr.Print(Type.F (Type.Array t), Expr.F (annot, Expr.Binding b) ) ->
      write t b
    | Instr.Print(Type.F (Type.Bool), Expr.F (annot, Expr.Binding b) ) ->
      [write_bool b]
    | j -> [ Instr.map_bloc (List.flatten @* List.map rewrite) j |> Instr.fix ]

  type acc = unit
  let init_acc _ = ()
  let process acc i =
    acc, List.map rewrite i |> List.flatten
end
