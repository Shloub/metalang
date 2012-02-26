open Stdlib

open Ast
open Fresh

module type SigPass = sig
  type acc;;
  val init_acc : unit -> acc;;
  val process : acc -> Instr.t list -> (acc * Instr.t list)
end
module NoPend : SigPass = struct
  type acc = unit
  let process (acc:acc) i =
    let rec inner_map t : Instr.t list =
      match Instr.unfix t with

	| Instr.AllocArray(_, _, Expr.F (_, Expr.Binding _))
	| Instr.Print(_, Expr.F (_, Expr.Binding _)) ->
	  [fixed_map t]
	| Instr.Print(t, e) ->
	  let b = fresh () in
	  [
	    Instr.Declare (b, t, e) |> Instr.fix;
	    Instr.Print(t, Expr.binding b) |> Instr.fix;
	  ]
	| Instr.AllocArray(b0, t, e) ->
	  let b = fresh () in
	  [
	    Instr.Declare (b, t, e) |> Instr.fix;
	    Instr.AllocArray(b0, t, Expr.binding b) |> Instr.fix;
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

module ExpandPrint : SigPass = struct
  let rec write t b =
    let i = fresh ()
    in let b2 = fresh ()
    in let b2i = Instr.declare b2 Type.integer (Expr.access_array b (Expr.binding i))
       in
       [ Instr.declare i Type.integer (Expr.integer 0);
	 Instr.loop i (Expr.integer 0) (Expr.length b) (Expr.integer 1)
	   (
	     match t with
	       | Type.F ( Type.Array _) -> write t b2
	       | _ -> [ b2i ; Instr.print t (Expr.binding b2 )]
	   )
       ]

  let rec rewrite (i : Instr.t) : Instr.t list = match Instr.unfix i with
    | Instr.Print(Type.F (Type.Array t), Expr.F (annot, Expr.Binding b) ) ->
      write t b
    | j -> [ Instr.map_bloc (List.flatten @* List.map rewrite) j |> Instr.fix ]

  type acc = unit
  let init_acc _ = ()
  let process acc i =
    acc, List.map rewrite i |> List.flatten
end

module Walk (T:SigPass) = struct
  let apply_prog acc p = acc, p (* TODO *)
  let apply_instr acc i = T.process acc i
  let apply (p, m) =
    let acc = T.init_acc () in
    let acc, p = List.fold_left_map apply_prog acc p in
    let acc, m = apply_instr acc m in
    (p, m)
end

module WalkNopend = Walk(NoPend);;
module WalkExpandPrint = Walk(ExpandPrint);;
