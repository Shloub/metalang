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
open Helper

let print_lief prio f = function
  | Expr.Char c -> unicode f c
  | x -> print_lief prio f x

let config print_mut macros = {
    prio_binop;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
}
    
let print_expr config e f p = Expr.Fixed.Deep.fold (print_expr0 config) e f p

let rec ptype star tyenv f t =
  let open Ast.Type in
  let open Format in match unfix t with
    | Integer -> fprintf f "int"
    | String -> fprintf f "std::string"
    | Array a -> fprintf f (if star then "std::vector<%a> *" else "std::vector<%a>") (ptype star tyenv) a
    | Void ->  fprintf f "void"
    | Bool -> fprintf f "bool"
    | Char -> fprintf f "char"
    | Named n -> if star then match Typer.expand tyenv t
          default_location |> unfix with
      | Struct _ -> fprintf f "%s *" n
      | Enum _ -> fprintf f "%s" n
      | _ -> assert false
    else fprintf f "%s" n
    | Enum _ -> fprintf f "an enum"
    | Struct li -> fprintf f "a struct"
    | Auto | Lexems | Tuple _ -> assert false
    
let rec ptypename f t =
  let open Ast.Type in match unfix t with
    | Named n -> Format.fprintf f "%s" n
    | _ -> assert false
          
let print_instr cc tyenv c i =
  let ptype = ptype cc tyenv in
  let open Ast.Instr in
  let open Format in
  let p f pend = match i with
  | Declare (var, ty, e, _) -> fprintf f "%a %a = %a%a"
        ptype ty c.print_varname var e nop pend ()
  | AllocArray (name, t, e, None, opt) ->
      if cc then fprintf f "@[<h>std::vector<%a> *%a = new std::vector<%a>( %a )%a@]" ptype t c.print_varname name ptype t e nop pend ()
      else fprintf f "@[<h>std::vector<%a> %a( %a )%a@]" ptype t c.print_varname name e nop pend ()
    | AllocArray (name, t, e, Some (var, lambda), opt) -> assert false
    | AllocArrayConst (name, ty, len, lief, opt) ->
        if cc then fprintf f "@[<h>std::vector<%a> *%a = new std::vector<%a>( %a );@\nstd::fill(%a->begin(), %a->end(), %a)%a@]"
          ptype ty
          c.print_varname name
          ptype ty
          len nop
          c.print_varname name
          c.print_varname name
          (c.print_lief nop) lief pend ()
        else fprintf f "@[<h>std::vector<%a> %a( %a, %a )%a@]" ptype ty
          c.print_varname name
          len nop
          (c.print_lief nop) lief pend ()
    | AllocRecord (name, ty, list, opt) ->
        fprintf f "@[<v 4>%a %a%a%a@\n%a%a@]"
          ptype ty c.print_varname name
          (fun f () -> if cc then fprintf f " = new %a()" ptypename ty) () pend ()
          (print_list (fun f (field, x) -> fprintf f (if cc then "%a->%s = %a%a" else "%a.%s = %a%a")
              c.print_varname name field x nop pend ()) sep_nl) list
          pend ()
    | Print li->
        fprintf f "std::cout << %a%a"
          (print_list
             (fun f -> function
               | StringConst s -> c.print_lief nop f (Ast.Expr.String s)
               | PrintExpr (_, e) -> e f nop) (sep "%a << %a")) li
          pend ()
    | Read li ->
        let skipfirst, variables =
      List.fold_left (fun (skipfirst, variables) i -> match i with
      | Instr.ReadExpr (t, mutable_) -> skipfirst, (t, mutable_, false)::variables
      | Instr.DeclRead (t, var, _) ->
        let mutable_ = Mutable.var var in
        skipfirst, (t, mutable_, false)::variables
      | Instr.Separation -> begin match variables with
        | (t, m, s)::tl -> skipfirst, (t, m, true)::tl
        | [] -> true, []
      end
      ) (false, []) li
    in
    let lastSkip = ref true in
    Format.fprintf f "std::cin%a%a;"
      (fun f b -> if b then
        Format.fprintf f " >> std::skipws"
      ) skipfirst
      (print_list (fun f (t, x, b) ->
        if !lastSkip = b then
          Format.fprintf f " >> %a" (c.print_mut c nop) x
        else
          Format.fprintf f " >> %a >> std::%sskipws" (c.print_mut c nop) x
            (if b then "" else "no");
        lastSkip := b;
       ) nosep )
      (List.rev variables)
    | Untuple (li, expr, opt) -> fprintf f "list(%a) = %a%a" (print_list c.print_varname sep_c) (List.map snd li) expr nop pend ()
    | Unquote e -> assert false
    | _ -> clike_print_instr c i f pend
  in
  let is_multi_instr = match i with
  | Read (hd::tl) -> true
  | _ -> false in
  {
   is_multi_instr=is_multi_instr;
   is_if=is_if i;
   is_if_noelse=is_if_noelse i;
   is_comment=is_comment i;
   p=p;
   default = seppt;
   print_lief = c.print_lief;
 }

let print_instr cc print_mut tyenv macros i =
  let open Ast.Instr.Fixed.Deep in
  let c = config print_mut macros in
  let i = (fold (print_instr cc tyenv c) (mapg (print_expr c) i))
  in fun f -> i.p f i.default
    
