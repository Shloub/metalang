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

let debug_varname f = function
  | UserName s -> Format.fprintf f "UserName %S" s
  | InternalName i -> Format.fprintf f "InternalName %d" i

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

let punitlist f li =
  Format.fprintf f "[@[%a@]]"
    (Printers.print_list (fun f i -> i f ()) (fun f -> Format.fprintf f "%a;@ %a")) li

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

  let pdebug f = function
    | Var v -> Format.fprintf f "Var (%a)" debug_varname v
    | Array (m, li) -> Format.fprintf f "Array (%a, [%a])" m () punitlist li
    | Dot (m, fi) -> Format.fprintf f "Dot(%a, %s)" m () fi

  (** {2 Parcours} *)
  module Fixed = Fix2( struct
    let next () = next ()
    type ('a, 'b) alias = ('a, 'b) tofix
    type ('a, 'b) tofix = ('a, 'b) alias
    module Make(F:Applicative) = struct
      open F
      module LF = ListApp(F)
      open LF
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
    Fixed.Deep.foldmap2i_topdown
      (fun i x acc -> acc, Fixed.fixa i x)
      (fun x acc -> f acc x) mut acc

  let map_expr f m = Fixed.Deep.mapg f m

  let fold_expr f acc i = Fixed.Deep.foldg (fun x acc -> f acc x) i acc

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
      module LF = ListApp(F)
      open LF
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

  let pdebug_unop f op = Format.fprintf f (match op with
  | Neg -> "Neg" | Not -> "Not")

  (** binary operators *)
  type binop =
  | Add | Sub | Mul | Div (* int *)
  | Mod (* int *)
  | Or | And (* bool *)
  | Lower | LowerEq | Higher | HigherEq (* 'a *)
  | Eq | Diff (* 'a *)

  let pdebug_binop f op = Format.fprintf f (match op with
  | Add -> "Add" | Sub -> "Sub" | Mul -> "Mul"
  | Div -> "Div" | Mod -> "Mod" | Or -> "Or" | And -> "And"
  | Lower -> "Lower" | LowerEq -> "LowerEq" | Higher -> "Higher" | HigherEq -> "HigherEq"
  | Eq -> "Eq" | Diff -> "Diff")

  type lief =
  | Char of char
  | String of string
  | Integer of int
  | Bool of bool
  | Enum of string (** enumerateur *)

  let pdebug_lief f = function
    | Char c -> Format.fprintf f "Char %C" c
    | String s -> Format.fprintf f "String %S" s
    | Integer i -> Format.fprintf f "Integer %i" i
    | Bool b -> Format.fprintf f "Bool %b" b
    | Enum s -> Format.fprintf f "Enum %S" s

  type ('a, 'lex) tofix =
    BinOp of 'a * binop * 'a (** operations binaires *)
  | UnOp of 'a * unop (** operations unaires *)
  | Lief of lief
  | Access of 'a Mutable.t (** vaut la valeur du mutable *)
  | Call of funname * 'a list (** appelle la fonction *)
  | Lexems of ('lex, 'a) Lexems.t list (** contient un bout d'AST *)
  | Tuple of 'a list
  | Record of (fieldname * 'a) list

let pdebug f = function
  | BinOp(a, op, b) -> Format.fprintf f "E.BinOp(%a, %a, %a)" a () pdebug_binop op b ()
  | UnOp(a, unop) -> Format.fprintf f "E.UnOp(%a, %a)" a () pdebug_unop unop
  | Lief l -> Format.fprintf f "E.Lief(%a)" pdebug_lief l
  | Access mut ->
      let mut = Mutable.Fixed.Deep.fold (fun m f () -> Mutable.pdebug f m) mut in
      Format.fprintf f "E.Access(%a)" mut ()
  | Call (name, li) -> Format.fprintf f "E.Call(%S, %a)" name punitlist li
  | Lexems li -> assert false (* TODO *)
  | Tuple li -> Format.fprintf f "E.Tuple(%a)" punitlist li
  | Record li -> Format.fprintf f "E.Record(%a)" punitlist (List.map (fun (field, e) f () ->
      Format.fprintf f "(%S, %a)" field e ()) li)

  (** {2 parcours} *)

  module Fixed = Fix2(struct
    type ('a,'b) alias = ('a, 'b) tofix
    type ('a, 'b) tofix = ('a, 'b) alias
    let next () = next ()
    module Make(F:Applicative) = struct
      open F
      module Mut = Mutable.Fixed.Apply(F)
      module Lex = Lexems.Apply(F)
      module LF = ListApp(F)
      open LF

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


  let pdebug_deep f e = Fixed.Deep.fold (fun e f () -> pdebug f e) e f ()

  let add_bindings x =
    Fixed.Deep.fold
      (function
        | Access m ->
            Mutable.Fixed.Deep.fold (function
              | Mutable.Var v -> (fun acc -> BindingSet.add v acc)
              | x -> Mutable.Fixed.Surface.fold (fun a b -> a @* b) (fun x -> x) x
                                    ) m
        | x -> (fun acc -> Fixed.Surface.fold (fun acc f -> f acc) acc x)
      ) x
  let bindings x = add_bindings x BindingSet.empty
    
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

  let popt f opt =
    Format.fprintf f "{useless=%b}" opt.useless

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

  let pdebug f = function
  | Declare (va, ty, e, opt) -> Format.fprintf f "I.Declare(%a, %s, %a, %a)"
        debug_varname va
        (Type.type_t_to_string ty)
        e ()
        popt opt
  | Affect (mut, e) ->
      let mut = Mutable.Fixed.Deep.fold (fun m f () -> Mutable.pdebug f m) mut in
      Format.fprintf f "I.Affect(%a, %a)" mut () e ()
  | Loop (var, e1, e2, li) ->
      Format.fprintf f "I.Loop(%a, %a, %a, %a)"
        debug_varname var
        e1 () e2 () punitlist li
  | While (e, li) -> Format.fprintf f "I.While(%a, %a)" e () punitlist li
  | Comment(s) -> Format.fprintf f "I.Comment(%S)" s
  | Tag(s) -> Format.fprintf f "I.Tag(%S)" s
  | Return(e) -> Format.fprintf f "I.Return(%a)" e ()
  | AllocArray(name, ty, e, None, opt) ->
      Format.fprintf f "I.AllocArray(%a, %s, %a, None, %a)"
        debug_varname name
        (Type.type_t_to_string ty)
        e ()
        popt opt
  | AllocArray(name, ty, e, Some(name2, li), opt) ->
      Format.fprintf f "I.AllocArray(%a, %s, %a, Some(%a, %a), %a)"
        debug_varname name
        (Type.type_t_to_string ty)
        e ()
        debug_varname name2
        punitlist li
        popt opt
  | AllocArrayConst(name, ty, e, lief, opt) ->
      Format.fprintf f "I.AllocArrayConst(%a, %s, %a, %a, %a)" debug_varname name
        (Type.type_t_to_string ty)
        e ()
        Expr.pdebug_lief lief
        popt opt
  | AllocRecord(name, ty, li, opt) -> Format.fprintf f "I.AllocRecord(%a, %s, %a, %a)"
        debug_varname name
        (Type.type_t_to_string ty)
        punitlist (List.map (fun (a, b) f () -> Format.fprintf f "(%S,@ %a)" a b () ) li)
        popt opt
  | If(e, a, b) -> Format.fprintf f "I.If(@[%a,@\n%a,@\n%a@])" e () punitlist a punitlist b
  | Call(name, li) -> Format.fprintf f "I.Call(%S, %a)" name punitlist li
  | Print(ty, e) -> Format.fprintf f "I.Print(%s, %a)" (Type.type_t_to_string ty) e ()
  | Read(ty, mut) ->
      let mut = Mutable.Fixed.Deep.fold (fun m f () -> Mutable.pdebug f m) mut in
      Format.fprintf f "I.Mut(%s, %a)" (Type.type_t_to_string ty) mut ()
  | DeclRead(ty, name, opt) ->
      Format.fprintf f "I.DeclRead(%s, %a, %a)" (Type.type_t_to_string ty)
        debug_varname name
        popt opt
  | Untuple(li, e, opt) -> Format.fprintf f "I.Untuple(%a, %a, %a)"
        punitlist (List.map (fun (ty, name) f () -> Format.fprintf f "(%s,@ %a)"
            (Type.type_t_to_string ty)
            debug_varname name) li)
        e () popt opt
  | StdinSep -> Format.fprintf f "StdinSep"
  | Unquote(e) -> Format.fprintf f "I.Unquote(%a)" e ()

  module Make(F:Applicative) = struct
    open F
    module Mut = Mutable.Fixed.Apply(F)
    module LF = ListApp(F)
    open LF
    let foldmap_bloc f g t =
      let g' (a, x) = ret (fun x -> a, x) <*> g x in
      let g'' (x, a) = ret (fun x -> x, a) <*> g x in
      match t with
      | Declare (a, b, c, d) -> ret (fun c -> Declare (a, b, c, d)) <*> g c 
      | Affect (m, e) -> ret (fun m e -> Affect (m, e)) <*> Mut.map g m <*> g e
      | Comment s -> ret (Comment s)
      | Loop (var, e1, e2, li) -> ret (fun e1 e2 li -> Loop (var, e1, e2, li)) <*> g e1 <*> g e2 <*> f li
      | While (e, li) -> ret (fun e li -> While (e, li)) <*> g e <*> f li 
      | If (e, cif, celse) -> ret (fun e cif celse -> If (e, cif, celse)) <*> g e <*> f cif <*> f celse
      | Return e -> ret (fun e -> Return e) <*> g e
      | AllocArray (b, t, l, Some ((b2, li)), opt) -> ret (fun l li -> AllocArray (b, t, l, Some((b2, li)), opt)) <*> g l <*> f li
      | AllocArray (a, b, c, None, opt) -> ret (fun c -> AllocArray (a, b, c, None, opt)) <*> g c
      | AllocRecord (a, b, c, opt) -> ret (fun c -> AllocRecord (a, b, c, opt)) <*> fold_left_map g' c
      | Print (a, b) -> ret (fun b -> Print (a, b)) <*> g b
      | Read (a, b) -> ret ( fun b -> Read (a, b) ) <*> Mut.map g b
      | DeclRead (a, b, opt) -> ret (DeclRead (a, b, opt))
      | Call (a, b) -> ret (fun b -> Call (a, b)) <*> fold_left_map g b
      | StdinSep -> ret StdinSep
      | Unquote e -> ret (fun e -> Unquote e) <*> g e
      | Untuple (lis, e, opt) -> ret (fun e -> Untuple (lis, e, opt)) <*> g e
      | Tag e -> ret (Tag e)
      | AllocArrayConst (v, t, e1, e2, d) -> ret (fun e1 -> AllocArrayConst (v, t, e1, e2, d)) <*> g e1
    let foldmap f g t = foldmap_bloc (fold_left_map f) g t   
  end
  module Fixed = Fix2(struct
    type ('a,'b) alias = ('a, 'b) tofix
    type ('a, 'b) tofix = ('a, 'b) alias
    let next () = next ()
    module Make = Make
  end)

  type 'a t = 'a Fixed.t
  let fixa = Fixed.fixa
  let fix = Fixed.fix
  let unfix = Fixed.unfix

  let pdebug_exprinstr f i =
    Fixed.Deep.fold2_bottomup (fun i f () -> pdebug f i) (fun e f () -> Expr.pdebug_deep f e) i f ()
  let debug_shape f i = pdebug f (Fixed.Surface.map2 (fun _ _ () -> ()) (fun _ _ () -> ()) i)


  let add_bindings (x: 'a Expr.t t) =
    let fli li acc = List.fold_left (fun acc f -> f acc) acc li in
    let mut m acc = Mutable.fold_expr (fun acc e -> e acc) acc m in
    Fixed.Deep.fold2_bottomup
      (function
        | Declare (n, _, e, _)
        | AllocArray (n, _, e, None, _)
        | AllocArrayConst (n, _, e, _, _) ->  e @* BindingSet.add n
        | Affect (m, e) -> e @* mut m
        | Loop (v, e, f, li) -> e @* f @* BindingSet.add v @* (fun acc -> List.fold_left (fun acc f -> f acc) acc li)
        | While (e, li) -> e @* fli li
        | Comment _
        | Tag _ -> (fun acc -> acc)
        | AllocArray (n, _, e, Some (n2, li), _) -> e @* BindingSet.add n @* BindingSet.add n2 @* fli li
        | AllocRecord (n, _, li, _) ->BindingSet.add n @* (fun acc -> List.fold_left (fun acc (_, f) -> f acc) acc li)
        | If (e, l1, l2) -> e @* fli l1 @* fli l2
        | Call (_, eli) -> (fun acc -> List.fold_left (fun acc f -> f acc) acc eli)
        | Return e
        | Print (_, e) -> e
        | Read (_, m) -> mut m
        | DeclRead (_, v, _) -> BindingSet.add v
        | Untuple (li, e, _) -> e @* (fun acc -> List.fold_left (fun acc (_, v) -> BindingSet.add v acc) acc li)
        | Unquote e -> e
        | x -> (fun acc -> Fixed.Surface.fold (fun acc f -> f acc) acc x)
      )
      Expr.add_bindings x

  let bindings x = add_bindings x BindingSet.empty

  let fold_map_bloc (type acc) f ac t =
    let module A = Applicatives.FoldMap(struct type t = acc end) in
    let module M = Make(A) in
    M.foldmap_bloc (fun a acc -> f acc a) A.ret t ac

  let map_bloc f t =
    let module A = Applicatives.Map in
    let module M = Make(A) in
    M.foldmap_bloc f A.ret t

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
    type 'a alias = 'a t
    type 'a t = 'a alias
    let foldmap f acc t = Fixed.Surface.foldmapt (fun x acc -> f acc x) t acc
  end)

  let map_expr : (('a -> 'b) -> 'a t -> 'b t) = Fixed.Deep.mapg

  let foldmap_expr f acc i =
    Fixed.Deep.foldmap2i_topdown
      (fun i x acc -> acc, fixa i x)
      (fun x acc -> f acc x) i acc

  let fold_expr f acc i = Fixed.Deep.foldg (fun x acc -> f acc x) i acc

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
