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
  
  let rec write_bool e =
    Instr.if_ (Expr.binding e)
      [ Instr.print Type.string (Expr.string "True") ]
      [ Instr.print Type.string (Expr.string "False") ]

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

module type SigPassTop = sig
  type acc;;
  val init_acc : unit -> acc;;
  val process : acc -> Prog.t_fun -> (acc * Prog.t_fun)
  val process_main : acc -> Instr.t list -> (acc * Instr.t list)
end

module WalkTop (T:SigPassTop) = struct
  let apply (name, p, m) =
    let acc = T.init_acc () in
    let acc, p =  List.fold_left_map T.process acc p in
    let acc, m = T.process_main acc m in
    (name, p, m)
  let fold (name, p, m) =
    let acc = T.init_acc () in
    let acc, p =  List.fold_left_map T.process acc p in
    let acc, m = T.process_main acc m in
    acc

  let fold_fun acc p =
    let acc, p =  T.process acc p in
    acc
end

module CheckNaming : SigPassTop = struct
  type acc = {
    functions : BindingSet.t;
    parameters : BindingSet.t;
    variables : BindingSet.t;
    array : BindingSet.t;
    types : BindingSet.t;
  }
  let init_acc _ =
    {
      functions = BindingSet.empty;
      parameters = BindingSet.empty;
      variables = BindingSet.empty;
      array = BindingSet.empty;
      types = BindingSet.empty;
    }

  let check_name0 funname acc name =
    if BindingSet.mem name acc then
      Warner.err funname (fun t () -> Format.fprintf t "%s is re-declared" name)

  let check_name funname acc name =
    begin
      check_name0 funname acc.functions name;
      check_name0 funname acc.parameters name;
      check_name0 funname acc.variables name;
      check_name0 funname acc.types name;
      check_name0 funname acc.array name
    end

  let add_type_in_acc funname name acc out =
    let () = check_name funname acc name in
    let acc = { acc with types = BindingSet.add name acc.types }
    in acc, out

  let add_fun_in_acc funname name acc out =
    let () = check_name funname acc name in
    let acc = { acc with functions = BindingSet.add name acc.functions }
    in acc, out

  let add_param_in_acc funname name acc  =
    let () = check_name funname acc name in
    let acc = { acc with parameters = BindingSet.add name acc.parameters }
    in acc

  let add_array_in_acc funname name acc  =
    let () = check_name funname acc name in
    let acc = { acc with array = BindingSet.add name acc.array }
    in acc

  let add_local_in_acc funname name acc  =
    let () = check_name funname acc name in
    let acc = { acc with variables = BindingSet.add name acc.variables }
    in acc


  let is_value funname acc name =
(* TODO if is parameter, change message *)
    if not(BindingSet.mem name acc.variables) &&
      not(BindingSet.mem name acc.parameters) &&
      not(BindingSet.mem name acc.array)
    then
      Warner.err funname (fun t () -> Format.fprintf t "%s is not a local variable" name)


  let is_local funname acc name =
(* TODO if is parameter, change message *)
    if not(BindingSet.mem name acc.variables) then
      Warner.err funname (fun t () -> Format.fprintf t "%s is not a local variable" name)


  let is_array funname acc name =
    if not(BindingSet.mem name acc.array)
      && not( BindingSet.mem name acc.parameters)
    then
      Warner.err funname (fun t () -> Format.fprintf t "%s is not an array" name)

  let is_fun funname acc name =
    if not(BindingSet.mem name acc.functions)
    then
      Warner.err funname (fun t () -> Format.fprintf t "%s is not a function" name)


  let check_expr funname acc e =
    let f () e = match Expr.unfix e with
      | Expr.Binding b ->
	is_value funname acc b
      | Expr.AccessArray (tab, li) ->
	is_array funname acc tab
      | Expr.Length tab ->
	is_array funname acc tab
      | Expr.Call (function_, _) ->
	is_fun funname acc function_
      | _ -> ()
    in
    Expr.Writer.Deep.fold
      f
      (f () e)
      e
 
 let rec check_instr funname acc instr =
    match Instr.unfix instr with
      | Instr.Declare (var, t, e) ->
	let () = check_expr funname acc e in
	add_local_in_acc funname var acc
      | Instr.Affect ((Instr.Var v), e) ->
	let () = is_local funname acc v in
	let () = check_expr funname acc e in
	acc
      | Instr.Affect ((Instr.Array (arr, el)), e) ->
	let () = List.iter ( check_expr funname acc ) el in
	let () = check_expr funname acc e in
	let () = is_array funname acc arr
	in acc
      | Instr.Loop (v, e1, e2, li) ->
	let () = check_expr funname acc e1 in
	let () = check_expr funname acc e2 in
	let acc2 = add_param_in_acc funname v acc in
	let acc2 = List.fold_left (check_instr funname) acc2 li
	in acc
      | Instr.While (e, li) ->
	let () = check_expr funname acc e in
	let _ = List.fold_left (check_instr funname) acc li
	in acc
      | Instr.Comment _ -> acc
      | Instr.Return e ->
	let () = check_expr funname acc e in acc
      | Instr.AllocArray (v, t, e, liopt) ->
	let () = check_expr funname acc e in
	let _ = match liopt with
	  | None -> acc
	  | Some (varname, li) ->
	    let () = check_name funname acc varname in
	    let acc = add_param_in_acc funname varname acc in
	    List.fold_left (check_instr funname) acc li
	in add_array_in_acc funname v acc
      | Instr.If (e, li1, li2) ->
	let () = check_expr funname acc e in
	let _ = List.fold_left (check_instr funname) acc li1 in
	let _ = List.fold_left (check_instr funname) acc li2
	in acc
      | Instr.Call (name, li) ->
	let () = is_fun funname acc name in
	let () = List.iter (check_expr funname acc) li
	in acc
      | Instr.Print (t, e) ->
	let () = check_expr funname acc e in acc
      | Instr.Read (t, Instr.Var v) ->
	let () = is_local funname acc v in
	acc
      | Instr.Read (t, Instr.Array (v, el)) ->
	let () = List.iter ( check_expr funname acc ) el in
	let () = is_array funname acc v
	in acc
      | Instr.StdinSep -> acc

  let process acc f = match f with
    | Prog.Macro (name, _, _, _) ->
      add_fun_in_acc name name acc f
    | Prog.Comment _ -> acc, f
    | Prog.DeclareType (name, _) ->
      add_type_in_acc name name acc f
    | Prog.DeclarFun (funname, t, params, instrs) ->
      let acc, f = add_fun_in_acc funname funname acc f in
      let acc0 = List.fold_left (fun acc (name, t) ->
	add_param_in_acc funname name acc
      ) acc params in
      let _ = List.fold_left (check_instr funname) acc0 instrs
      in acc, f
  let process_main acc f =
    let _ = List.fold_left (check_instr "main") acc f in
    (acc, f)
