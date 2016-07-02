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

(** Perl Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Helper
open Stdlib
  
let print_lief prio f l =
  let open Format in
  let open Expr in
  match l with
  | Char c -> begin match c with
    | '$' -> fprintf f "\"\\$\""
    | _->
        let cs = Printf.sprintf "%C" c in
        if String.length cs == 6 then
          fprintf f "\"\\x%02x\"" (int_of_char c)
        else
          fprintf f "%S" (String.from_char c)
  end
  | String s ->
      let s = Printf.sprintf "%S" s in
      fprintf f "%s" (String.replace "$" "\\$" s)
  | Integer i ->
      if i < 0 then parens prio (-1) f "%i" i
      else fprintf f "%i" i
  | Bool true -> fprintf f "1"
  | Bool false -> fprintf f "()"
  | Enum s -> fprintf f "%S" s

  let print_op f op =
  let open Format in
  let open Expr in fprintf f "%s"
      (match op with
      | Add -> "+"
      | Sub -> "-"
      | Mul -> "*"
      | Div -> "/"
      | Mod -> "%"
      | Or -> "||"
      | And -> "&&"
      | Lower -> "<"
      | LowerEq -> "<="
      | Higher -> ">"
      | HigherEq -> ">="
      | Eq -> "eq"
      | Diff -> "ne"
      )
let print_mut c m f prio  =
  let open Format in
  let open Mutable in match m with
  | Var v -> c.print_varname f v
  | Array (m, fi) -> fprintf f "%a->%a" m prio
        (print_list (fun f a -> fprintf f "[%a]" a nop) nosep) fi
  | Dot (m, field) -> fprintf f "%a->{%S}" m prio field
let print_mut conf prio f m = Mutable.Fixed.Deep.fold (print_mut conf) m f prio
  
let config macros = {
  prio_binop = prio_binop_equal;
  prio_unop;
  print_varname=Helper.dolar_varname;
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
      fprintf f "int(%a %a %a)" a priol print_op op b prior
  | BinOp (a, Mod, b) -> fprintf f "remainder(%a, %a)" a nop b nop
  | Tuple li -> fprintf f "[%a]" (print_list (fun f x -> x f nop) sep_c) li
  | Record li -> fprintf f "{%a}" (print_list (fun f (name, x) ->
      fprintf f "%S => %a" name x nop) sep_c) li
  | _ -> print_expr0 config e f prio_parent in
  Fixed.Deep.fold (print_expr0 config) e f p

let print_instr c i =
  let open Ast.Instr in
  let open Format in
  let inprint f = function
    | StringConst s -> print_lief nop f (Ast.Expr.String s)
    | PrintExpr (_, e) -> e f nop in
  let block f li = fprintf f "@\n@[<v 4>{@\n%a@]@\n}" (print_list (fun f i -> i.p f seppt) sep_nl) li in
  let p f pend = match i with
  | Declare (var, ty, e, _) -> fprintf f "my %a = %a%a" c.print_varname var e nop pend ()
    | SelfAffect (mut, op, e) -> assert false
    | Affect (mut, e) -> fprintf f "%a = %a%a" (c.print_mut c nop) mut e nop pend ()
    | Loop (var, e1, e2, li) -> fprintf f "@[<h>foreach my %a (%a .. %a)@]%a"
          c.print_varname var e1 nop
          e2 nop
          block li
    | ClikeLoop (init, cond, incr, li) -> assert false
    | While (e, li) -> fprintf f "while (@[<h>%a@])%a" e nop block li
    | Comment s ->
        let lic = String.split s '\n' in
        print_list (fun f s -> fprintf f "#%s@\n" s) nosep f lic
    | Tag s -> fprintf f "/*%S*/" s
    | Return e -> fprintf f "return %a%a" e nop pend ()
    | AllocArray (name, t, e, None, opt) -> fprintf f "my %a = []%a"
          c.print_varname name
          pend ()
    | AllocArray (name, t, e, Some (var, lambda), opt) -> assert false
    | AllocArrayConst (name, ty, len, lief, opt) ->
        fprintf f "@[<h>%a = array_fill(0, %a, %a)%a@]" c.print_varname name
          len nop (c.print_lief nop) lief pend ()
    | AllocRecord (name, ty, list, opt) ->
        fprintf f "@[<v 4>my %a = {@\n%a}%a@]" c.print_varname name
          (print_list (fun f (field, x) -> fprintf f "%S=>%a" field x nop) (sep "%a,@\n%a")) list
          pend ()
    | If (e, listif, []) ->
        fprintf f "if (%a)%a" e nop block listif
    | If (e, listif, [elsecase]) when elsecase.is_if ->
        fprintf f "if (%a)%a@\n@[<v 4>els%a@]" e nop block listif elsecase.p seppt
    | If (e, listif, listelse) ->
        fprintf f "if (%a)%a@\nelse%a" e nop block listif block listelse
    | Call (func, li) ->  begin match StringMap.find_opt func c.macros with
      | Some ( (t, params, code) ) -> pmacros f "%s;" t params code li nop
      | None -> fprintf f "%s(%a)%a" func (print_list (fun f x -> x f nop) sep_c) li pend ()
    end
    | Print [e]-> fprintf f "print %a%a" inprint e pend ()
    | Print li-> fprintf f "print(%a)%a" (print_list inprint sep_c) li pend ()
    | Read li ->
        print_list
          (fun f -> function
            | Separation -> Format.fprintf f "@[readspaces()%a@]" pend ()
            | DeclRead (ty, v, opt) ->
                begin match Ast.Type.unfix ty with
                | Ast.Type.Char -> fprintf f "@[my %a = readchar()%a@]" c.print_varname v pend ()
                | Ast.Type.Integer -> fprintf f "@[my %a = readint()%a@]" c.print_varname v pend ()
                | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot read type %s"
                      (Type.type_t_to_string ty)))
                end
            | ReadExpr (ty, mut) ->
                begin match Ast.Type.unfix ty with
                | Ast.Type.Char -> fprintf f "@[%a = readchar()%a@]" (c.print_mut c nop) mut pend ()
                | Ast.Type.Integer -> fprintf f "@[%a = readint()%a@]" (c.print_mut c nop) mut pend ()
                | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot read type %s"
                      (Type.type_t_to_string ty)))
                end
          ) sep_nl f li
    | Untuple (li, expr, opt) -> fprintf f "my (%a) = @@{%a}%a" (print_list c.print_varname sep_c) (List.map snd li) expr nop pend ()
    | Unquote e -> assert false in
  let is_multi_instr = match i with
  | Read (hd::tl) -> true
  | _ -> false in
  {
   is_multi_instr = is_multi_instr;
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

class perlPrinter = object(self)
  inherit Printer.printer as baseprinter

  method binding f i = Format.fprintf f "$%a" baseprinter#binding i

  method main f main = self#instructions f main

  method instr f t =
   let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc "pl" li
        with Not_found -> List.assoc "" li) macros
   in (print_instr macros t) f

  method print_proto f (funname, t, li) =
    if li = [] then Format.fprintf f "sub %a{" self#funname funname
    else
    Format.fprintf f "sub %a{@\n@[<h>my(%a) = @@_;@]"
      self#funname funname
      (print_list self#binding sep_c) (List.map fst li)

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<v 2>%a@\n%a@]@\n}@\n"
      self#print_proto (funname, t, li)
      self#instructions instrs

  method decl_type f name t = ()

  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "#!/usr/bin/perl@\n%a%a%a%a%a%a@\n%a%a@\n@\n"
