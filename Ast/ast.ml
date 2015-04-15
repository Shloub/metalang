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
   Ce module contient les différents AST de notre compilateur
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

type varname = | UserName of string
               | InternalName of int

let get_username = function
  | UserName s -> Some s
  | InternalName _ -> None

type typename = string
type funname = string
type fieldname = string

module BindingStruct = struct
  type t = varname
  let compare a b = match a, b with
    | UserName v1, UserName v2 -> String.compare v1 v2
    | InternalName i1, InternalName i2 -> i1 - i2
    | InternalName _, UserName _ -> 1
    | UserName _, InternalName _ -> -1
end

module BindingSet = MakeSet(BindingStruct)
module BindingMap = MakeMap(BindingStruct)

(** returns the next value *)
let next =
  let r = ref 0 in
  fun () ->
    let out = !r in
    begin
      r := (out + 1);
      out
    end

(** {2 Positions} *)
(** the position in a file :
    ((a, b), (c, d)) means from line a char b to line c char d
*)

type location = ( string * (int * int ) * ( int * int ) )

let default_location = "No File", (-1, -1), (-1, -1)

let parsed_file = ref ""

(** get a position from lexer (line, char) *)
let position p =
  let line = p.Lexing.pos_lnum in
  let cnum = p.Lexing.pos_cnum - p.Lexing.pos_bol - 1 in
  (line, cnum)

let merge_positions (f, a, _) (f2, _, b) = (f, a, b)

(** get a location from lexer *)
let location (p1, p2) =
  (!parsed_file, position p1, position p2)

(** position map *)
module PosMap : sig
  val add : int -> location -> unit
  val get : int -> location
  val mem : int -> bool
end = struct
  let map = ref IntMap.empty
  let mem i = IntMap.mem i !map
  let add i l =
    map := IntMap.add i l !map
  let get i =
    try
      IntMap.find i !map
    with Not_found -> default_location
end

