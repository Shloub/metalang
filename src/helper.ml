(*
 * Copyright (c) 2012 - 2016, Prologin
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

open Ext

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
  | Mod -> nonassocr 7
  | Add -> assoc 9
  | Sub -> nonassocr 9
  | Lower
  | LowerEq
  | Higher
  | HigherEq -> assoc 11
  | Eq -> nonassocl 13
  | Diff -> nonassocl 13
  | And -> assoc 15
  | Or -> assoc 15

let prio_binop_equal = function
  | Ast.Expr.Eq -> nonassoclr 13
  | op -> prio_binop op

let prio_right (_, _, p) = p

let prio_unop op =
  let open Ast.Expr in match op with
  | Neg -> 1
  | Not -> 3

let nop = 100
let priority_recordacess = -10

let pmacros f fmt t params code li param =
  let listr = List.map
      (fun e ->
         let b = Buffer.create 1 in
         let fb = Format.formatter_of_buffer b in
         Format.fprintf fb "@[<h>%a@]%!" e param;
         Buffer.contents b
      ) li in
  let expanded = List.fold_left
      (fun s ((param, _type), string) ->
         String.replace ("$"^param) string s
      )
      code
      (List.combine params listr)
  in Format.fprintf f fmt expanded

let print_expr0 c e f prio_parent =
  let open Format in
  let open Ast.Expr in match e with
  | Just e -> e f prio_parent (* compatible php, javascript, python, ruby, common lisp *)
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
      | Some ( (t, params, code) ) ->
        pmacros f "%s" t params code li nop
      | None -> fprintf f "%s(%a)" func (print_list (fun f x -> x f nop) sep_c) li
    end
  | Lexems li -> assert false
  | Tuple li -> fprintf f "(%a)" (print_list (fun f x -> x f nop) sep_c) li
  | Record li -> fprintf f "{%a}" (print_list (fun f (name, x) ->
      fprintf f "%S:%a" name x nop) sep_c) li

let print_expr c e f p = Ast.Expr.Fixed.Deep.fold (print_expr0 c) e f p

let format_type t = match Ast.Type.unfix t with
  | Ast.Type.Integer -> "%d"
  | Ast.Type.Char -> "%c"
  | Ast.Type.String ->  "%s"
  | Ast.Type.Bool -> "%b"
  | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Ast.Type.type_t_to_string t))
               )
let pformat_type f t = Format.fprintf f "%s" (format_type t)

type 'a iprinter = {
  is_if : bool;
  is_if_noelse : bool;
  is_comment : bool;
  is_multi_instr : bool;
  p : Format.formatter -> 'a -> unit;
  default : 'a;
  print_lief : int -> Format.formatter -> Ast.Expr.lief -> unit;
}
let is_if i = match i with Ast.Instr.If (_, _, _) -> true | _ -> false
let is_if_noelse i = match i with Ast.Instr.If (_, _, []) -> true | _ -> false
let is_comment i = match i with Ast.Instr.Comment _ -> true | _ -> false

let clike_noformat s = let s = Format.sprintf "%S" s in String.replace "%" "%%" s
let extract_multi_print noformat formater_type li =
  let s, e = List.fold_left (fun (format, exprs) -> function
      | Ast.Instr.StringConst str ->
        let s = noformat str in
        format ^ (String.sub s 1 (String.length s - 2)), exprs
      | Ast.Instr.PrintExpr (t, expr) -> format ^ (formater_type t), (t, expr)::exprs) ("",  []) li
  in s, List.rev e

let seppt f () = Format.fprintf f ";"
let noseppt f () = ()
let plifor f li = print_list (fun f i -> i.p f noseppt) (sep "%a,%a") f li
let block f li =
  let open Format in
  let format = match List.filter (fun l -> not l.is_comment) li with
    | [i] when not i.is_multi_instr -> fprintf f "@\n    @[<v>%a@]"
    | _ -> fprintf f "@\n@[<v 4>{@\n%a@]@\n}" in
  format (print_list (fun f i -> i.p f i.default) sep_nl) li
let block_ifcase f li =
  let open Format in
  let format = match li with
    | [i] when not (i.is_if_noelse || i.is_multi_instr) -> fprintf f "@\n    @[<v>%a@]"
    | _ -> fprintf f "@\n@[<v 4>{@\n%a@]@\n}" in
  format (print_list (fun f i -> i.p f i.default) sep_nl) li

