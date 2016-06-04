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


(** php Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast

let print_lief prio f l =
  let open Format in
  let open Expr in
  match l with
  | Char c ->
      let cs = Printf.sprintf "%C" c in
      if String.length cs == 6 || c == '\b' then
        fprintf f "\"\\x%02x\"" (int_of_char c)
      else fprintf f "%S" (String.from_char c)
  | String s ->
      let s = Printf.sprintf "%S" s in
      fprintf f "%s" (String.replace "$" "\\$" s)
  | Integer i ->
      if i < 0 then parens prio (-1) f "%i" i
      else fprintf f "%i" i
  | Bool true -> fprintf f "true"
  | Bool false -> fprintf f "false"
  | Enum s -> fprintf f "%S" s

let config macros = {
    prio_binop = prio_binop_equal;
    prio_unop;
    print_varname = dolar_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
  }

let print_expr config e f p =
  let open Format in
  let open Expr in
  let print_expr0 config e f prio_parent = match e with
  | BinOp (a, (Div as op), b) ->
      let prio, priol, prior = prio_binop op in
      fprintf f "intval(%a %a %a)" a priol print_op op b prior
  | Tuple li -> fprintf f "array(%a)" (print_list (fun f x -> x f nop) sep_c) li
  | Record li -> fprintf f "array(%a)" (print_list (fun f (name, x) ->
      fprintf f "%S => %a" name x nop) sep_c) li
  | _ -> print_expr0 config e f prio_parent
  in Fixed.Deep.fold (print_expr0 config) e f p

let print_instr c i =
  let open Ast.Instr in
  let open Format in
  let seppt f () = fprintf f ";" in
  let noseppt f () = () in
  let plifor f li = print_list (fun f i -> i.p f noseppt) (sep "%a,%a") f li in
  let block f li =
    let format = match List.filter (fun l -> not l.is_comment) li with
    | [i] -> fprintf f "@\n    @[<v>%a@]"
    | _ -> fprintf f "@\n@[<v 4>{@\n%a@]@\n}" in
    format (print_list (fun f i -> i.p f seppt) sep_nl) li in
  
  let block_ifcase f li =
    let format = match li with
    | [i] when not i.is_if_noelse -> fprintf f "@\n    @[<v>%a@]"
    | _ -> fprintf f "@\n@[<v 4>{@\n%a@]@\n}" in
    format (print_list (fun f i -> i.p f seppt) sep_nl) li in
  let p f pend = match i with
  | Declare (var, ty, e, _) -> fprintf f "%a = %a%a" c.print_varname var e nop pend ()
    | SelfAffect (mut, op, e) -> fprintf f "%a %a= %a%a" (c.print_mut c nop) mut c.print_op op e nop pend ()
    | Affect (mut, e) -> fprintf f "%a = %a%a" (c.print_mut c nop) mut e nop pend ()
    | Loop (var, e1, e2, li) -> fprintf f "for (%a = %a; %a <= %a; %a++)%a"
          c.print_varname var e1 nop
          c.print_varname var e2 nop
          c.print_varname var
          block li
    | ClikeLoop (init, cond, incr, li) -> fprintf f "for (%a;%a;%a)%a"
          plifor init
          cond nop
          plifor incr
          block li
    | While (e, li) -> fprintf f "while (@[<h>%a@])%a" e nop block li
    | Comment s -> fprintf f "/*%s*/" s
    | Tag s -> fprintf f "/*%S*/" s
    | Return e -> fprintf f "return %a%a" e nop pend ()
    | AllocArray (name, t, e, None, opt) -> fprintf f "%a = array()%a" c.print_varname name pend ()
    | AllocArray (name, t, e, Some (var, lambda), opt) -> assert false
    | AllocArrayConst (name, ty, len, lief, opt) ->
        fprintf f "@[<h>%a = array_fill(0, %a, %a)%a@]" c.print_varname name
          len nop (c.print_lief nop) lief pend ()
    | AllocRecord (name, ty, list, opt) ->
        fprintf f "@[<v 4>%a = array(@\n%a)%a@]" c.print_varname name
          (print_list (fun f (field, x) -> fprintf f "%S => %a" field x nop) (sep "%a,@\n%a")) list
          pend ()
    | If (e, listif, []) ->
        fprintf f "if (%a)%a" e nop block listif
    | If (e, listif, [elsecase]) when elsecase.is_if ->
        fprintf f "if (%a)%a@\n@[<v 4>else@\n%a@]" e nop block_ifcase listif elsecase.p seppt
    | If (e, listif, listelse) ->
        fprintf f "if (%a)%a@\nelse%a" e nop block_ifcase listif block listelse
    | Call (func, li) ->  begin match StringMap.find_opt func c.macros with
      | Some ( (t, params, code) ) -> pmacros f "%s;" t params code li nop
      | None -> fprintf f "%s(%a)%a" func (print_list (fun f x -> x f nop) sep_c) li pend ()
    end
    | Print li->
        fprintf f "echo %a%a"
          (print_list
             (fun f -> function
               | StringConst s -> c.print_lief nop f (Ast.Expr.String s)
               | PrintExpr (_, e) -> e f nop) sep_c) li
          pend ()
    | Read li ->
        print_list
          (fun f -> function
            | Separation -> Format.fprintf f "@[scantrim()%a@]" pend ()
            | DeclRead (ty, v, opt) ->
                begin match Ast.Type.unfix ty with
                | Ast.Type.Char -> fprintf f "@[%a = nextChar()%a@]" c.print_varname v pend ()
                | _ -> fprintf f "@[list(%a) = scan(\"%a\")%a@]" c.print_varname v format_type ty pend ()
                end
            | ReadExpr (ty, mut) ->
                begin match Ast.Type.unfix ty with
                | Ast.Type.Char -> fprintf f "@[%a = nextChar()%a@]" (c.print_mut c nop) mut pend ()
                | _ -> fprintf f "@[list(%a) = scan(\"%a\")%a@]" (c.print_mut c nop) mut format_type ty pend ()
                end
          ) sep_nl f li
    | Untuple (li, expr, opt) -> fprintf f "list(%a) = %a%a" (print_list c.print_varname sep_c) (List.map snd li) expr nop pend ()
    | Unquote e -> assert false in
  {
   is_if=is_if i;
   is_if_noelse=is_if_noelse i;
   is_comment=is_comment i;
   p=p;
   default = seppt;
   print_lief = c.print_lief;
 }

let print_instr macros i =
  let open Ast.Instr.Fixed.Deep in
  let c = config macros in
  let i = (fold (print_instr c) (mapg (print_expr c) i))
  in fun f -> i.p f i.default
    
class phpPrinter = object(self)
  inherit CPrinter.cPrinter as super

  method multi_read f li = self#base_multi_read f li

 method instr f t =
   let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros
   in (print_instr macros t) f
     
  method declare_for s f li = ()

  method untuple f li e =
    Format.fprintf f "@[<h>list(%a) = %a;@]"
      (print_list self#binding sep_c) (List.map snd li)
      self#expr e

  method lang () = "php"

  method prototype f t =
    match Type.unfix t with
    | Type.Array _
    | Type.Named _
      ->
      Format.fprintf f "&"
    | _ -> ()

  method stdin_sep f = Format.fprintf f "@[scantrim();@]"
     
  method read f t m =
    match Type.unfix t with
    | Type.Char ->
      Format.fprintf f "@[%a = nextChar();@]"
        self#mutable_set m
    | _ ->
      Format.fprintf f "@[list(%a) = scan(\"%a\");@]"
        self#mutable_set m
        self#format_type t

  method read_decl f t v =
    match Type.unfix t with
    | Type.Char ->
      Format.fprintf f "@[%a = nextChar();@]"
        self#binding v
    | _ ->
      Format.fprintf f "@[list(%a) = scan(\"%a\");@]"
        self#binding v
        self#format_type t

  method m_field f m field = Format.fprintf f "%a[%S]" self#mutable_get m field

  method main f main = self#instructions f main

  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "<?php@\n%s%s%s%a%a@\n"
      (if need then "
$stdin='';
function stdin_(){
  global $stdin;
  if ( !feof(STDIN)) $stdin.=fgets(STDIN).\"\\n\";
}
function scan($format){
  stdin_();
  global $stdin;
  $out = sscanf($stdin, $format);
  $stdin = substr($stdin, strlen($out[0]));
  return $out;
}" else "")
      (if need_stdinsep then "
function scantrim(){
  global $stdin;
  while(true){
    $stdin = ltrim($stdin);
    if ($stdin != '' || feof(STDIN)) break;
    stdin_();
  }
}" else "")
      (if need_readchar then "
function nextChar(){
 stdin_();
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return $out;
}" else "")
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method multi_print f li =
    Format.fprintf f "@[<h>echo %a;@]"
      (print_list
         (fun f -> function
           | Instr.StringConst str -> self#expr f (Expr.string str)
           | Instr.PrintExpr (_t, e) -> self#expr f e) sep_c) li

  method print f _t expr = Format.fprintf f "@[echo@ %a;@]" self#expr expr

  method print_proto f (funname, t, li) =
    Format.fprintf f "function %a%a(%a)"
      (fun f t -> match Type.unfix t with
      | Type.Array _
      | Type.Named _ ->
        Format.fprintf f "&"
      | _ -> ()
      ) t
      self#funname funname
      (print_list
         (fun t (a, type_) ->
           Format.fprintf t
             "%a%a"
             self#prototype type_
             self#binding a) sep_c ) li

  method binding f i = Format.fprintf f "$%a" super#binding i

  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ =@ %a;@]" self#binding var self#expr e

  method allocarray f binding type_ len _ =
    Format.fprintf f "@[<h>%a@ =@ array();@]" self#binding binding

  method allocarrayconst f binding type_ len e opt =
    Format.fprintf f "@[<h>%a = array_fill(0, %a, %a);@]"
      self#binding binding
      self#expr len
      (print_lief nop) e

  method forloop f varname expr1 expr2 li =
    self#forloop_content f (varname, expr1, expr2, li)

  method decl_type f name t = ()

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
        Format.fprintf f "@[<h>\"%a\"=>%a@]"
          self#field fieldname
          self#expr expr
      )
      (sep "%a,@\n%a")
      f
      li

  method allocrecord f name t el =
    Format.fprintf f "%a = array(@\n@[<v 2>  %a@]@\n);@\n"
      self#binding name
      (self#def_fields name) el

end
