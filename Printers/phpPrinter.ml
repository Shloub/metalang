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
open Ast
open Printer
open CPrinter

class phpPrinter = object(self)
  inherit cPrinter as super


  method tuple f li =
    Format.fprintf f "array(%a)"
      (print_list self#expr
         (fun t fa a fb b -> Format.fprintf t "%a, %a" fa a fb b)
      ) li

  method record f li =
    Format.fprintf f "array(@\n  @[<v>%a@])"
      (self#def_fields "") li


  method untuple f li e =
    Format.fprintf f "@[<h>list(%a) = %a;@]"
      (print_list self#binding
         (fun t fa a fb b -> Format.fprintf t "%a, %a" fa a fb b)
      ) (List.map snd li)
      self#expr e


  method lang () = "php"

  method char f c =
    Format.fprintf f "%S" (String.make 1 c)

  method prototype f t =
    match Type.unfix t with
    | Type.Array _
    | Type.Named _
      ->
      Format.fprintf f "&"
    | _ -> ()

  method stdin_sep f = Format.fprintf f "@[scantrim();@]"

  method bool f = function
  | true -> Format.fprintf f "true"
  | false -> Format.fprintf f "false"

  method read f t m =
    match Type.unfix t with
    | Type.Char ->
      Format.fprintf f "@[%a = nextChar();@]"
        self#mutable_ m
    | _ ->
      Format.fprintf f "@[list(%a) = scan(\"%a\");@]"
        self#mutable_ m
        self#format_type t


  method mutable_ f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) ->
      Format.fprintf f "%a[\"%a\"]"
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

  method main f main = self#instructions f main

  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "<?php@\n%s%s%s%a%a@\n?>"
      (if need then "
$stdin='';
function stdin_(){   global $stdin; if ( !feof(STDIN)) $stdin.=fgets(STDIN).\"\\n\";}
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

  method eprint t f e =
    match Type.unfix t with
    | Type.Integer
    | Type.String
    | Type.Bool -> Format.fprintf f "%a" self#expr e
    | Type.Char -> Format.fprintf f "%a" self#expr e
    | _ -> assert false

  method combine_formats () = false

  method multi_print f format exprs =
    Format.fprintf f "@[<h>echo %a;@]"
      (print_list
         (fun f (t, e) -> (self#eprint t) f e)
         (fun t f1 e1 f2 e2 -> Format.fprintf t
           "%a,@ %a" f1 e1 f2 e2)) exprs

  method print f t expr = Format.fprintf f "@[echo@ %a;@]" (self#eprint t) expr

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
             self#binding a)
         (fun t f1 e1 f2 e2 -> Format.fprintf t
           "%a,@ %a" f1 e1 f2 e2)) li


  method binding f i = Format.fprintf f "$%s" i

  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ =@ %a;@]" self#binding var self#expr e

  method allocarray f binding type_ len =
    Format.fprintf f "@[<h>%a@ =@ array();@]" self#binding binding

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
      (fun t f1 e1 f2 e2 ->
        Format.fprintf t
          "%a,@\n%a" f1 e1 f2 e2)
      f
      li

  method allocrecord f name t el =
    Format.fprintf f "%a = array(@\n@[<v 2>  %a@]@\n);@\n"
      self#binding name
      (self#def_fields name) el

  method hasSelfAffect = function
  | Expr.Div -> false
  | _ -> true

  method binop f op a b =
    match op with
    | Expr.Div ->
      if Typer.is_int (super#getTyperEnv ()) a
      then Format.fprintf f "intval(%a)"
        (fun f () -> super#binop f op a b) ()
      else super#binop f op a b
    | _ -> super#binop f op a b

  method multiread f instrs = self#basemultiread f instrs
end
