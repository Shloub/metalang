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

module Type = struct
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

  module Fixed = Fix(struct
    type ('a, 'b) alias = 'a tofix
    type ('a, 'b) tofix = ('a, 'b) alias

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

    let next () = next ()
  end)

  type t = unit Fixed.t
  let fix = Fixed.fix
  let unfix = Fixed.unfix

  module Writer = AstWriter.F (struct
    type alias = t
    type 'a t = alias
    let foldmap f acc t =
      let annot = Fixed.annot t in
      match unfix t with
        | Auto | Integer | Float | String | Char | Void | Bool | Named _ ->
          acc, t
        | Array t ->
          let acc, t = f acc t in
          acc, Fixed.fixa annot (Array t)
        | Struct (li, p) ->
          let acc, li = List.fold_left_map
            (fun acc (name, t) ->
              let acc, t = f acc t in
              acc, (name, t)
            ) acc li
          in acc, Fixed.fixa annot (Struct (li, p))
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
    type2String (Fixed.map type_t_to_string (unfix t))

  let bool:t = Bool |> fix
  let integer:t = Integer |> fix
  let void:t = Void |> fix
  let float:t = Float |> fix
  let string:t = String |> fix
  let char:t = Char |> fix
  let array t = Array t |> fix
  let struct_ s p = Struct (s, p) |> fix
  let named n = Named n |> fix
  let auto () = Auto |> fix

end


module Expr = struct
  type unop = Neg | Not | BNot
  type binop =
    | Add | Sub | Mul | Div (* int or float *)
    | Mod (* int *)
    | Or | And (* bool *)
    | Lower | LowerEq | Higher | HigherEq (* 'a *)
    | Eq | Diff (* 'a *)
    | BinOr | BinAnd | RShift | LShift (* int *)

  type ('a, 'lex) tofix =
    (*operations numeriques*)
      BinOp of 'a * binop * 'a
    | UnOp of 'a * unop
    (* liefs *)
    | Char of char
    | String of string
    | Float of float
    | Integer of int
    | Bool of bool
    | Access of 'a Mutable.t
    | Length of 'a Mutable.t
    | Call of funname * 'a list
    | Lexems of 'lex list

  module Fixed = Fix(struct
    type ('a, 'b) alias = ('a, 'b) tofix
    type ('a, 'b) tofix = ('a, 'b) alias
    let map f = function
      | BinOp (a, op, b) -> BinOp ((f a), op, f b)
      | UnOp (a, op) -> UnOp((f a), op)
      | (
        Integer _
            | Float _
            | String _
            | Char _
            | Bool _) as lief -> lief
      | Access m ->
        let (), m2 = Mutable.foldmap_expr (fun () e -> (), f e) () m in
        Access m2
      | Length m ->
        let (), m2 = Mutable.foldmap_expr (fun () e -> (), f e) () m in
        Length m2
      | Call (n, li) -> Call (n, List.map f li)
    let next () = next ()
  end)
  type 'a t = 'a Fixed.t
  let fix = Fixed.fix
  let unfix = Fixed.unfix


  let bool b = fix (Bool b)

  let unop op a = fix (UnOp (a, op))
  let binop op a b = fix (BinOp (a, op, b))

  let integer i = fix (Integer i)
  let char i = fix (Char i)
  let float f = fix (Float f)
  let string f = fix (String f)
  let boolean b = fix (Bool b)

  let lexems li = fix (Lexems li)

  let access m = fix (Access m )

  let call name li = fix ( Call(name, li))
  let length m = fix ( Length (Mutable.var m) )

  let default_value t = match Type.unfix t with
    | Type.Integer -> integer 0
    | Type.Float -> float 0.
    | Type.String -> string ""
    | Type.Char -> char '_'
    | Type.Array _ -> failwith ("new array is not an expression")
    | Type.Void -> failwith ("no dummy expression for void")
    | Type.Bool -> boolean false
    | Type.Named _ -> failwith ("new named is not an expression")
    | Type.Auto -> failwith ("auto is not an expression")
    | Type.Struct _ -> failwith ("new named is not an expression")

  module Writer = AstWriter.F (struct
    type 'a alias = 'a t;;
    type 'a t = 'a alias;;
    let foldmap f acc t =
      let annot = Fixed.annot t in
      match unfix t with
        | UnOp (a, op) ->
          let acc, a = f acc a in
          (acc, Fixed.fixa annot (UnOp(a, op)))
        | BinOp (a, op, b) ->
          let acc, a = f acc a in
          let acc, b = f acc b in
          (acc, Fixed.fixa annot (BinOp (a, op, b) ) )
        | Char _ -> acc, t
        | String _ -> acc, t
        | Float _ -> acc, t
        | Integer _ -> acc, t
        | Bool _ -> acc, t
        | Access m ->
          let acc, m = Mutable.foldmap_expr f acc m in
          acc, Fixed.fixa annot (Access m)
        | Length m ->
          let acc, m = Mutable.foldmap_expr f acc m in
          acc, Fixed.fixa annot (Length m)
        | Call (name, li) ->
          let acc, li = List.fold_left_map f acc li in
          (acc, Fixed.fixa annot (Call(name, li)) )
  end)
end
