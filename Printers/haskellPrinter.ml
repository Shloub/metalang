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

(** Haskell Printer
    note : http://xkcd.com/1312/
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Printer


class haskellPrinter = object(self)
  inherit printer as super

  val mutable in_expr = false
  method expr f e =
    begin
      in_expr <- true;
      super#expr f e;
      in_expr <- false;
    end

  method main f main =
    Format.fprintf f "@[<v 2>@[<h>main =@\n@[<v 2>  %a@]@\n"
      self#instructions main

  method print_fun_type f (funname, t, li) =
    let ptli t = function
      | [] ->
        Format.fprintf f "%a :: IO %a"
          self#binding funname
          self#ptype t
      | li ->
      Format.fprintf f "%a :: %a -> IO %a"
        self#binding funname
        (print_list
           self#ptype
           (fun t print1 item1 print2 item2 ->
             Format.fprintf t "%a@ -> %a" print1 item1 print2 item2
           )) (List.rev (List.rev_map snd li))
        self#ptype t
    in  match Type.unfix t with
    | Type.Void ->
      begin match List.rev li with
      | (_, hd)::tl -> ptli hd (List.rev tl)
      | [] -> Format.fprintf f "%a :: IO ()" self#binding funname
      end
    | _ -> ptli t li
    

  method print_fun_args f (funname, t, li) =
    Format.fprintf f "%a %a ="
      self#binding funname
      (print_list
         self#binding
         (fun t print1 item1 print2 item2 ->
           Format.fprintf t "%a@ %a" print1 item1 print2 item2
         )) (List.map fst li)

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<h>%a@]@\n@[<v 2>  %a@]@\n"
      self#print_fun_type (funname, t, li)
      self#print_fun_args (funname, t, li)
      self#instructions instrs

  method instructions f instrs =
    Format.fprintf f "do@[<v>@\n%a@]@\n"
      (print_list
         self#instr
         (fun t print1 item1 print2 item2 ->
           Format.fprintf t "%a@\n%a" print1 item1 print2 item2
         )) instrs
      
  method print f t expr =
    Format.fprintf f "@[printf \"%a\" (%a :: %a)@]"
      self#format_type t
      self#expr expr
      self#ptype t

  method comment f str =
    Format.fprintf f "{-|%s-}" str

  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ <-@ return@ $ %a@]"
      self#binding var
      self#expr e

  method hasSelfAffect op = false

  method affect f mutable_ (expr : 'lex Expr.t) =
    Format.fprintf f "@[<h>%a@ <-@ return $@ %a@]" self#mutable_ mutable_ self#expr expr

  method binop f op a b = match op with
  | Expr.Mod -> Format.fprintf f "(rem (%a) (%a))" self#expr a self#expr b
  | Expr.Div -> Format.fprintf f "(quot (%a) (%a))" self#expr a self#expr b
  | Expr.Sub -> Format.fprintf f "((%a) + (-(%a)))" self#expr a self#expr b
  | _ -> super#binop f op a b

  method unop f op a =
    Format.fprintf f "(%a)" (fun f () -> super#unop f op a) ()

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "/"
      | Expr.Mod -> "`rem`"
      | Expr.Or -> "||"
      | Expr.And -> "&&"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | Expr.Eq -> "=="
      | Expr.Diff -> "!="
      )

  method prog f (prog: Utils.prog) =
    Format.fprintf f "import Text.Printf@\n@\n%a%a@\n"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method ptype f t =
    match Type.unfix t with
    | Type.Integer -> Format.fprintf f "Int"
    | Type.String -> Format.fprintf f "String"
    | Type.Array a -> Format.fprintf f "[%a]" self#ptype a
    | Type.Bool -> Format.fprintf f "Bool"
    | Type.Char -> Format.fprintf f "Char"
(* TODO *)
end
