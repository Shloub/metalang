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
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THI
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *)

(** Expressions Ast
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
    @author Arthur Wendling (art.wendling\@gmail.com)
*)


open Stdlib
open Ast

type unop = Neg | Not | BNot

type binop =
  | Add | Sub | Mul | Div (* int or float *)
  | Mod (* int *)
  | Or | And (* bool *)
  | Lower | LowerEq | Higher | HigherEq (* 'a *)
  | Eq | Diff (* 'a *)
  | BinOr | BinAnd | RShift | LShift (* int *)

type 'a tofix =
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
  | Length of varname
  | Call of funname * 'a list

type t = F of int * t tofix
let annot = function F (i, _) -> i
let unfix = function F (_, x) -> x
let fix x = F ((next ()), x)

let map f = function
  | BinOp (a, op, b) -> BinOp ((f a), op, f b)
  | UnOp (a, op) -> UnOp((f a), op)
  | (
    Integer _
        | Length _
        | Float _
        | String _
        | Char _
        | Bool _) as lief -> lief
  | Access m ->
    let (), m2 = Mutable.foldmap_expr (fun () e -> (), f e) () m in
    Access m2
  | Call (n, li) -> Call (n, List.map f li)

let bool b = fix (Bool b)

let unop op a = fix (UnOp (a, op))
let binop op a b = fix (BinOp (a, op, b))

let integer i = fix (Integer i)
let char i = fix (Char i)
let float f = fix (Float f)
let string f = fix (String f)
let boolean b = fix (Bool b)

let access m = fix (Access m )

let call name li = fix ( Call(name, li))
let length name = fix ( Length name)

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
  type alias = t;;
  type t = alias;;
  let foldmap f acc t =
    let annot = annot t in
    match unfix t with
      | UnOp (a, op) ->
        let acc, a = f acc a in
        (acc, F(annot, UnOp(a, op)))
      | BinOp (a, op, b) ->
        let acc, a = f acc a in
        let acc, b = f acc b in
        (acc, F (annot, BinOp (a, op, b) ) )
      | Char _ -> acc, t
      | String _ -> acc, t
      | Float _ -> acc, t
      | Integer _ -> acc, t
      | Bool _ -> acc, t
      | Length _ -> acc, t
      | Access m ->
        let acc, m = Mutable.foldmap_expr f acc m in
        acc, F (annot, Access m)
      | Call (name, li) ->
        let acc, li = List.fold_left_map f acc li in
        (acc, F (annot, Call(name, li)) )
end)

module Eval = struct
  type result =
    | RInteger of int
    | RFloat of float
    | RBool of bool

  let print p = function
    | RInteger i -> Format.fprintf p "%i" i
    | RFloat f -> Format.fprintf p "%f" f
    | RBool false -> Format.fprintf p "False"
    | RBool true -> Format.fprintf p "True"

  let num_op ( + ) ( +. ) a b = match a, b with
    | RFloat i, RFloat j -> RFloat (i +. j)
    | RInteger i, RInteger j -> RInteger (i + j)
    | RInteger i, RFloat j -> RFloat (float_of_int i +. j)
    | RFloat i, RInteger j -> RFloat (i +. float_of_int j)
    | _ -> assert false
  let int_op f = num_op f (fun _ _ -> assert false)
  let num_cmp ( < ) a b = match a, b with
    | RFloat i, RFloat j -> RBool (i < j)
    | RInteger i, RInteger j -> RBool (float_of_int i < float_of_int j)
    | RInteger i, RFloat j -> RBool (float_of_int i < j)
    | RFloat i, RInteger j -> RBool (i < float_of_int j)
    | _ -> assert false
  let bool_op ( = ) a b = match a, b with
    | RBool i, RBool j -> RBool (i = j)
    | _ -> assert false


  let binop = function
    | Add -> num_op ( + ) ( +. )
    | Sub -> num_op ( - ) ( -. )
    | Mul -> num_op ( * ) ( *. )
    | Div -> num_op ( / ) ( /. )
    | Mod -> int_op ( mod )

    | LowerEq -> num_cmp ( <= )
    | Lower -> num_cmp ( < )
    | HigherEq -> num_cmp ( >= )
    | Higher -> num_cmp ( > )
    | Eq -> num_cmp ( = )
    | Diff -> num_cmp ( <> )

    | BinOr -> int_op ( lor )
    | BinAnd -> int_op ( land )
    | RShift -> int_op ( lsr )
    | LShift -> int_op ( lsl )

    | Or -> bool_op ( || )
    | And -> bool_op ( && )

  let rec eval t = match map eval (unfix t) with
    | Integer i -> RInteger i
    | Float f -> RFloat f
    | BinOp (a, op, b) -> binop op a b
    | UnOp (RInteger i, Neg) -> RInteger (-i)
    | UnOp (RBool i, Not) -> RBool (not i)
    | UnOp (RInteger i, BNot) -> RInteger (lnot i)
    | UnOp (RFloat i, Neg) -> RFloat (-. i)
    | _ -> assert false
end
