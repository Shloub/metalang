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


(**
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

type varname = string
type typename = string
type funname = string
type fieldname = string

module BindingSet = StringSet
module BindingMap = StringMap

let next =
  let r = ref 0 in
  fun () ->
    let out = !r in
    begin
     r := (out + 1);
      out
    end

type location = ( (int * int ) * ( int * int ) )
let position p =
  let line = p.Lexing.pos_lnum in
  let cnum = p.Lexing.pos_cnum - p.Lexing.pos_bol - 1 in
  (line, cnum)
let location (p1, p2) =
  (position p1, position p2)

module PosMap : sig
  val add : int -> location -> unit
  val get : int -> location
end = struct
  let map = ref IntMap.empty
  let add i l =
    map := IntMap.add i l !map
  let get i =
    try
      IntMap.find i !map
    with Not_found -> (-1, -1), (-1, -1)
end

module Mutable = struct
  type ('mutable_, 'expr) tofix =
      Var of varname
    | Array of 'mutable_ * 'expr list
    | Dot of 'mutable_ * fieldname
  module Fixed = Fix(struct
    type ('a, 'b) alias = ('a, 'b) tofix
    type ('a, 'b) tofix = ('a, 'b) alias
    let map f = function
      | Var v -> Var v
      | Array (m, el) -> Array( f m, el)
      | Dot (m, fi) -> Dot (f m, fi)
    let next () = next ()
  end)
  type 'a t = 'a Fixed.t
  let fix = Fixed.fix
  let unfix = Fixed.unfix
  let array a el = Array (a, el) |> Fixed.fix
  let var a = Var a |> Fixed.fix
  let rec foldmap_expr f acc mut =
    let annot = Fixed.annot mut in
    match Fixed.unfix mut with
      | Var v -> acc, Fixed.fixa annot (Var v)
      | Dot (m, field) ->
        let acc, m = foldmap_expr f acc m in
        acc, Fixed.fixa annot (Dot (m, field))
      | Array (mut, li) ->
        let acc, mut = foldmap_expr f acc mut in
        let acc, li = List.fold_left_map f acc li in
        acc, Fixed.fixa annot (Array (mut, li) )

  let map_expr f m = foldmap_expr (fun () e -> (), f e) () m |> snd
end