end

module WalkCheckNaming = WalkTop(CheckNaming);;


module Rename = struct
  type acc = varname BindingMap.t

  let map = ref BindingMap.empty;;
  let add name =
    map := BindingMap.add name (name ^ "_") !map;;

  let init_acc () = !map


  let mapname map name =
    match BindingMap.find_opt name map with
      | Some s -> s
      | None -> name

  let process_expr map e =
    let f e = Expr.fix (match Expr.unfix e with
      | Expr.Binding b ->
	Expr.Binding (mapname map b)
      | Expr.AccessArray (v, li) ->
	Expr.AccessArray ((mapname map v), li)
      | Expr.Call (funname, li) ->
	Expr.Call ((mapname map funname), li)
      | e -> e)
    in Expr.Writer.Deep.map f e

  let mapmutable map m =
    match m with
      | Instr.Var v -> Instr.Var (mapname map v)
      | Instr.Array (v, li) ->
	Instr.Array ((mapname map v), List.map (process_expr map) li)

  let rec process_instr map i =
    let i = match Instr.unfix i with
      | Instr.Declare (v, t, e) ->
	Instr.Declare ( (mapname map v), t, process_expr map e)
      | Instr.Affect (m, e) ->
	Instr.Affect ((mapmutable map m), process_expr map e)
      | Instr.Loop (var, e1, e2, li) ->
	Instr.Loop ( (mapname map var), (process_expr map e1), (process_expr map e2), List.map (process_instr map) li )
      | Instr.While (e, li) ->
	Instr.While ((process_expr map e), List.map (process_instr map) li )
      | Instr.Comment s -> Instr.Comment s
      | Instr.Return e -> Instr.Return (process_expr map e)
      | Instr.AllocArray (name, t, e, None) ->
	Instr.AllocArray ((mapname map name), t, (process_expr map e), None)
      | Instr.AllocArray (name, t, e, Some ((var, li))) ->
	let li2 = List.map (process_instr map) li in
	Instr.AllocArray ((mapname map name), t, (process_expr map e), Some ((var, li2)))
      | Instr.If (e, li1, li2) ->
	Instr.If ((process_expr map e),
		  (List.map (process_instr map) li1 ),
		  (List.map (process_instr map) li2 )
	)
      | Instr.Call (name, li) ->
	Instr.Call ((mapname map name), List.map (process_expr map) li)
      | Instr.Print (t, e) ->
	Instr.Print (t, process_expr map e)
      | Instr.Read (t, m) ->
	Instr.Read (t, mapmutable map m)
      | Instr.StdinSep -> Instr.StdinSep
    in Instr.fix i

  let process_main acc m = acc, List.map (process_instr acc) m
  let process acc p =
    let p = match p with
      | Prog.DeclarFun (funname, t, params, instrs) ->
	Prog.DeclarFun (mapname acc funname, t,
			 (List.map (fun (n, t) -> (mapname acc n), t) params),
			 (List.map (process_instr acc) instrs))
      | _ -> p
    in acc, p
end

module WalkRename = WalkTop(Rename);;

module CollectCalls = struct
  type acc = BindingSet.t

  let init_acc () = BindingSet.empty

  let process_expr acc e =
    let f acc e = match Expr.unfix e with
      | Expr.Call (funname, _) -> BindingSet.add funname acc
      | e -> acc
    in Expr.Writer.Deep.fold f acc e

  let collect_instr acc i =
    let f acc i =
      match Instr.unfix i with
	| Instr.Call (name, li) ->
	  BindingSet.add name acc
	| _ -> acc
    in
    let acc = Instr.Writer.Deep.fold f acc i
    in Instr.fold_expr process_expr acc i

  let process_main acc m = (List.fold_left collect_instr acc m), m

  let process acc p =
    let acc = match p with
      | Prog.DeclarFun (_funname, _t, _params, instrs) ->
	List.fold_left collect_instr acc instrs
      | _ -> acc
    in acc, p
end

module WalkCollectCalls = WalkTop(CollectCalls);;
