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

(** Cette passe supprime les fonctions non utilisés
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Fresh

let apply prog funs =
  let go f (li, used_functions) = match f with
    | Prog.Unquote e -> f::li, CollectCalls.process_expr e used_functions
    | Prog.DeclarFun (v, _,_, _, _)
    | Prog.Macro (v, _, _, _) ->
      if StringSet.mem v used_functions
      then (f::li, (Passes.WalkCollectCalls.fold_fun used_functions f) )
      else (li, used_functions)
    | Prog.Comment _ -> (f::li, used_functions)
    | Prog.DeclareType _ -> (f::li, used_functions)
  in

  let used_functions = Passes.WalkCollectCalls.fold ()
      {prog with Prog.funs = funs } in (* fonctions utilisées dans le
                                          programme (stdlib non comprise) *)
  let funs, _ = List.fold_right go prog.Prog.funs ([], used_functions) in
  let prog = { prog with Prog.funs = funs} in
  prog
