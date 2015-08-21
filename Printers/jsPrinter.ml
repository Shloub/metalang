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

(** Javascript Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast

let print_expr macros e f p =
  let open Format in
  let open Ast.Expr in 
  let print_mut conf priority f m = Mutable.Fixed.Deep.fold
      (print_mut0 "%a%a" "[%a]" "%a.%s" conf) m f priority in
  let print_lief prio f = function
    | Char c ->
        let cs = sprintf "%C" c in
        if String.length cs == 6 then fprintf f "'\\x%02x'" (int_of_char c)
        else fprintf f "%s" cs
    | Enum e -> fprintf f "%S" e
    | x -> print_lief prio f x in
  let print_expr0 config e f prio_parent = match e with
  | BinOp (a, ((Div | Mod) as op), b) ->
      let prio, priol, prior = prio_binop op in
      fprintf f "~~(%a %a %a)" a priol print_op op b prior
  | _ -> print_expr0 config e f prio_parent
  in
  let config = {
    prio_binop;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
  } in Fixed.Deep.fold (print_expr0 config) e f p


class jsPrinter = object(self)
  inherit CPrinter.cPrinter as super

  method lang () = "js"

  method declare_for s f li = ()

  method decl_type f name t = ()

  method hasSelfAffect = function
  | Expr.Div -> false
  | _ -> true

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ (var %a@ =@ %a@ ;@ %a@ <=@ %a;@ %a++)@\n@]%a"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#expr expr2
      self#binding varname
      self#bloc li

  method declaration f var t e =
    Format.fprintf f "@[<h>var %a@ =@ %a;@]"
      self#binding var
      self#expr e

  method print_proto f (funname, t, li) =
    Format.fprintf f "function %a(%a)"
      self#funname funname
      (print_list self#binding sep_c) (List.map fst li)

  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "var util = require(\"util\");@\n%s%s%s%s%a%a@\n"
(if need then "var fs = require(\"fs\");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
}" else "")
(if need_readchar then "
function read_char_(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}" else "")
(if need_stdinsep then "
function stdinsep(){
    if (current_char == null) current_char = read_char0();
    while (current_char.match(/[\\n\\t\\s]/g))
        current_char = read_char0();
}" else "")
(if need_readint then "
function read_int_(){
  if (current_char == null) current_char = read_char0();
  var sign = 1;
  if (current_char == '-'){
     current_char = read_char0();
     sign = -1;
  }
  var out = 0;
  while (true){
    if (current_char.match(/[0-9]/g)){
      out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
      current_char = read_char0();
    }else{
      return out * sign;
    }
  }
}" else "")
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method main f main =
    self#instructions f main

  method combine_formats () = false

  method multi_print f li =
    let format, exprs = self#extract_multi_print li in
    Format.fprintf f "@[<h>util.print(%a);@]"
      (print_list self#expr sep_c) (List.map snd exprs)

  method print f t expr =
    Format.fprintf f "@[util.print(%a);@]" self#expr expr

  method allocrecord f name t el =
    Format.fprintf f "@[<h>@[<v2>var %a = {@\n%a@]@\n};@]"
      self#binding name
      (self#def_fields name) el

  method allocarray f binding type_ len _ =
    Format.fprintf f "@[<h>var %a@ =@ new Array(%a);@]"
      self#binding binding
      self#expr len

  method m_field f m field = Format.fprintf f "%a.%a"
      self#mutable_get m
      self#field field

  method def_fields name f li =
    Format.fprintf f "@[<h>%a@]"
      (print_list
         (fun f (fieldname, expr) ->
           Format.fprintf f "%a : %a"
             self#field fieldname
             self#expr expr
         ) sep_cnl
      )
      li

  method read f t mutable_ =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[%a=read_int_();@]"
        self#mutable_set mutable_
    | Type.Char ->
      Format.fprintf f "@[%a=read_char_();@]"
        self#mutable_set mutable_
    | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot print type %s"
      (Type.type_t_to_string t)
    ))

  method read_decl f t v =
    match Type.unfix t with
    | Type.Integer ->
      Format.fprintf f "@[%a=read_int_();@]"
        self#binding v
    | Type.Char ->
      Format.fprintf f "@[%a=read_char_();@]"
        self#binding v
    | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot print type %s"
      (Type.type_t_to_string t)
    ))

  method stdin_sep f =
    Format.fprintf f "@[stdinsep();@]"

  method expr f e = print_expr
      (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) e f nop

end