let print_mut0 fmt_array
    fmt_arrayindex
    fmt_dot
    c m f priority =
  let open Format in
  let open Ast.Mutable in match m with
  | Var v -> c.print_varname f v
  | Array (m, fi) -> fprintf f fmt_array m priority
                       (print_list (fun f a -> fprintf f fmt_arrayindex a nop) nosep) fi
  | Dot (m, field) -> fprintf f fmt_dot m priority_recordacess field

let print_mut conf priority f m = Ast.Mutable.Fixed.Deep.fold
    (print_mut0 "%a%a" "[%a]" "%a[%S]" conf) m f priority

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
  | Nil -> Format.fprintf f "null"

let print_varname f = function
  | Ast.UserName v -> Format.fprintf f "%s" v
  | Ast.InternalName _ -> assert false

let is_printable_i i =
  let lowerchar = i >= (int_of_char 'a') && i <= (int_of_char 'z') in
  let upperchar = i >= (int_of_char 'A') && i <= (int_of_char 'Z') in
  let digit = i >= (int_of_char '0') && i <= (int_of_char '9') in
  let specials = List.map int_of_char [ ' '; '|';
                                        '#'; '&'; '(';
                                        ')'; '*'; '+'; ','; '-';
                                        '.'; '/'; ':'; ';'; '<';
                                        '='; '>'; '_'; '|'; '!';
                                        '%'; '?'; '@'; '[';
                                        ']'; '^'; '`'; '{';
                                        '}'; '~']
  in let specials = List.mem i specials
  in lowerchar || upperchar || digit || specials

let is_printable c = is_printable_i (int_of_char c)

let string_noprintable print_char print_first_char f s =
  let li = Array.to_list @$ String.chararray s in
  let fst, printable = List.fold_left
      (fun (fst, printable) c ->
         if fst then
           if is_printable c then begin
             Format.fprintf f "\"%c" c;
             (false, true)
           end
           else if print_first_char then
             begin Format.fprintf f "\"\" & %a" print_char c;
               (false, false) end
           else
             begin Format.fprintf f "%a" print_char c;
               (false, false) end
         else if is_printable c then
           if printable then begin
             Format.fprintf f "%c" c;
             (false, true)
           end
           else begin
             Format.fprintf f " & \"%c" c;
             (false, true)
           end
         else
         if printable then begin
           Format.fprintf f "\" & %a" print_char c;
           (false, false)
         end
         else begin
           Format.fprintf f " & %a" print_char c;
           (false, false)
         end
      ) (true, false) li
  in if printable then
    Format.fprintf f "\""
  else if fst then
    Format.fprintf f "\"\""

let unicode f c =
  let cs = Printf.sprintf "%C" c in
  if String.length cs == 6 then
    Format.fprintf f "'\\u00%02x'" (int_of_char c)
  else
    Format.fprintf f "%s" cs

let string_nodolar f s =
  let s = Printf.sprintf "%S" s in
  Format.fprintf f "%s" (String.replace "$" "\\$" s)

let clike_char f c =
  let cs = Printf.sprintf "%C" c in
  if String.length cs == 6 then
    Format.fprintf f "'\\x%02x'" (int_of_char c)
  else
    Format.fprintf f "%s" cs

let dolar_varname f = function
  | Ast.UserName v -> Format.fprintf f "$%s" v
  | Ast.InternalName _ -> assert false

let format_to_string li =
  let open AstFun.Expr in
  let li = List.map (function
      | IntFormat -> "%d"
      | StringFormat -> "%s"
      | CharFormat -> "%c"
      | StringConstant s -> String.replace "%" "%%" s ) li
  in String.concat "" li

let split_multi_read li space_format format_type =
  let open Ast in
  let format, variables, declared = List.fold_left (fun (format, variables, declared) i -> match i with
      | Instr.Separation -> (format ^ space_format, variables, declared)
      | Instr.DeclRead (t, var, _) ->
        let mutable_ = Mutable.var var in
        let addons = format_type t in
        (format ^ addons, mutable_::variables, (t, var)::declared)
      | Instr.ReadExpr (t, mutable_) ->
        let addons = format_type t in
        (format ^ addons, mutable_::variables, declared)
    ) ("", [], []) li
  in format, List.rev variables, declared
     
let clike_comment f c = Format.fprintf f (if String.contains c '\n' then "/*%s*/" else "// %s") c
    