(fun f () ->
  if Tags.is_taged "perl_use_list_min" then Format.fprintf f "use List::Util qw(min max);@\n"
) ()
      (fun f () ->
	if need then Format.fprintf f "sub nextchar{ sysread STDIN, $currentchar, 1; }@\n") ()
      (fun f () ->
	if need_readchar then Format.fprintf f
	  "sub readchar{
  nextchar() if (!defined $currentchar);
  my $o = $currentchar;
  nextchar;
  return $o;
}@\n") ()
      (fun f () ->
	if need_readint then Format.fprintf f
	  "sub readint {
  nextchar() if (!defined $currentchar);
  my $o = 0, $sign = 1;
  if ($currentchar eq '-') {
    $sign = -1;
    nextchar;
  }
  while ($currentchar =~ /\\d/){
    $o = $o * 10 + $currentchar;
    nextchar;
  }
  return $o * $sign;
}@\n") ()
      (fun f () ->
	if need_stdinsep then Format.fprintf f
	  "sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq \"\\r\" || $currentchar eq \"\\n\"){ nextchar(); }
}@\n") ()
      (fun f () -> if Tags.is_taged "__internal__mod" then Format.fprintf f
	  "sub remainder {
    my ($a, $b) = @@_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}
"
      ) ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method comment f s =
    let lic = String.split s '\n' in
      print_list (fun f s -> Format.fprintf f "#%s@\n" s) nosep f lic

end
