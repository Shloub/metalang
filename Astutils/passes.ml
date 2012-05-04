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
open ExpandPasses

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

  let rec mapmutable map m =
    match m with
      | Instr.Var v -> Instr.Var (mapname map v)
      | Instr.Array (v, li) ->
	Instr.Array ((mapmutable map v), List.map (process_expr map) li)

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
      | (Instr.DeclRead (t, v) ) as i -> i
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


module WalkNopend = Walk(NoPend);;
module WalkExpandPrint = Walk(ExpandPrint);;
module WalkIfMerge = Walk(IfMerge);;
module WalkAllocArrayExpend = Walk(AllocArrayExpend);;
module WalkExpandReadDecl = Walk(ExpandReadDecl);;
module WalkCheckNaming = WalkTop(CheckingPasses.CheckNaming);;
module WalkRename = WalkTop(Rename);;
module WalkCollectCalls = WalkTop(CollectCalls);;