let clike_print_instr c i =
  let open Ast.Instr in
  let open Format in
  let p f pend = match i with
    | Incr mut -> fprintf f "%a++%a" (c.print_mut c nop) mut pend ()
    | Decr mut -> fprintf f "%a--%a" (c.print_mut c nop) mut pend ()
    | SelfAffect (mut, op, e) -> fprintf f "%a %a= %a%a" (c.print_mut c nop) mut c.print_op op e nop pend ()
    | Affect (mut, e) -> fprintf f "%a = %a%a" (c.print_mut c nop) mut e nop pend ()
    | If (e, listif, []) ->
      fprintf f "if (%a)%a" e nop block listif
    | If (e, listif, [elsecase]) when elsecase.is_if ->
      fprintf f "if (%a)%a@\nelse %a" e nop block_ifcase listif elsecase.p seppt
    | If (e, listif, listelse) ->
      fprintf f "if (%a)%a@\nelse%a" e nop block_ifcase listif block listelse
    | ClikeLoop (init, cond, incr, li) -> fprintf f "for (%a; %a; %a)%a"
                                            plifor init
                                            cond nop
                                            plifor incr
                                            block li
    | While (e, li) -> fprintf f "while (@[<h>%a@])%a" e nop block li
    | Comment s -> clike_comment f s
    | Tag s -> fprintf f "/*%S*/" s
    | Return e -> fprintf f "return %a%a" e nop pend ()
    | Declare _
    | Print _ | Read _ | Unquote _ | Untuple _ | AllocRecord _
    | Loop _ | AllocArray _ | AllocArrayConst _ -> assert false
    | Call (func, li) ->  begin match StringMap.find_opt func c.macros with
        | Some ( (t, params, code) ) -> pmacros f "%s%a" t params code li nop pend ()
        | None -> fprintf f "%s(%a)%a" func (print_list (fun f x -> x f nop) sep_c) li pend ()
      end
  in p

let clike_collect_for instrs onlyread =
  let open Ast.Instr in
  let collect acc i =
      Writer.Deep.fold (fun (acci, accc) i -> match unfix i with
          | Read li -> List.fold_left (fun (acci, accc) -> function
              | DeclRead (ty, i, _) ->
                begin match Ast.Type.unfix ty with
                  | Ast.Type.Integer ->  let acci = if List.mem i acci then acci else i::acci in acci, accc
                  | Ast.Type.Char ->  let accc = if List.mem i accc then accc else i::accc in acci, accc
                  | _ -> assert false
                end
              | _ -> acci, accc ) (acci, accc) li
          | ClikeLoop(init, _, _, _) when not onlyread ->
            let acci = List.fold_left (fun acci i -> match unfix i with
                | Declare (var,_, _, _) -> if List.mem var acci then acci else var::acci (* TODO : checker le type *)
                | _ -> acci
              ) acci init in acci, accc
          | Loop (i, _, _, _) when not onlyread -> let acci = if List.mem i acci then acci else i::acci in acci, accc
          | _ -> acci, accc
        ) acc i
    in
    List.fold_left collect ([], []) instrs

let cclike_decltype ptype f name t =
  match Ast.Type.unfix t with
      Ast.Type.Struct li ->
      Format.fprintf f "struct %s {@\n@[<v 4>    %a@]@\n};@\n" name
        (print_list
           (fun t (name, type_) ->
              Format.fprintf t "%a %s;"  ptype type_ name
           )
           sep_nl
        ) li
    | Ast.Type.Enum li ->
      Format.fprintf f "typedef enum %s {@\n@[<v 4>    %a@]@\n} %s;" name
        (print_list
           (fun t name -> Format.fprintf f "%s" name)
           (sep "%a,@\n%a")
        ) li name
    | _ -> Format.fprintf f "typedef %a %s;" ptype t name

