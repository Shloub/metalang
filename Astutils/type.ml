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

(** Type Ast
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast

type structparams =
{
  tuple : bool
}

type 'a tofix =
  | Integer
  | Float
  | String
  | Char
  | Array of 'a
  | Void
  | Bool
  | Struct of
      (fieldname * 'a) list * structparams
  | Named of typename
  | Auto

type t = F of int * t tofix
let annot = function F (i, _) -> i
let unfix = function F (_, x) -> x
let fix x = F ((next ()), x)

let map f = function
  | Auto -> Auto
  | Integer -> Integer
  | Float -> Float
  | String -> String
  | Char -> Char
  | Array t -> Array (f t)
  | Void -> Void
  | Bool -> Bool
  | Struct (li, p) ->
    Struct (List.map (fun (name, t) -> (name, f t)) li, p)
  | Named t -> Named t

module Writer = AstWriter.F (struct
  type alias = t
  type t = alias
  let foldmap f acc t =
    let annot = annot t in
    match unfix t with
      | Auto | Integer | Float | String | Char | Void | Bool | Named _ ->
        acc, t
      | Array t ->
        let acc, t = f acc t in
        acc, F (annot, Array t)
      | Struct (li, p) ->
        let acc, li = List.fold_left_map
          (fun acc (name, t) ->
            let acc, t = f acc t in
            acc, (name, t)
          ) acc li
        in acc, F (annot, Struct (li, p))
end)

let type2String (t : string tofix) : string =
  match t with
    | Auto -> "Auto"
    | Integer -> "Integer"
    | Float -> "Float"
    | String -> "String"
    | Char -> "Char"
    | Array t -> "Array("^t^")"
    | Void -> "Void"
    | Bool -> "Bool"
    | Struct (li, p) ->
      let str = List.fold_left
        (fun acc (name, t) ->
          acc ^ name ^ ":"^t^"; "
        ) "" li
      in "Struct("^str^")"
    | Named t -> "Named("^t^")"

let rec type_t_to_string (t:t) : string =
  type2String (map type_t_to_string (unfix t))

let bool = Bool |> fix
let integer = Integer |> fix
let void = Void |> fix
let float = Float |> fix
let string = String |> fix
let char = Char |> fix
let array t = Array t |> fix
let struct_ s p = Struct (s, p) |> fix
let named n = Named n |> fix
let auto () = Auto |> fix