(** {2 Modules d'AST} *)

(** lexems modules
    this module contains macro definitions
*)
module Lexems = struct

  type ('token, 'expr) t =
  | Expr of 'expr
  | Token of 'token
  | UnQuote of ('token, 'expr) t list

  let token t = Token t
  let unquote li = UnQuote li

  let rec map_expr f = function
    | Expr e -> Expr (f e)
    | Token t -> Token t
    | UnQuote li ->
      UnQuote (List.map (map_expr f) li)

  module Apply (F:Applicative) = struct
    open F

    let fold_left_map f l =
      ret List.rev
      <*> List.fold_left (fun xs x -> ret cons <*> f x <*> xs ) (ret []) l

    let rec map_expr f g = function
      | Expr e -> ret (fun e -> Expr e) <*> f e
      | Token t -> ret (fun t -> Token t) <*> g t
      | UnQuote li -> ret (fun li -> UnQuote li) <*> fold_left_map (map_expr f g) li
  end

end

(**
   mutable module
   this module contains mutable values like array, records and variables
*)
module Mutable = struct

  (** {2 type} *)

  type ('mutable_, 'expr) tofix =
    Var of varname
  | Array of 'mutable_ * 'expr list
  | Dot of 'mutable_ * fieldname

  (** {2 Parcours} *)
  module Fixed = Fix2( struct
    let next () = next ()
    type ('a, 'b) alias = ('a, 'b) tofix
    type ('a, 'b) tofix = ('a, 'b) alias
    module Make(F:Applicative) = struct
      open F
      let fold_left_map f l =
        ret List.rev
          <*> List.fold_left (fun xs x -> ret cons <*> f x <*> xs ) (ret []) l
      let foldmap f g t =
        match t with
        | Var v -> ret ( Var v )
        | Array (v, el) -> ret (fun v el -> Array(v, el)) <*> f v <*> fold_left_map g el
        | Dot (v, field) -> ret (fun v -> Dot(v, field)) <*> f v
    end
  end)

  type 'expr t = 'expr Fixed.t
  let fix = Fixed.fix
  let unfix = Fixed.unfix

  (** module de réécriture et de parcours d'AST *)
  module Writer = AstWriter.F (struct
    type 'a alias = 'a t
    type 'a t = 'a alias
    let foldmap f acc t = Fixed.Surface.foldmapt (fun x acc -> f acc x) t acc
  end)

  let rec equals cmpe a b = match (unfix a, unfix b) with
    | Var v1, Var v2 ->
      begin match (v1, v2) with
      | InternalName i1, InternalName i2 -> i1 = i2
      | UserName v1, UserName v2 -> String.equals v1 v2
      | _ -> false
      end
    | Array (m1, li1), Array (m2, li2) ->
      if equals cmpe m1 m2 then List.zip li1 li2 |> List.forall
          (uncurry cmpe)
      else false
    | Dot (m1, field1), Dot (m2, field2) ->
      if equals cmpe m1 m2 then String.equals field1 field2
      else false
    | _ -> false

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

  let map_expr f m = Fixed.Deep.mapg f m

  (** {2 utils} *)

  let array a el = Array (a, el) |> Fixed.fix
  let var a = Var a |> Fixed.fix
  let dot a f = Dot (a, f) |> Fixed.fix

end

(**
   type module
   this module contains ast for metalang types
*)
module Type = struct

  type 'a tofix =
  | Integer
  | String
  | Char
  | Array of 'a
  | Void
  | Bool
  | Lexems
  | Struct of (fieldname * 'a) list
  | Enum of fieldname list
  | Named of typename
  | Tuple of 'a list
  | Auto

  module Fixed = Fix2(struct
    type 'a alias = 'a tofix
    type ('a, _) tofix = 'a alias
    let next () = next ()
    module Make(F:Applicative) = struct
      open F
      let fold_left_map f l =
        ret List.rev
          <*> List.fold_left (fun xs x -> ret cons <*> f x <*> xs ) (ret []) l
      let foldmap f g e =
        let f' (a, x) = ret (fun x -> a, x) <*> f x in
        match e with
        | Auto -> ret Auto
        | Integer -> ret Integer
        | String -> ret String
        | Void -> ret Void
        | Bool -> ret Bool
        | Lexems -> ret Lexems
        | Named n -> ret (Named n)
        | Enum e -> ret (Enum e)
        | Char -> ret Char
        | Array t -> ret (fun x -> Array x) <*> f t
        | Tuple li -> ret (fun li -> Tuple li) <*> fold_left_map f li
        | Struct li -> ret (fun li -> Struct li) <*>  fold_left_map f' li
    end
  end)

  type t = unit Fixed.t
  let fix = Fixed.fix
  let unfix = Fixed.unfix

  let rec compare (ta : t) (tb : t) : int =

    match (unfix ta), (unfix tb) with
    | Auto, Auto -> 0
    | Auto, _ -> -1
    | Lexems, Lexems -> 0
    | Lexems, Auto -> 1
    | Lexems, _ -> -1
    | Integer, Integer -> 0
    | Integer, (Lexems | Auto) -> 1
    | Integer, _ -> -1
    | String, String -> 0
    | String, (Auto | Lexems | Integer) -> 1
    | String, _ -> -1
    | Char, Char -> 0
    | Char, (Auto | Lexems | Integer | String) -> 1
    | Char, _ -> -1
    | Array ca, Array cb -> compare ca cb
    | Array _, (Char | Auto | Lexems | Integer | String) -> 1
    | Array _, _ -> -1
    | Void, Void -> 0
    | Void, (Array _ | Char | Auto | Lexems | Integer | String) -> 1
    | Void, _ -> -1
    | Bool, Bool -> 0
    | Bool, (Void | Array _ | Char | Auto | Lexems | Integer | String) -> 1
    | Bool, _ -> -1
    | Enum _, (Bool | Void | Array _ | Char | Auto | Lexems | Integer | String) -> 1
    | Enum e1, Enum e2 ->
      let l1 = List.length e1
      and l2 = List.length e2 in
      if l1 = l2 then
        List.fold_left (fun result (n1, n2) ->
          if result <> 0 then result else
            String.compare n1 n2
        ) 0 (List.combine e1 e2)
      else l1 - l2
    | Enum _, _ -> -1

    | Struct s1, Struct s2 ->
      let l1 = List.length s1
      and l2 = List.length s2 in
      if l1 = l2 then
        List.fold_left (fun result ((n1, t1), (n2, t2)) ->
          if result <> 0 then result else
            let result = String.compare n1 n2 in
            if result <> 0 then result else
              compare t1 t2
        ) 0 (List.combine s1 s2)
      else l1 - l2
    | Tuple li1, Tuple li2 ->
      let len1 = List.length li1 and
          len2 = List.length li2 in
      if len1 < len2 then -1
      else if len2 < len1 then 1
      else List.fold_left (fun acc (t1, t2) ->
        if acc = 0 then compare t1 t2
        else acc
      ) 0 (List.combine li1 li2)
    | Tuple _, _ -> 1
    | Struct _, (Enum _| Bool | Void | Array _ | Char | Auto |
        Lexems | Integer | String) -> 1
    | Struct _, _ -> -1
    | Named n1, Named n2 -> String.compare n1 n2
    | Named _, (Enum _| Struct _ | Bool | Void | Array _ | Char |
        Auto | Lexems | Integer | String | Tuple _) -> 1

  (** module de réécriture et de parcours d'AST *)
  module Writer = AstWriter.F (struct
    type alias = t
    type 'a t = alias
    let foldmap f acc t = Fixed.Surface.foldmapt (fun x acc -> f acc x) t acc
  end)

  let type2String = function
    | Auto -> "Auto"
    | Integer -> "Integer"
    | String -> "String"
    | Char -> "Char"
    | Array t -> "Array("^t^")"
    | Void -> "Void"
    | Bool -> "Bool"
    | Lexems -> "Lexems"
    | Tuple li ->
      let str = List.fold_left
        (fun acc t ->
          acc ^ ", " ^ t
        ) "" li
      in "("^str^")"
    | Enum e -> let str = List.fold_left
                  (fun acc name ->
                    acc ^ name ^ ", "
                  ) "" e
                in "Enum("^str^")"
    | Struct li ->
      let str = List.fold_left
        (fun acc (name, t) ->
          acc ^ name ^ ":"^t^"; "
        ) "" li
      in "Struct("^str^")"
    | Named t -> "Named("^t^")"

  let type_t_to_string t = Fixed.Deep.fold type2String t

  let bool:t = Bool |> fix
  let integer:t = Integer |> fix
  let void:t = Void |> fix
  let string:t = String |> fix
  let char:t = Char |> fix
  let array t = Array t |> fix
  let enum s = Enum (s) |> fix
  let struct_ s = Struct s |> fix
  let named n = Named n |> fix
  let tuple n = Tuple n |> fix
  let auto () = Auto |> fix
  let lexems:t = Lexems |> fix

end

module TypeMap = MakeMap (Type)
module TypeSet = MakeSet (Type)


(**
   expr module
   this module contains ast for metalang expressions
*)
module Expr = struct


  (** {2 types} *)

  (** unary operators *)
  type unop =
    Neg (** integer *)
  | Not (** boolean *)

  (** binary operators *)
  type binop =
  | Add | Sub | Mul | Div (* int *)
  | Mod (* int *)
  | Or | And (* bool *)
  | Lower | LowerEq | Higher | HigherEq (* 'a *)
  | Eq | Diff (* 'a *)

  type lief =
  | Char of char
  | String of string
  | Integer of int
  | Bool of bool
  | Enum of string (** enumerateur *)

  type ('a, 'lex) tofix =
    BinOp of 'a * binop * 'a (** operations binaires *)
  | UnOp of 'a * unop (** operations unaires *)
  | Lief of lief
  | Access of 'a Mutable.t (** vaut la valeur du mutable *)
  | Call of funname * 'a list (** appelle la fonction *)
  | Lexems of ('lex, 'a) Lexems.t list (** contient un bout d'AST *)
  | Tuple of 'a list
  | Record of (fieldname * 'a) list

  (** {2 parcours} *)

  module Fixed = Fix2(struct
    type ('a,'b) alias = ('a, 'b) tofix
    type ('a, 'b) tofix = ('a, 'b) alias
    let next () = next ()
    module Make(F:Applicative) = struct
      open F
      module Mut = Mutable.Fixed.Apply(F)
      module Lex = Lexems.Apply(F)

    let fold_left_map f l =
      ret List.rev
      <*> List.fold_left (fun xs x -> ret cons <*> f x <*> xs ) (ret []) l

      let foldmap f g t = match t with
      | BinOp (a, op, b) -> ret (fun a b -> BinOp (a, op, b)) <*> f a <*> f b
      | UnOp (a, op) -> ret (fun a -> UnOp(a, op)) <*> f a
      | Lief l -> ret (Lief l)
      | Call (n, li) -> ret (fun x ->  Call (n, x)) <*> fold_left_map f li
      | Tuple e -> ret (fun e -> Tuple e)  <*> fold_left_map f e
      | Record li ->
          let f' (a, x) = ret (fun x -> a, x) <*> f x in
          ret (fun e -> Record e) <*>  fold_left_map f' li
      | Access m ->
          let annot = Mutable.Fixed.annot m in
          ret (fun m -> Access m) <*> Mut.map f m
      | Lexems x -> ret (fun x -> Lexems x) <*> fold_left_map (Lex.map_expr f g) x

    end
  end)

  type 'a t = 'a Fixed.t
  let fix = Fixed.fix
  let unfix = Fixed.unfix

  (** module de réécriture et de parcours d'AST *)
  module Writer = AstWriter.F (struct
    type 'a alias = 'a t
    type 'a t = 'a alias
    let foldmap f acc t = Fixed.Surface.foldmapt (fun x acc -> f acc x) t acc
  end)

  (** {2 utils} *)

let lief l = fix (Lief l)

  let bool b = lief (Bool b)

  let enum e = lief (Enum e)

  let unop op a = fix (UnOp (a, op))
  let binop op a b = fix (BinOp (a, op, b))

  let integer i = lief (Integer i)
  let char i = lief (Char i)
  let string f = lief (String f)

  let lexems li = fix (Lexems li)

  let access m = fix (Access m )
  let tuple li = fix (Tuple li )
  let record li = fix (Record li )

  let add e1 e2 = binop Add e1 e2
  let sub e1 e2 = binop Sub e1 e2
  let mul e1 e2 = binop Mul e1 e2
  let div e1 e2 = binop Div e1 e2

  let call name li = fix ( Call(name, li))

  let default_value t = match Type.unfix t with
    | Type.Integer -> integer 0
    | Type.String -> string ""
    | Type.Char -> char '_'
    | Type.Array _ -> failwith ("new array is not an expression")
    | Type.Lexems -> failwith ("lexems is not an expression")
    | Type.Void -> failwith ("no dummy expression for void")
    | Type.Bool -> bool false
    | Type.Named _ -> failwith ("new named is not an expression")
    | Type.Auto -> failwith ("auto is not an expression")
    | Type.Struct _ -> failwith ("new struct is not an expression")
    | Type.Enum _ -> failwith ("new enum is not an expression")
    | Type.Tuple _ -> failwith ("new tuple is not an expression")

  let is_integer i e = match unfix e with
  | Lief (Integer i2) when i = i2 -> true
  | _ -> false

  let saddi a b = match unfix a with
  | BinOp (a, Sub, c) when is_integer b c -> a
  | _ -> binop Add a (integer b)

end

(**
   instructions metalang
*)
module Instr = struct

  type declaration_option =
    {
      useless : bool;
    }

  let default_declaration_option =
    {
      useless = false
    }

  let useless_declaration_option =
    {
      useless = true
    }

  type ('a, 'expr) tofix =
    Declare of varname * Type.t * 'expr * declaration_option
  | Affect of 'expr Mutable.t * 'expr
  | Loop of varname * 'expr * 'expr * 'a list
  | While of 'expr * 'a list
  | Comment of string
  | Tag of string
  | Return of 'expr
  | AllocArray of varname * Type.t * 'expr * (varname * 'a list) option * declaration_option
  | AllocArrayConst of varname * Type.t * 'expr * Expr.lief * declaration_option
  | AllocRecord of varname * Type.t * (fieldname * 'expr) list * declaration_option
  | If of 'expr * 'a list * 'a list
  | Call of funname * 'expr list
  | Print of Type.t * 'expr
  | Read of Type.t * 'expr Mutable.t
  | DeclRead of Type.t * varname * declaration_option
  | Untuple of (Type.t * varname) list * 'expr * declaration_option
  | StdinSep
  | Unquote of 'expr

  let fold_map_bloc f acc t = match t with
    | Declare (a, b, c, d) -> acc, Declare (a, b, c, d)
    | Affect (var, e) -> acc, Affect (var, e)
    | Comment s -> acc, Comment s
    | Loop (var, e1, e2, li) ->
      let acc, li = f acc li in
      acc, Loop (var, e1, e2, li)
    | While (e, li) ->
      let acc, li = f acc li in
      acc, While (e, li)
    | If (e, cif, celse) ->
      let acc, cif = f acc cif in
      let acc, celse = f acc celse in
      acc, If (e, cif, celse)
    | Return e -> acc, Return e
    | AllocArray (b, t, l, Some ((b2, li)), opt) ->
      let acc, li = f acc li in
      acc, AllocArray (b, t, l, Some((b2, li)), opt)
    | AllocArray (a, b, c, None, opt) ->
      acc, AllocArray (a, b, c, None, opt)
    | AllocRecord (a, b, c, opt) ->
      acc, AllocRecord (a, b, c, opt)
    | Print (a, b) -> acc, Print (a, b)
    | Read (a, b) -> acc, Read (a, b)
    | DeclRead (a, b, opt) -> acc, DeclRead (a, b, opt)
    | Call (a, b) -> acc, Call (a, b)
    | StdinSep -> acc, StdinSep
    | Unquote e -> acc, Unquote e
    | Untuple (lis, e, opt) -> acc, Untuple (lis, e, opt)
    | Tag e -> acc, Tag e
    | AllocArrayConst (v, t, e1, e2, d) -> acc, AllocArrayConst (v, t, e1, e2, d)

  let map_bloc f t = match t with
    | Declare (a, b, c, d) -> Declare (a, b, c, d)
    | Affect (var, e) -> Affect (var, e)
    | Comment s -> Comment s
    | Loop (var, e1, e2, li) ->
      Loop (var, e1, e2, f li)
    | While (e, li) -> While (e, f li)
    | If (e, cif, celse) ->
      If (e, f cif, f celse)
    | Return e -> Return e
    | AllocArray (b, t, l, Some ((b2, li)), opt) ->
      AllocArray (b, t, l, Some((b2, f li)), opt)
    | AllocArray (a, b, c, None, opt) ->
      AllocArray (a, b, c, None, opt)
    | AllocRecord (a, b, c, opt) ->
      AllocRecord (a, b, c, opt)
    | Print (a, b) -> Print (a, b)
    | Read (a, b) -> Read (a, b)
    | DeclRead (a, b, opt) -> DeclRead (a, b, opt)
    | Call (a, b) -> Call (a, b)
    | StdinSep -> StdinSep
    | Unquote e -> Unquote e
    | Untuple (lis, e, opt) -> Untuple (lis, e, opt)
    | Tag e -> Tag e
    | AllocArrayConst (v, t, e1, e2, d) -> AllocArrayConst (v, t, e1, e2, d)

  let map f t =
    map_bloc (List.map f) t

  module Fixed = Fix(struct
    type ('a, 'b) alias = ('a, 'b) tofix
    type ('a, 'b) tofix = ('a, 'b) alias
    let map = map
    let next () = next ()
  end)
  type 'a t = 'a Fixed.t
  let fixa = Fixed.fixa
  let fix = Fixed.fix
  let unfix = Fixed.unfix

  let rec deep_map_bloc f t =
    map_bloc (
      f @* List.map (fun i ->
        let annot = Fixed.annot i in
        let i = deep_map_bloc f (unfix i) in
        (Fixed.fixa annot i)
      )) t

  let stdin_sep () = StdinSep |> fix
  let print t v = Print (t, v) |> fix
  let read t v = Read (t, v) |> fix
  let readdecl t v opt = DeclRead (t, v, opt) |> fix
  let call v p = Call (v, p) |> fix
  let declare v t e opt =  Declare (v, t, e, opt) |> fix
  let affect v e = Affect (v, e) |> fix
  let unquote e = Unquote e |> fix
  let loop v e1 e2 li = Loop (v, e1, e2, li) |> fix
  let while_ e li = While (e, li) |> fix
  let comment s = Comment s |> fix
  let tag s = Tag s |> fix
  let return e = Return e |> fix
  let untuple li e opt = Untuple (li, e, opt) |> fix
  let alloc_array binding t len opt =
    AllocArray(binding, t, len, None, opt) |> fix
  let alloc_record binding t fields opt =
    AllocRecord(binding, t, fields, opt) |> fix
  let alloc_array_lambda binding t len b e opt =
    AllocArray(binding, t, len, Some ( (b, e) ), opt ) |> fix


  let alloc_array_lambda_opt binding t len lambda opt =
    AllocArray(binding, t, len, lambda, opt ) |> fix

  let if_ e cif celse =
    If (e, cif, celse) |> fix

  (** module de réécriture et de parcours d'AST *)
  module Writer = AstWriter.F (struct
    type 'a alias = 'a t;;
    type 'a t = 'a alias;;
    let foldmap f acc t =
      let annot = Fixed.annot t in
      match unfix t with
      | StdinSep -> acc, t
      | Declare (_, _, _, _) -> acc, t
      | Affect (_, _) -> acc, t
      | Comment _ -> acc, t
      | Loop (var, e1, e2, li) ->
        let acc, li = List.fold_left_map f acc li in
        acc, Fixed.fixa annot (Loop(var, e1, e2, li))
      | While (e, li) ->
        let acc, li = List.fold_left_map f acc li in
        acc, Fixed.fixa annot (While (e, li))
      | If (e, cif, celse) ->
        let acc, cif = List.fold_left_map f acc cif in
        let acc, celse = List.fold_left_map f acc celse in
        acc, Fixed.fixa annot (If(e, cif, celse))
      | Return e -> acc, t
      | AllocArray (_, _, _, None, _) -> acc, t
      | AllocArray (b, t, l, Some (b2, li), opt) ->
        let acc, li = List.fold_left_map f acc li in
        acc, Fixed.fixa annot (AllocArray (b, t, l, Some (b2, li), opt ))
      | AllocRecord (_, _, _, _) | AllocArrayConst _ | Print _
      | Read _ | DeclRead _ | Untuple _ | Call _ | Unquote _ | Tag _ -> acc, t
  end)

  let foldmap_expr
      f acc instruction =
    Writer.Deep.foldmap
      (fun acc i ->
        let a = Fixed.annot i in
        let out, i =
          match unfix i with
          | Declare (v, t, e, opt) ->
            let acc, e = f acc e in
            acc, Declare (v, t, e, opt)
          | Affect (m, e) ->
            let acc, m = Mutable.foldmap_expr f acc m in
            let acc, e = f acc e in
            acc, Affect (m, e)
          | Loop (v, e1, e2, li) ->
            let acc, e1 = f acc e1 in
            let acc, e2 = f acc e2 in
            acc, Loop(v, e1, e2, li)
          | While (e, li) ->
            let acc, e = f acc e in
            acc, While (e, li)
          | Comment s -> acc, Comment s
          | Return e ->
            let acc, e = f acc e in
            acc, Return e
          | AllocArray (v, t, e, liopt, opt) ->
            let acc, e = f acc e in
            acc, AllocArray (v, t, e, liopt, opt)
          | AllocRecord (v, t, el, opt) ->
            let acc, el = List.fold_left_map
              (fun acc (field, e) ->
                let acc, e = f acc e
                in acc, (field, e))
              acc el
            in acc, AllocRecord (v, t, el, opt)
          | If (e, li1, li2) ->
            let acc, e = f acc e in
            acc, If (e, li1, li2)
          | Call (funname, li) ->
            let acc, li = List.fold_left_map f acc li in
            acc, Call (funname, li)
          | Print (t, e) ->
            let acc, e = f acc e in
            acc, Print (t, e)
          | Untuple (li, e, opt) ->
            let acc, e = f acc e in
            acc, Untuple (li, e, opt)
          | Read (t, m) ->
            let acc, m = Mutable.foldmap_expr f acc m in
            acc, Read (t, m)
          | DeclRead (t, m, opt) ->
            acc, DeclRead (t, m, opt)
          | AllocArrayConst (v, t, e1, e2, d) ->
              let acc, e1 = f acc e1 in
              acc, AllocArrayConst (v, t, e1, e2, d)
          | StdinSep -> acc, StdinSep
          | Unquote e -> acc, Unquote e
          | Tag e -> acc, Tag e
        in out, fixa a i
      ) acc instruction

  let map_expr : (('a -> 'b) -> 'a t -> 'b t) = fun f i ->
    let f2 () e = (), (f e) in
    let (), i = foldmap_expr f2 () i
    in i

  let remexpr : ('a t -> unit t) = fun i -> map_expr (fun e -> ()) i

  let fold_expr f acc i =
    let f2 acc e = (f acc e), e in
    let acc, _ = foldmap_expr f2 acc i
    in acc

end

module Prog = struct

  type declaration_option =
    {
      useless : bool;
    }

  let default_declaration_option =
    {
      useless = false
    }

  let useless_declaration_option =
    {
      useless = true
    }

  type 'lex t_fun =
    DeclarFun of funname * Type.t *
        ( varname * Type.t ) list * 'lex Expr.t Instr.t list * declaration_option
  | DeclareType of typename * Type.t
  | Macro of funname * Type.t * (string * Type.t) list * (string * string) list
  | Comment of string
  | Unquote of 'lex Expr.t

  let unquote u = Unquote u
  let comment s = Comment s
  let declarefun var t li1 li2 opt = DeclarFun (var, t, li1, li2, opt)
  let macro var t params li = Macro (var, t, params, li)

  (** global programm type :
      values of this type contains a full metalang programm *)
  type 'lex t =
    {
      progname : string;
      funs : 'lex t_fun list;
      main : 'lex Expr.t Instr.t list option;
      reads : TypeSet.t;
      hasSkip : bool;
    }

end

type 'a expr = 'a Expr.t
type 'a instr = 'a Expr.t Instr.t