let cc_print_mut conf prio f m = Mutable.Fixed.Deep.fold
    (print_mut0 "%a%a" "->at(%a)" "%a->%s" conf) m f prio
    
class cppPrinter = object(self)
  inherit CPrinter.cPrinter as super

 method instr f t =
   let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc "cpp" li
        with Not_found -> List.assoc "" li) macros
   in (print_instr true cc_print_mut (super#getTyperEnv ()) macros t) f

  method lang () = "cpp"

  method collect_for instrs =
    let collect acc i =
      Instr.Writer.Deep.fold (fun (acci, accc) i -> match Instr.unfix i with
      | Instr.Read li -> List.fold_left (fun (acci, accc) -> function
          | Instr.DeclRead (ty, i, _) ->
              begin match Type.unfix ty with
              | Type.Integer ->  let acci = if List.mem i acci then acci else i::acci in acci, accc
              | Type.Char ->  let accc = if List.mem i accc then accc else i::accc in acci, accc
              | _ -> assert false
              end
          | _ -> acci, accc) (acci, accc) li
      | _ -> (acci, accc)
      ) acc i
    in
    List.fold_left collect ([], []) instrs

  method ptype f t = ptype true (super#getTyperEnv ()) f t

  method prog f prog =
    Format.fprintf f
      "#include <iostream>@\n#include <vector>@\n%a%a@\n%a\n"
      (fun f () ->
        if Tags.is_taged "use_math"
        then Format.fprintf f "#include<cmath>@\n";
        if Tags.is_taged "use_cpp_algorithm"
        then Format.fprintf f "#include <algorithm>@\n";
        if Tags.is_taged "use_cc_readline"
        then Format.fprintf f "std::vector<char> *getline() {
    if (std::cin.flags() & std::ios_base::skipws) {
        char c = std::cin.peek();
        if (c == '\\n' || c == ' ') std::cin.ignore();
        std::cin.unsetf(std::ios::skipws);
    }
    std::string line;
    std::getline(std::cin, line);
    std::vector<char> *c = new std::vector<char>(line.begin(), line.end());
    std::cin >> std::skipws;
    return c;
}@\n"
      ) ()

      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method main f main =
    let li_fori, li_forc = self#collect_for main in
    Format.fprintf f "@[<v 4>int main() {@\n%a%a%a@]@\n}"
      (self#declare_for "int") li_fori
      (self#declare_for "char") li_forc
      self#instructions main

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        Format.fprintf f "struct %a {@\n@[<v 4>    %a@]@\n};@\n"
          self#typename name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "%a %a;" self#ptype type_ self#field name
             )
             sep_nl
          ) li
    | Type.Enum li ->
      Format.fprintf f "typedef enum %a {@\n@[<v 4>    %a@]@\n} %a;"
        self#typename name
        (print_list
           (fun t name -> self#enumfield t name)
           (sep "%a,@\n%a")
        ) li
        self#typename name
    | _ ->
      Format.fprintf f "typedef %a %a;"
        self#ptype t
        self#typename name
end

let cpp_print_mut conf prio f m = Mutable.Fixed.Deep.fold
    (print_mut0 "%a%a" "[%a]" "%a.%s" conf) m f prio
    
class proloCppPrinter = object(self)
  inherit CPrinter.cPrinter as super

 method instr f t =
   let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc "cpp" li
        with Not_found -> List.assoc "" li) macros
   in (print_instr false cpp_print_mut (super#getTyperEnv ()) macros t) f

  method ptype f t = ptype false (super#getTyperEnv ()) f t
  method prototype f t =
    match Type.unfix t with
    | Type.Array a -> Format.fprintf f "%a&" self#ptype t
    | Type.Named n -> begin match Typer.expand (super#getTyperEnv ()) t
        default_location |> Type.unfix with
        | Type.Struct _ -> Format.fprintf f "%a&" self#ptype t
        | _ -> self#ptype f t
    end
    | _ -> self#ptype f t

  
  method prog f prog =
    Format.fprintf f
      "#include <iostream>@\n#include <vector>@\n%a%a@\n%a\n"
      (fun f () ->
        if Tags.is_taged "use_math"
        then Format.fprintf f "#include<cmath>@\n";
        if Tags.is_taged "use_cpp_algorithm"
        then Format.fprintf f "#include <algorithm>@\n";
        if Tags.is_taged "use_cc_readline"
        then Format.fprintf f "std::vector<char> getline() {
    if (std::cin.flags() & std::ios_base::skipws) {
        char c = std::cin.peek();
        if (c == '\\n' || c == ' ') std::cin.ignore();
        std::cin.unsetf(std::ios::skipws);
    }
    std::string line;
    std::getline(std::cin, line);
    std::vector<char> c(line.begin(), line.end());
    std::cin >> std::skipws;
    return c;
}@\n";
        if Tags.is_taged "use_cpp_readmatrix"
        then Format.fprintf f "@\ntemplate <typename T> std::vector<std::vector<T>> read_matrix(int l, int c) {
    std::vector<std::vector<T>> matrix(l, std::vector<T>(c));
    for (std::vector<T>& line : matrix)
        for (T& elem : line)
            std::cin >> elem;
    return matrix;
}@\n"
      ) ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

end
