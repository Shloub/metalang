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


(** C++ Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Printer
open CPrinter

class cppPrinter = object(self)
  inherit cPrinter as cprinter

  method lang () = "cpp"

  method ptype f t =
    match Type.unfix t with
    | Type.Integer -> Format.fprintf f "int"
    | Type.String -> Format.fprintf f "std::string"
    | Type.Array a -> Format.fprintf f "std::vector<%a >" self#ptype a
    | Type.Void ->  Format.fprintf f "void"
    | Type.Bool -> Format.fprintf f "bool"
    | Type.Char -> Format.fprintf f "char"
    | Type.Named n -> begin match Typer.expand (cprinter#getTyperEnv ()) t
        default_location |> Type.unfix with
        | Type.Struct _ ->
          Format.fprintf f "%s *" n
        | Type.Enum _ ->
          Format.fprintf f "%s" n
        | _ -> assert false
    end
    | Type.Enum _ -> Format.fprintf f "an enum"
    | Type.Struct li -> Format.fprintf f "a struct"
    | Type.Auto -> Format.fprintf f "auto"
    | Type.Lexems -> assert false

  method bool f = function
  | true -> Format.fprintf f "true"
  | false -> Format.fprintf f "false"

  method prog f prog =
    Format.fprintf f
      "#include <iostream>@\n#include <vector>@\n%a%a@\n%a\n"
      (fun f () ->
        if Tags.is_taged "use_math"
        then Format.fprintf f "#include<cmath>@\n";
        if Tags.is_taged "use_cc_readline"
        then Format.fprintf f "std::vector<char> getline(){
  if (std::cin.flags() & std::ios_base::skipws){
    std::cin.ignore();
    std::cin.unsetf(std::ios::skipws);
  }
  std::string line;
  std::getline(std::cin, line);
  std::vector<char> c(line.begin(), line.end());
  return c;
}@\n"
      ) ()

      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method allocarray f binding type_ len =
    Format.fprintf f "@[<h>std::vector<%a > %a( %a );@]"
      self#ptype type_
      self#binding binding
      self#expr len

  method main f main =
    Format.fprintf f "@[<v 2>int main(){@\n%a@\nreturn 0;@]@\n}" self#instructions main

  method allocrecord f name t el =
    match Type.unfix t with
    | Type.Named typename ->
      Format.fprintf f "%a %a = new %s();@\n%a"
        self#ptype t
        self#binding name
        typename
        (self#def_fields name) el
    | _ -> assert false

  method mutable_ f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) ->
      Format.fprintf f "%a->%s"
        self#mutable_ m
        field
    | Mutable.Var b ->
      self#binding f b
    | Mutable.Array (m, index) ->
      Format.fprintf f "@[<h>%a.at(%a)@]"
        self#mutable_ m
        (print_list
           self#expr
           (fun f f1 e1 f2 e2 ->
             Format.fprintf f "%a).at(%a"
               f1 e1
               f2 e2
           )) index

  method forloop f varname expr1 expr2 li =
    let default () =
      Format.fprintf f "@[<h>for@ (int %a@ =@ %a@ ;@ %a@ <=@ %a;@ %a@ ++)@\n@]%a"
        self#binding varname
        self#expr expr1
        self#binding varname
        self#expr expr2
        self#binding varname
        self#bloc li
    in match Expr.unfix expr2 with
    | Expr.BinOp (expr3, Expr.Sub, Expr.Fixed.F (_, Expr.Lief (Expr.Integer 1)))
      ->
      Format.fprintf f "@[<h>for@ (int %a@ =@ %a@ ;@ %a@ <@ %a;@ %a++)@\n@]%a"
        self#binding varname
        self#expr expr1
        self#binding varname
        self#expr expr3
        self#binding varname
        self#bloc li
    | _ -> default ()


  method combine_formats () = false
  method multi_print f format exprs =
    Format.fprintf f "@[<h>std::cout << %a;@]"
      (print_list
         (fun f (t, e) -> self#expr f e)
         (fun t f1 e1 f2 e2 -> Format.fprintf t
           "%a@ <<@ %a" f1 e1 f2 e2)) exprs

  method print f t expr =
    Format.fprintf f "@[std::cout << %a;@]"
      self#expr expr

  method prototype f t =
    match Type.unfix t with
    | Type.Array _ ->
      Format.fprintf f "%a&" self#ptype t
    | _ -> self#ptype f t

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        Format.fprintf f "class %a {@\npublic:@\n@[<v 2>  %a@]@\n};@\n"
          self#binding name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "%a %a;" self#ptype type_ self#binding name
             )
             (fun t fa a fb b -> Format.fprintf t "%a@\n%a" fa a fb b)
          ) li
    | Type.Enum li ->
      Format.fprintf f "typedef enum %a {@\n@[<v2>  %a@]@\n} %a;"
        self#binding name
        (print_list
           (fun t name ->
             self#binding t name
           )
           (fun t fa a fb b -> Format.fprintf t "%a,@\n%a" fa a fb b)
        ) li
        self#binding name
    | _ ->
      Format.fprintf f "typedef %a %a;"
        self#ptype t
        self#binding name

  method stdin_sep f = Format.fprintf f "@[std::cin >> std::skipws;@]"

  method multiread f instrs = (* TODO, quand on a plusieurs noskip ou skip à la suite, il faut les virer*)
    let skipfirst, variables =
      List.fold_left (fun (skipfirst, variables) i -> match Instr.unfix i with
      | Instr.Read (t, mutable_) -> skipfirst, (t, mutable_, false)::variables
      | Instr.StdinSep -> begin match variables with
        | (t, m, s)::tl -> skipfirst, (t, m, true)::tl
        | [] -> true, []
      end
      | _ -> assert false
      ) (false, []) instrs
    in
    let lastSkip = ref false in
    let skipSet = ref false in
    Format.fprintf f "std::cin%a%a;"
      (fun f b -> if b then begin
        Format.fprintf f " >> std::skipws";
        lastSkip := true;
        skipSet := true;
      end
      ) skipfirst
      (print_list (fun f (t, x, b) ->
        if !lastSkip = b && !skipSet then
          Format.fprintf f " >> %a" self#mutable_ x
        else
          Format.fprintf f " >> %a >> std::%sskipws" self#mutable_ x
            (if b then "" else "no");
        lastSkip := b;
        skipSet := true;
       )
         (fun t fa a fb b -> Format.fprintf t "%a%a" fa a fb b))
      (List.rev variables)

end
