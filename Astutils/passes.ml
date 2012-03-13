open Stdlib

open Ast
open Fresh

module type SigPass = sig
  type acc;;
  val init_acc : unit -> acc;;
  val process : acc -> Instr.t list -> (acc * Instr.t list)
end


let rec returns instrs =
  List.fold_left
    returns_i false instrs
and returns_i acc i = match Instr.unfix i with
  | Instr.Return _ -> true
  | Instr.If (_, li1, li2) ->
    acc or ( (returns li1) && returns li2 )
  | _ -> acc

module IfMerge : SigPass = struct
  type acc = unit;;
  let init_acc () = ();;
  let process () i =
    let rec f acc = function
      | [] -> List.rev acc
      | [i] -> List.rev (i :: acc)
      | hd::tl ->
	match Instr.unfix hd with
	  | Instr.If (e, l1, l2) ->
	    let l1 = f [] l1 in
	    let l2 = f [] l2 in
	    if returns l1 then
	      let l2 = l2 @ tl in
	      let l2 = f [] l2 in
	      (Instr.if_ e l1 l2 ) :: acc |> List.rev
	    else if returns l2 then
	      let l1 = l1 @ tl in
	      let l1 = f [] l1 in
	      (Instr.if_ e l1 l2 ) :: acc |> List.rev
	    else f (hd :: acc) tl
	  | _ -> f (hd :: acc) tl
    in
    (), f [] i;;
end

module AllocArrayExpend : SigPass = struct
  type acc = unit;;
  let init_acc () = ();;

  let mapret tab index instructions =
    let f tra i = match Instr.unfix i with
      | Instr.Return e -> Instr.affect (Instr.mutable_array tab [Expr.binding index]) e
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

module ExpandPrint : SigPass = struct
  let rec write t b =
    let i = fresh () in
    let b2 = fresh () in
    let b2e = Expr.access_array1 b (Expr.binding i) in
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
	    | _ -> [ Instr.print t b2e]
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

  let apply_instr acc i = T.process acc i
  let apply_prog acc p =
    List.fold_left_map
      (fun acc item ->
	match item with
	  | Prog.Macro _ -> acc, item
	  | Prog.Comment _ -> acc, item
	  | Prog.DeclareType _ -> acc, item
	  | Prog.DeclarFun (name, t, params, instrs) ->
	    let acc, instrs = apply_instr acc instrs
	    in acc, Prog.DeclarFun (name, t, params, instrs)
      )
      acc
      p
  let apply (name, p, m) =
    let acc = T.init_acc () in
    let acc, p =  apply_prog acc p in
    let acc, m = apply_instr acc m in
    (name, p, m)
end

module WalkNopend = Walk(NoPend);;
module WalkExpandPrint = Walk(ExpandPrint);;
module WalkIfMerge = Walk(IfMerge);;
module WalkAllocArrayExpend = Walk(AllocArrayExpend);;