type pascal_ty_decl =
  | DeclArray of string * Ast.Type.t * string * string Ast.TypeMap.t
  | DeclPtr of string * Ast.Type.t * string Ast.TypeMap.t
                   

  let pas_declare_type0 getname2 declared_types_assoc declared_types newtypes t =
    let open Ast in
    let makealias ty declared_types_assoc declared_types newtypes =
      match TypeMap.find_opt ty declared_types with
        | Some _ -> None, declared_types_assoc, declared_types, newtypes
        | None -> match Type.unfix ty with
          | Type.Integer | Type.Char | Type.Bool | Type.String | Type.Void -> None, declared_types_assoc, declared_types, newtypes
          | Type.Named n -> Some n, declared_types_assoc, declared_types, newtypes
          | _ ->
            let name : string = Fresh.fresh_user () in
            let name2 = getname2 name in
            let newtypes = DeclArray (name, t, name2, declared_types) :: newtypes in
            Some name, StringMap.add name2 (Some name) declared_types_assoc, TypeMap.add t name2 declared_types, newtypes
    in
  match Type.unfix t with
  | Type.Option t2 ->
    begin match Type.unfix t2 with
      | Type.Named _ -> declared_types_assoc, declared_types, newtypes
      | _ ->
        match TypeMap.find_opt t declared_types with
        | Some _ -> declared_types_assoc, declared_types, newtypes
        | None ->
          let name, declared_types_assoc, declared_types, newtypes = makealias t2 declared_types_assoc declared_types newtypes in
          let name2 = Fresh.fresh_user () in
          let newtypes = DeclPtr (name2, t, declared_types) :: newtypes in
          StringMap.add name2 name declared_types_assoc, TypeMap.add t name2 declared_types, newtypes
      end

    
  | Type.Array _ ->
      begin
        match TypeMap.find_opt t declared_types with
        | Some _ -> declared_types_assoc, declared_types, newtypes
        | None ->
          let name : string = Fresh.fresh_user () in
          let name2 = getname2 name in
          let newtypes = DeclArray (name, t, name2, declared_types) :: newtypes in
          StringMap.add name2 (Some name) declared_types_assoc, TypeMap.add t name2 declared_types, newtypes
      end
    | _ -> declared_types_assoc, declared_types, newtypes
      
let pas_declare_type getname2 declared_types_assoc declared_types newtypes t =
  Ast.Type.Fixed.Deep.fold_acc (fun (declared_types_assoc, declared_types, newtypes) t ->
      pas_declare_type0 getname2 declared_types_assoc declared_types newtypes t)
    (declared_types_assoc, declared_types, newtypes) t
      
let pas_declare_types getname2 instrs declared_types_assoc declared_types =
  let open Ast.Instr in
  List.fold_left
        (Writer.Deep.fold
           (fun (declared_types_assoc, declared_types, newtypes)  i ->
              match Fixed.unfix i with
              | Declare (_, t, _, _) -> pas_declare_type getname2 declared_types_assoc declared_types newtypes t
              | Read li ->
                List.fold_left (fun (declared_types_assoc, declared_types, newtypes) -> function
                    | DeclRead (t, _, _) -> pas_declare_type getname2 declared_types_assoc declared_types newtypes t
                    | _ -> declared_types_assoc, declared_types, newtypes)
                             (declared_types_assoc, declared_types, newtypes) li
              | AllocArray (_, t, _, _, _) -> pas_declare_type getname2 declared_types_assoc declared_types newtypes (Ast.Type.array t)
              | AllocRecord (_, t, _, _) -> pas_declare_type getname2 declared_types_assoc declared_types newtypes t
              | _ -> declared_types_assoc, declared_types, newtypes
                  ))
        (declared_types_assoc, declared_types, [])
        instrs
  

let jlike_prio_operator = -100

let rec jlike_prefix_type ptype f t =
  let open Ast.Type in
  match unfix t with
  | Array t2 -> jlike_prefix_type ptype f t2
  | t2 -> ptype f t

let rec jlike_suffix_type f t =
  let open Ast.Type in let open Format in
  match unfix t with
  | Array t2 ->
    fprintf f "[]%a" jlike_suffix_type t2
  | _ -> fprintf f ""

let calc_used_variables used_affect instrs =
  let rec fold_expr acc e =
    match Ast.Expr.unfix e with
    | Ast.Expr.Access m -> Ast.Mutable.Writer.Deep.fold fold_mut acc m
    | _ -> acc
  and fold_mut acc m = match Ast.Mutable.unfix m with
    | Ast.Mutable.Var varname -> Ast.BindingSet.add varname acc
    | Ast.Mutable.Array (m, lie) ->
      let acc = List.fold_left dfold_expr acc lie in
      if used_affect then fold_mut acc m else acc
    | Ast.Mutable.Dot (m, _) ->
      if used_affect then fold_mut acc m else acc
  and dfold_expr acc e =
    Ast.Expr.Writer.Deep.fold fold_expr
      (fold_expr acc e) e
  in
  let fold_instr acc i =
    let acc = Ast.Instr.Fixed.Deep.foldg (fun e acc -> dfold_expr acc e) i acc in
    Ast.Instr.Writer.Deep.fold (fun acc i -> match Ast.Instr.unfix i with
        | Ast.Instr.Affect (m, e) ->
          begin match Ast.Mutable.unfix m with
            | Ast.Mutable.Var var ->
              if used_affect then Ast.BindingSet.add var acc
              else acc
            | _ -> Ast.Mutable.Writer.Deep.fold fold_mut acc m
          end
        | _ -> acc) acc i
  in
  List.fold_left fold_instr Ast.BindingSet.empty
    instrs
