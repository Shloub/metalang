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

(** some utility functions for printers
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

let print_option (f : Format.formatter -> 'a -> unit) t obj =
  match obj with
  | None -> ()
  | Some s -> f t s

let print_list = Printers.print_list

let sep format f pa a pb b = Format.fprintf f format pa a pb b
let nosep f = sep "%a%a" f
let sep_space f = sep "%a %a" f
let sep_nl f = sep "%a@\n%a" f
let sep_c f = sep "%a, %a" f
let sep_cnl f = sep "%a,@\n%a" f
let sep_dc f = sep "%a; %a" f


let print_list_indexed print sep f li =
  print_list
    (fun f (toprint, index) ->
      print f toprint index
    )
    sep
    f
    (snd (List.fold_left_map
            (fun i m -> (i+1), (m, i))
            0
            li
     ))

let print_ntimes n f s =
  for i = 1 to n do
    Format.fprintf f "%s" s
  done

let simple_expression e =
  let f tra acc e = match Ast.Expr.unfix e with
  | Ast.Expr.Access m -> begin match Ast.Mutable.unfix m with
    | Ast.Mutable.Var _ -> acc
    | _ -> false
  end
  | Ast.Expr.Lief l -> acc
  | Ast.Expr.UnOp _
  | Ast.Expr.BinOp _ -> tra acc e
  | _ -> false
  in f (Ast.Expr.Writer.Traverse.fold f) true e

let contains_instr f prog =
    let cli = List.exists (Ast.Instr.Writer.Deep.exists f) in
    Option.map_default false cli prog.Ast.Prog.main ||
    (List.exists (function Ast.Prog.DeclarFun (_, _, _, instrs, _) -> cli instrs | _ -> false)
    prog.Ast.Prog.funs)

let parens (pa:int) pb f format =
  if pa < pb then Format.fprintf f ("(" ^^ format ^^ ")")
  else Format.fprintf f format

let print_op f op =
  let open Ast.Expr in
  Format.fprintf f (match op with
  | Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"
  | Mod -> "%%"
  | Or -> "||"
  | And -> "&&"
  | Lower -> "<"
  | LowerEq -> "<="
  | Higher -> ">"
  | HigherEq -> ">="
  | Eq -> "=="
  | Diff -> "!=")

let print_unop f op =
  let open Ast.Expr in
  Format.fprintf f (match op with
  | Neg -> "-"
  | Not -> "!")

let assoc x = x, x, x
let nonassocr x = x, x, x - 1
let nonassocl x = x, x - 1, x
let nonassoclr x = x, x - 1, x - 1

type config = {
    prio_binop : Ast.Expr.binop -> int * int * int ;
    prio_unop : Ast.Expr.unop -> int;
    print_varname : Format.formatter -> Ast.varname -> unit;
    print_lief : int -> Format.formatter -> Ast.Expr.lief -> unit;
    print_op : Format.formatter -> Ast.Expr.binop -> unit;
    print_unop : Format.formatter -> Ast.Expr.unop -> unit;
    macros : (Ast.Type.t * (string * Ast.Type.t) list * string) StringMap.t;
    print_mut : config -> int -> Format.formatter -> (Format.formatter -> int -> unit) Ast.Mutable.Fixed.t -> unit
}

let prio_binop op =
  let open Ast.Expr in match op with
  | Mul -> assoc 5
  | Div
  | Mod -> nonassocr 5
  | Add -> assoc 7
  | Sub -> nonassocr 7
  | Lower
  | LowerEq
  | Higher
  | HigherEq -> assoc 9
  | Eq -> nonassocl 11
  | Diff -> nonassocl 11
  | And -> assoc 13
  | Or -> assoc 13
        
let prio_binop_equal = function
  | Ast.Expr.Eq -> nonassoclr 11
  | op -> prio_binop op

let prio_unop op =
  let open Ast.Expr in match op with
  | Neg -> 1
  | Not -> 3

let nop = 15

let print_expr0 c e f prio_parent =
  let open Format in
  let open Ast.Expr in match e with
  | BinOp (a, op, b) ->
      let prio, priol, prior = c.prio_binop op in
      parens prio_parent prio f "%a %a %a" a priol c.print_op op b prior
  | UnOp (a, op) -> 
      let prio = c.prio_unop op in
      parens prio_parent prio f "%a%a" c.print_unop op a prio
  | Lief l -> c.print_lief prio_parent f l
  | Access m -> c.print_mut c prio_parent f m
  | Call (func, li) ->
      begin match StringMap.find_opt func c.macros with
      | Some ( (_, params, code) ) ->
          let li = List.map
              (fun e ->
                let b = Buffer.create 1 in
                let fb = Format.formatter_of_buffer b in
                Format.fprintf fb "@[<hov>%a@]%!" e nop;
                Buffer.contents b
              ) li in
          let expanded = List.fold_left
              (fun s ((param, _type), string) ->
                String.replace ("$__MACRO__PARAM__"^param) string s
              )
              (String.replace "$" "$__MACRO__PARAM__" code)
              (List.combine params li)
          in let expanded = String.replace "$__MACRO__PARAM__" "$" expanded
          in Format.fprintf f "%s" expanded
      | None -> fprintf f "%s(%a)" func (print_list (fun f x -> x f nop) sep_c) li
      end
  | Lexems li -> assert false
  | Tuple li -> fprintf f "(%a)" (print_list (fun f x -> x f nop) sep_c) li
  | Record li -> fprintf f "{%a}" (print_list (fun f (name, x) ->
      fprintf f "%S:%a" name x nop) sep_c) li

let print_expr c e f p = Ast.Expr.Fixed.Deep.fold (print_expr0 c) e f p

let format_type f t =
  let open Ast.Type in Format.fprintf f (match unfix t with
  | Integer -> "%%d"
  | Char -> "%%c"
  | String ->  "%%s"
  | Bool -> "%%"
  | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (type_t_to_string t))))

