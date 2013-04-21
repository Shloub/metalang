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


(** Ast Re-Writer functor
    This file contains some way to walk, rewrite or extract some information
    of an ast.
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib

(**
   Cette signature décrit le minimum pour pouvoir parcourrir un ast.
   Quand un ast est paramétré par le type 'a et qu'il a la fonction
   foldmap du type ci dessous, on peut écrire plusieurs méthodes
   utiles pour l'annalyse et la réécriture de cet AST.
*)
module type SigAst = sig
  type 'a t

  (** foldmap effectue un foldmap sur les enfants directs du noeud
      que l'on parcours. il ne descend pas récursivement. *)
  val foldmap : ('acc -> 'a t -> 'acc * 'a t) -> 'acc -> 'a t -> 'acc * 'a t
end

(**
   Functor de parcours d'AST
*)
module F (T : SigAst) = struct
  (**
     Module de parcours en surface des enfants, dans descendre récursivement
  *)
  module Surface = struct
    let fold f0 acc t =
      let f acc t =
	(f0 acc t), t
      in
      let (acc, t) =
	T.foldmap f acc t
      in acc
  end

  (**
     Module de parcours récursif des enfants
  *)
  module Deep = struct

    let rec foldmap f acc t =
      let acc, t = T.foldmap (foldmap f) acc t
      in f acc t

    let fold f0 acc t =
      let rec f acc t =
	let acc, t = T.foldmap f acc t in
	(f0 acc t), t
      in
      let (acc, t) =
	T.foldmap f acc t in
      let (acc, t) = f acc t
      in acc

    let map f0 m =
      let rec f () m =
	let (), m = T.foldmap f () m in
	(), f0 m
      in
      let ((), m) =
	T.foldmap f () m in
      let (_, m) = f () m
      in m
  end

  (**
     Module de parcours récursif paramétré des enfants : une
     continuation est passée a la fonction de parcours qui décide elle
     même si elle parcours ou non et quand elle parcours (avant ou
     après avoir modifié l'accumulateur)
  *)
  module Traverse = struct
    let rec foldmap f acc t =
      T.foldmap (f (foldmap f)) acc t

    let rec map f t =
      let f2 tra acc t =
	acc, f (fun t ->
	  let (), t = tra () t
	  in t) t
      in let (), t = foldmap f2 () t in
	 t

    let rec fold f acc t =
      let f2 tra acc t =
	let acc = f (fun acc t ->
	  let acc, t = tra acc t
	  in acc
	) acc t
	in acc, t
      in let acc, _ = foldmap f2 acc t in
	 acc

  end

end
