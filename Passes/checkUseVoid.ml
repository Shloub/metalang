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
 *)

(** Cette passe vérifie que l'on utilise pas void comme une valeur
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

 let rec check ty loc =
    if Type.unfix ty = Type.Void then
      raise (Warner.Error (fun f ->
	Format.fprintf f "Forbiden use of void type %a@\n"
	  Warner.ploc loc
      ) )
    else Type.Writer.Surface.iter (fun ty -> check ty loc) ty

  let collectDefReturn env li =
    let f () i =
      match Instr.unfix i with
      | Instr.AllocArray (_, ty, _, _)
      | Instr.Declare (_, ty, _) ->
	check ty (Ast.PosMap.get (Instr.Fixed.annot i))
      | Instr.Return e ->
	check (Typer.get_type env e) (Ast.PosMap.get (Instr.Fixed.annot i))
      | _ -> () in
    List.iter
      (fun i ->
        Instr.Writer.Deep.fold f
          (f () i) i)
      li

  let collectDefReturn_fun env = function
    | Prog.DeclarFun (_, _, params, li) ->
      collectDefReturn env li;
      List.iter (fun (_, ty) ->
	check ty (Ast.PosMap.get (Type.Fixed.annot ty))
      ) params
    | _ -> ()
      
  let apply (env, prog) =
    List.iter (fun t -> collectDefReturn_fun env t) prog.Prog.funs;
    Option.map_default () (collectDefReturn env) prog.Prog.main;
    env, prog
