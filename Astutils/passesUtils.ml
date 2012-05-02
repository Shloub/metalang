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

module type SigPassTop = sig
  type acc;;
  val init_acc : unit -> acc;;
  val process : acc -> Prog.t_fun -> (acc * Prog.t_fun)
  val process_main : acc -> Instr.t list -> (acc * Instr.t list)
end

module WalkTop (T:SigPassTop) = struct
  let apply ( prog : Prog.t ) =
    let acc = T.init_acc () in
    let acc, p =  List.fold_left_map T.process acc prog.Prog.funs in
    let acc, m = match prog.Prog.main with
      | None -> acc, None
      | Some m -> match T.process_main acc m with
	  | (acc, main) -> acc, Some main
    in
    { prog with
      Prog.funs = p;
      Prog.main = m;
    }
  
  let fold ( prog : Prog.t ) =
    let acc = T.init_acc () in
    let acc, funs =  List.fold_left_map T.process acc prog.Prog.funs in
    let acc, _ = match prog.Prog.main with
      | None -> acc, []
      | Some m -> T.process_main acc m in
    acc

  let fold_fun acc p =
    let acc, p =  T.process acc p in
    acc
end

module type SigPass = sig
  type acc;;
  val init_acc : unit -> acc;;
  val process : acc -> Instr.t list -> (acc * Instr.t list)
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
  let apply ( prog : Prog.t ) : Prog.t  =
    let acc = T.init_acc () in
    let acc, p = apply_prog acc prog.Prog.funs in
    let acc, m = match prog.Prog.main with
      | None -> acc, None
      | Some m -> match apply_instr acc m with
	  | (a, b) -> a, Some b
    in
    {prog with
      Prog.main = m;
      Prog.funs = p;
    }
end
