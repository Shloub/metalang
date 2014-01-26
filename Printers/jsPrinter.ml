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
open Ast
open Printer
open CPrinter

class jsPrinter = object(self)
  inherit cPrinter as super

  method lang () = "js"

  method decl_type f name t = ()

  method hasSelfAffect = function
    | Expr.Div -> false
    | _ -> true

  method binop f op a b =
    match op with
      | Expr.Div ->
        if Typer.is_int (super#getTyperEnv ()) a
        then Format.fprintf f "Math.floor(%a)"
          (fun f () -> super#binop f op a b) ()
        else super#binop f op a b
      | _ -> super#binop f op a b

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
      (print_list
         (fun t (binding, type_) ->
           Format.fprintf t "%a"
             self#binding binding
         )
         (fun t f1 e1 f2 e2 -> Format.fprintf t
           "%a,@ %a" f1 e1 f2 e2)
      ) li

  method prog f prog =
    Format.fprintf f "
var util = require(\"util\");
var fs = require(\"fs\");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
var read_char = function(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}
var stdinsep = function(){
    if (current_char == null) current_char = read_char0();
    while (current_char == '\\n' || current_char == ' ' || current_char == '\\t')
        current_char = read_char0();
}
var read_int = function(){
    if (current_char == null) current_char = read_char0();
    var sign = 1;
    if (current_char == '-'){
        current_char = read_char0();
        sign = -1;
    }
    var out = 0;
    while (true){
        if (current_char.charCodeAt(0) >= '0'.charCodeAt(0) && current_char.charCodeAt(0) <= '9'.charCodeAt(0)){
            out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
            current_char = read_char0();
        }else{
            return out * sign;
        }
    }
}

@\n%a%a@\n@\n"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main


  method main f main =
    self#instructions f main


  method combine_formats () = false

  method multi_print f format exprs =
    Format.fprintf f "@[<h>util.print(%a);@]"
      (print_list
	 (fun f (t, e) -> self#expr f e)
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a,@ %a" f1 e1 f2 e2)) exprs

  method print f t expr =
    Format.fprintf f "@[util.print(%a);@]" self#expr expr

  method allocrecord f name t el =
    Format.fprintf f "@[<h>var %a@ =@ {@[<v2>@\n%a@]@\n};@]"
      self#binding name
      (self#def_fields name) el

  method allocarray f binding type_ len =
      Format.fprintf f "@[<h>var %a@ =@ new Array(%a);@]"
        self#binding binding
        self#expr len

  method mutable_ f m =
    match Mutable.unfix m with
      | Mutable.Dot (m, field) ->
	Format.fprintf f "%a.%a"
	  self#mutable_ m
	  self#field field
      | Mutable.Var binding -> self#binding f binding
      | Mutable.Array (m, indexes) ->
	Format.fprintf f "%a[%a]"
	  self#mutable_ m
	  (print_list
	     self#expr
	     (fun f f1 e1 f2 e2 ->
	       Format.fprintf f "%a][%a" f1 e1 f2 e2
	     ))
	  indexes


  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
	Format.fprintf f "%a : %a"
	  self#field fieldname
	  self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
	Format.fprintf t
	  "%a,@\n%a" f1 e1 f2 e2)
      f
      li


  method read f t mutable_ =
match Type.unfix t with
  | Type.Integer ->
    Format.fprintf f "@[%a=read_int();@]"
      self#mutable_ mutable_
  | Type.Char ->
    Format.fprintf f "@[%a=read_char();@]"
      self#mutable_ mutable_
  | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot print type %s"
    (Type.type_t_to_string t)
  ))

  method stdin_sep f =
    Format.fprintf f "@[stdinsep();@]"

  method enum f e =
    Format.fprintf f "%S" e

end
