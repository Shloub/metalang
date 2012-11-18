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


(** LaTeX Printer
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)



open Stdlib
open Ast
open Printer

class texPrinter = object(self)
  inherit printer as super
  method lang () = "tex"

  val mutable lvl_expr = 0
  val mutable returnTab = None

  method string f s =
    self#texString f ("\""^s^"\"");

  method texString f s =
    let s =
      List.fold_left
	(fun s (from, to_) ->
	  String.replace from to_ s
	) s
	[
	  "\\", "\\backslash";
	  "é", "\\'e";
	  "_", "\\_";
	  "#", "\\#";
	]
    in
    Format.fprintf f "%s" s

  method call f var li =
    begin
      lvl_expr <- 1;
    match BindingMap.find_opt var macros with
      | Some ( (t, params, code) ) ->
	self#expand_macro_call f var t params code li
      | None ->
    Format.fprintf
      f
      "@[<h>$%a(%a)$\\;@]"
	  self#funname var
	  (print_list
	     self#expr
	     (fun t f1 e1 f2 e2 ->
	       Format.fprintf t "%a,@ %a" f1 e1 f2 e2
	     )
	  ) li;
      lvl_expr <- 0;
    end

  method char f c =
    let s = Printf.sprintf "%S" (String.make 1 c)
    in self#texString f s

  method prog f prog =
    Format.fprintf f
      "\\documentclass[8pt]{article}
\\usepackage[ruled,vlined]{algorithm2e}
\\title{%a}
\\begin{document}
\\maketitle
%a
%a
\\end{document}
"
      self#texString prog.Prog.progname
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main


  method allocarray_lambda f binding type_ len binding2 lambda =
    Format.fprintf f "%a@\n\\ForEach{ $%a\\;indice\\;of\\;%a$ }{%a}@]"
      (fun f () ->
	begin
	  lvl_expr <- 1;
	  Format.fprintf f "@[<h>$%a\\:%a=\\:new\\:%a[%a]$\\;@]"
	    self#ptype (Type.array type_)
	    self#binding binding
	    self#ptype type_
	    self#expr len
	  ;
	  lvl_expr <- 0;
	end
	) ()
      self#binding binding2
      self#binding binding
      (fun f () ->
	let a = returnTab in
	begin
	  returnTab <- Some (binding, binding2);
	  self#instructions f lambda;
	  returnTab <- a;
	end
	) ()

  method stdin_sep f =
    Format.fprintf f "@[read\\_blank(STDIN)\\;@]"


  method allocarray f binding type_ len =
    begin
      lvl_expr <- 1;
      Format.fprintf f "@[<h>$%a\\:%a@ :=@ new\\:%a[%a]$\\;@]"
	self#ptype (Type.array type_)
	self#binding binding
	self#ptype type_
	self#expr len;
      lvl_expr <- 0;
    end


  method print_proto f (funname, t, li) =
      print_list
	 (fun f (n, t) ->
	   Format.fprintf f "%a:%a"
	     self#binding n
	     self#ptype t)
	 (fun t f1 e1 f2 e2 -> Format.fprintf t
	  "%a,@ %a" f1 e1 f2 e2) f li

  val mutable in_fun_or_main = false

  method print_fun f funname t li instrs =
    begin
      in_fun_or_main <- true;
      Format.fprintf f
"\\begin{algorithm}[H]
\\SetKwInOut{Input}{input}
\\SetKwInOut{Output}{output}
\\Input{%a}
\\Output{%a}
%a
\\caption{%a}
\\end{algorithm}"
	self#print_proto (funname, t, li)
	self#ptype t
	self#instructions instrs
	self#texString funname;
      in_fun_or_main <- false;
    end

  method main f main =
    begin
      in_fun_or_main <- true;
      Format.fprintf f "\\begin{algorithm}[H]
%a
\\caption{Main}
\\end{algorithm}"
	self#instructions main;
      in_fun_or_main <- true;
    end

  method affect f mutable_ expr =
    begin
      lvl_expr <- 1;
      Format.fprintf f "@[<h>$%a \\leftarrow %a $\\;@]" self#mutable_ mutable_ self#expr expr;
      lvl_expr <- 0;
    end

  method return f e =
    match returnTab with
      | None ->
	Format.fprintf f "@[<h>\\Return@ %a\\;@]" self#expr e
      | Some (a, b) ->
	begin
	  lvl_expr <- 1;
	  Format.fprintf f "$%a[%a]:=%a$"
	    self#binding a
	    self#binding b
	    self#expr e;
	    lvl_expr <- 0;
	end
  method declaration f var t e =
    begin
      lvl_expr <- 1;
      Format.fprintf f "@[<h>$%a\\:%a := %a$\\;@]"
	self#ptype t
	self#binding var
	self#expr e
      ;
      lvl_expr <- 0;
    end

  method binding f i = self#texString f i

  method read f t mutable_ =
    Format.fprintf f "@[$read_{%a}$(%a)\\;@]" self#ptype t self#mutable_ mutable_

  method print f t expr =
    Format.fprintf f "@[$print_{%a}$(%a)\\;@]" self#ptype t self#expr expr

  method comment f str =
    if in_fun_or_main then
      Format.fprintf f "\\tcc*[f]{\\emph{%a}}\\;" self#texString str
    else
      self#texString f str

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
	| Expr.Add -> "+"
	| Expr.Sub -> "-"
	| Expr.Mul -> "*"
	| Expr.Div -> "\\div" (* TODO utiliser \\frac *)
	| Expr.Mod -> "mod"
	| Expr.Or -> "or"
	| Expr.And -> "and"
	| Expr.Lower -> "<"
	| Expr.LowerEq -> "\\leq"
	| Expr.Higher -> ">"
	| Expr.HigherEq -> "\\geq"
	| Expr.Eq -> "="
	| Expr.Diff -> "\\neq"
	| Expr.BinOr -> "lor"
	| Expr.BinAnd -> "land"
	| Expr.RShift -> "lsl"
	| Expr.LShift -> "lsr"
      )

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>\\For{%a}{@]@[<v 2>@\n%a@]}@\n"
      (fun t () ->
	begin
	  lvl_expr <- 1;
	  Format.fprintf f "@ $%a\\;:=\\;%a\\; to\\;%a$"
	    self#binding varname
	    self#expr expr1
	    self#expr expr2;
	  lvl_expr <- 0;
	end
      ) ()
      self#instructions li


  method whileloop f expr li =
    Format.fprintf f "@[<h>\\While{%a}{@]@\n@[<v 2>  %a@]@\n}"
      self#expr expr
      self#instructions li


  method if_ f e ifcase elsecase =
    match elsecase with
      | [] ->
	Format.fprintf f "@[<h>\\If{ %a }@]{@\n@[<v 2>  %a@]@\n}@\n"
	  self#expr e
	  self#instructions ifcase
      | _ ->
	Format.fprintf f "@[<h>\\If{ %a }@]{@\n@[<v 2>  %a@]@\n}@\n\\Else{@\n@[<v 2>  %a@]@\n}"
	  self#expr e
	  self#instructions ifcase
	  self#instructions elsecase

  method expr f e =
    begin
      lvl_expr <- lvl_expr + 1;
      if lvl_expr = 1 then
	Format.fprintf f "$ %a $" super#expr e
      else
	super#expr f e;
      lvl_expr <- lvl_expr - 1;
    end

end