type iprinter = {
    is_if : bool;
    is_comment : bool;
    p : Format.formatter -> unit -> unit
}

let print_ilist f li =
  Format.fprintf f "{@\n%a@]@\n}" (print_list (fun f i -> i.p f ()) sep_nl) li

let print_instr c i =
  let open Ast.Instr in
  let p f () =
    let open Format in match i with
    | Declare (var, ty, e, _) -> fprintf f "%a = %a;" c.print_varname var e nop
    | Affect (mut, e) -> fprintf f "%a = %a" (c.print_mut c nop) mut e nop
    | Loop (var, e1, e2, li) -> fprintf f "for (%a=%a; %a<=%a; %a++)%a"
          c.print_varname var e1 nop
          c.print_varname var e2 nop
          c.print_varname var
          print_ilist li
    | While (e, li) -> fprintf f "@[<v 2>while(@[<h>%a@])%a" e nop print_ilist li
    | Comment s -> fprintf f "/*%s*/" s
    | Tag s -> fprintf f "/*%S*/" s
    | Return e -> fprintf f "return %a;" e nop
    | AllocArray (name, t, e, None, opt) -> fprintf f "var %a = array();" c.print_varname name
    | AllocArray (name, t, e, Some (var, lambda), opt) -> assert false
    | AllocArrayConst (name, ty, len, lief, opt) ->
        fprintf f "@[<h>%a = array_fill(0, %a, %a);@]" c.print_varname name
          len nop (c.print_lief nop) lief
    | AllocRecord (name, ty, list, opt) ->
        fprintf f "%a = array(%a);" c.print_varname name
          (print_list (fun f (field, x) -> printf "%S => %a" field x nop) sep_c) list
    | If (e, listif, []) ->
        fprintf f "@[<v 2>if (%a)%a" e nop print_ilist listif
    | If (e, listif, listelse) ->
        fprintf f "@[<v 2>if (%a)%a@\n@[<v 2>else %a" e nop print_ilist listif print_ilist listelse
    | Call (func, li) -> fprintf f "%s(%a)" func (print_list (fun f x -> x f nop) sep_c) li
    | Print (ty, e) -> fprintf f "echo %a;" e nop
    | Read (ty, mut) -> begin match Ast.Type.unfix ty with
      | Ast.Type.Char -> fprintf f "@[%a = nextChar();@]" (c.print_mut c nop) mut
      | _ -> fprintf f "@[list(%a) = scan(\"%a\");@]" (c.print_mut c nop) mut format_type ty
    end
    | DeclRead (ty, v, opt) ->
        begin match Ast.Type.unfix ty with
        | Ast.Type.Char -> fprintf f "@[%a = nextChar();@]" c.print_varname v
        | _ -> fprintf f "@[list(%a) = scan(\"%a\");@]" c.print_varname v format_type ty
        end
    | Untuple (li, expr, opt) -> fprintf f "list(%a)=%a;" (print_list c.print_varname sep_c) (List.map snd li) expr nop
    | StdinSep -> Format.fprintf f "@[scantrim();@]"
    | Unquote e -> assert false in
  let is_if = match i with If (_, _, _) -> true | _ -> false in
  let is_comment = match i with Comment _ -> true | _ -> false in
  {
   is_if = is_if;
   is_comment = is_comment;
   p=p;
 }

let print_instr c i =
  let open Ast.Instr.Fixed.Deep in
  (fold (print_instr c) (mapg (print_expr c) i)).p

let print_mut c m f priority =
  let open Format in
  let open Ast.Mutable in match m with
  | Var v -> c.print_varname f v
  | Array (m, fi) -> fprintf f "%a%a" m priority
        (print_list (fun f a -> fprintf f "[%a]" a nop) nosep) fi
  | Dot (m, field) -> fprintf f "%a[%S]" m priority field
 
let print_mut conf priority f m = Ast.Mutable.Fixed.Deep.fold (print_mut conf) m f priority

let print_lief prio f l =
  let open Ast.Expr in match l with
  | Char c -> Format.fprintf f "%C" c
  | String s -> Format.fprintf f "%S" s
  | Integer i ->
      if i < 0 then parens prio (-1) f "%i" i
      else Format.fprintf f "%i" i
  | Bool true -> Format.fprintf f "true"
  | Bool false -> Format.fprintf f "false"
  | Enum s -> Format.fprintf f "%s" s

let print_varname f = function
  | Ast.UserName v -> Format.fprintf f "%s" v
  | Ast.InternalName _ -> assert false
