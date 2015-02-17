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

open Stdlib
open AstFun

(**
   Passes de transformations sur l'ast fonctionnel
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

let rec transform tra ( (set, rename) as acc) e =
  let annot = Expr.Fixed.annot e in
  match Expr.unfix e with
  | Expr.Fun (params, e) ->
    let (set, rename), params = List.fold_left_map (fun (set, rename) name ->
      if StringSet.mem name set then
        let name2 = Fresh.fresh_user () in
        (StringSet.add name2 set, StringMap.add name name2 rename), name2
      else
        (StringSet.add name set, rename), name
    ) (set, rename) params
    in let _, e = transform tra (set, rename) e
    in acc, Expr.Fixed.fixa annot (Expr.Fun (params, e))
  | Expr.LetIn (bindings, e) ->
    let (set, rename), bindings = List.fold_left_map (fun (set, rename) (name, e) ->
      let _, e = transform tra (set, rename) e in
      if StringSet.mem name set then
        let name2 = Fresh.fresh_user () in
        (StringSet.add name2 set, StringMap.add name name2 rename), (name2, e)
      else
        (StringSet.add name set, rename), (name, e)
    ) (set, rename) bindings
    in let _, e = transform tra (set, rename) e
    in acc, Expr.Fixed.fixa annot (Expr.LetIn (bindings, e))
  | Expr.Lief (Expr.Binding name) ->
    begin match StringMap.find_opt name rename with
    | None -> (set, rename), e
    | Some name2 ->
      (set, rename), Expr.Fixed.fixa annot (Expr.Lief (Expr.Binding name2))
    end
  | _ -> let _, e = tra (set, rename) e
         in (set, rename), e

let tr e = transform (Expr.Writer.Traverse.foldmap transform) (StringSet.empty, StringMap.empty) e

let apply p =
  let declarations = List.map (function
  | Declaration (name, e) ->
    let _, e = tr e in Declaration (name, e)
  | x -> x
  ) p.declarations
  in {p with declarations = declarations }

