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


(** ruby Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib
open Helper
open Ast
let print_lief prio f l = 
  let open Format in
  let open Ast.Expr in match l with
  | Char c ->
      let cs = Printf.sprintf "%C" c in
      if String.length cs == 6 then
        fprintf f "\"\\u%04x\"" (int_of_char c)
      else fprintf f "%S" (String.from_char c)
  | String s -> fprintf f "%S" s
  | Integer i ->
      if i < 0 then parens prio (-1) f "%i" i
      else fprintf f "%i" i
  | Bool true -> fprintf f "true"
  | Bool false -> fprintf f "false"
  | Enum s -> fprintf f "%S" s

let config macros = {
    prio_binop = prio_binop_equal;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
  } 

let print_expr config e f p =
  let open Format in
  let open Ast.Expr in
  let print_expr0 config e f prio_parent = match e with
  | BinOp (a, (Div as op), b) ->
      let _, priol, prior = prio_binop op in
      fprintf f "(%a.to_f %a %a).to_i" a priol print_op op b prior
  | BinOp (a, Mod, b) -> fprintf f "mod(%a, %a)" a nop b nop
  | Tuple li -> fprintf f "[%a]" (print_list (fun f x -> x f nop) sep_c) li
  | Record li -> fprintf f "{%a}" (print_list (fun f (name, x) ->
      fprintf f "%S => %a" name x nop) sep_c) li
  | _ -> print_expr0 config e f prio_parent in
  Fixed.Deep.fold (print_expr0 config) e f p


let print_instr tyenv c i =
  let open Ast.Instr in
  let open Format in
  let block value f li = fprintf f "@\n%a" (print_list (fun f i -> i.p f (false, value)) sep_nl) li in
  let block_lambda = block true in
  let p f (inelseif, inlambda) =
    let block = block inlambda in match i with
    | Declare (var, ty, e, _) -> fprintf f "%a = %a" c.print_varname var e nop
  | SelfAffect (mut, Ast.Expr.Div, e) -> fprintf f "%a = (%a.to_f / %a).to_i"
        (c.print_mut c nop) mut (c.print_mut c nop) mut e nop
    | SelfAffect (mut, op, e) -> fprintf f "%a %a= %a" (c.print_mut c nop) mut c.print_op op e nop
    | Affect (mut, e) -> fprintf f "%a = %a" (c.print_mut c nop) mut e nop
    | ClikeLoop (init, cond, incr, li) -> assert false
    | Loop (var, e1, e2, li) -> fprintf f "@[<v 4>@[<h>for %a in (%a ..  %a) do@]%a@\nend"
          c.print_varname var e1 nop e2 nop
          block li
    | While (e, li) -> fprintf f "@[<v 4>while @[<h>%a@] do%a@]@\nend" e nop block li
    | Comment s -> let lic = String.split s '\n' in
        print_list (fun f s -> Format.fprintf f "#%s@\n" s) nosep f lic
    | Tag s -> fprintf f "/*%S*/" s
    | Return e -> if inlambda then fprintf f "next %a" e nop else fprintf f "return %a" e nop
    | AllocArray (name, t, e, None, opt) -> assert false
    | AllocArray (name, t, e, Some (var, lambda), opt) ->
        fprintf f "@[<v 2>%a = [*0..@[<h>%a-1@]].map { |%a|@\n%a@\n}@]"
          c.print_varname name
          e nop
          c.print_varname var
          block_lambda lambda
    | AllocArrayConst (name, ty, len, lief, opt) -> assert false
    | AllocRecord (name, ty, list, opt) ->
        fprintf f "@[<v 4>%a = {%a}@\n@]" c.print_varname name
          (print_list (fun f (field, x) -> fprintf f "%s:%a" field x nop) sep_nl) list
    | If (e, listif, []) when inelseif ->
        fprintf f "if %a then%a@]@\nend" e nop block listif
    | If (e, listif, [elsecase]) when inelseif && elsecase.is_if ->
        fprintf f "if %a then%a@]@\n@[<v 4>els%a" e nop block listif elsecase.p (true, inlambda)          
    | If (e, listif, listelse)  when inelseif ->
        fprintf f "if %a then%a@]@\n@[<v 4>else %a@]@\nend" e nop block listif block listelse
    | If (e, listif, []) ->
        fprintf f "@[<v 4>if %a then%a@]@\nend" e nop block listif
    | If (e, listif, [elsecase]) when elsecase.is_if ->
        fprintf f "@[<v 4>if %a then%a@]@\n@[<v 4>els%a" e nop block listif elsecase.p (true, inlambda)          
    | If (e, listif, listelse) ->
        fprintf f "@[<v 4>if %a then%a@]@\n@[<v 4>else %a@]@\nend" e nop block listif block listelse
    | Call (func, li) ->  begin match StringMap.find_opt func c.macros with
      | Some ( (t, params, code) ) -> pmacros f "%s" t params code li nop
      | None -> fprintf f "%s(%a)" func (print_list (fun f x -> x f nop) sep_c) li
    end
    | Print li->
        let format, exprs = extract_multi_print clike_noformat format_type li in
        begin match exprs with
        | [] -> fprintf f "print \"%s\"" format
        | _ -> fprintf f "printf \"%s\", %a" format
              (print_list (fun f (t, e) -> e f nop) sep_c) exprs
        end
    | Read li ->
        (* Comme toujours, les espaces posent problème.
        let format, mutables_affected, declared = split_multi_read li "" format_type in
        begin match mutables_affected with
        | [] -> fprintf f "scanf(\"%s\")" format
        | [variable] -> fprintf f "%a=scanf(\"%s\")[0]" (c.print_mut c nop) variable format
        | variables ->
            fprintf f "(%a) = @[scanf(\"%s\")@]"
              (print_list (fun f v -> Format.fprintf f "%a" (c.print_mut c nop) v) (sep "%a, %a"))
              variables format
        end
        *)
        let li = List.map (function
          | Separation -> fun f -> fprintf f "@[scanf(\"%%*\\n\")@]"
          | i -> fun f -> let li = [i] in
            let format, variables, _ = split_multi_read li " " format_type in
            begin match variables with
            | [variable] -> fprintf f "%a = @[scanf(\"%s\")[0]@]" (c.print_mut c nop) variable format
            | variables ->
                fprintf f "(%a) = @[scanf(\"%s\")@]"
                  (print_list (fun f v -> Format.fprintf f "%a" (c.print_mut c nop) v) (sep "%a, %a"))
                  variables format
            end ) li
        in
        fprintf f "%a" (print_list (fun f g -> g f) sep_nl) li
    | Untuple (li, expr, opt) -> fprintf f "(%a) = %a" (print_list c.print_varname sep_c) (List.map snd li) expr nop
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
   default = (false, false);
   print_lief = c.print_lief;
 }

let print_instr tyenv macros i =
  let open Ast.Instr.Fixed.Deep in
  let c = config macros in
  let i = (fold (print_instr tyenv c) (mapg (print_expr c) i))
  in fun f -> i.p f i.default
  
class rbPrinter = object(self)

  val mutable typerEnv : Typer.env = Typer.empty
  method setTyperEnv t = typerEnv <- t
  val mutable macros = StringMap.empty
      
  val mutable recursives_definitions = StringSet.empty
  method setRecursive b = recursives_definitions <- b

  method instr f (t:Utils.instr) =
   let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc "ruby" li
        with Not_found -> List.assoc "" li) macros
   in (print_instr typerEnv macros t) f

  method instructions f instrs = print_list self#instr sep_nl f instrs
      
  method prog f prog =
    Format.fprintf f "require \"scanf.rb\"@\n%s%a%a@\n"
    (if Tags.is_taged "__internal__mod" then
        "def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
" else "")
    (print_list (fun f -> function
      | Prog.DeclarFun (funname, _t, li, instrs, _opt) ->
          Format.fprintf f "@[<h>def %s( %a )@]@\n@[<v 2>  %a@]@\nend@\n"
            funname (print_list print_varname sep_c) (List.map fst li)
            self#instructions instrs
      | Prog.Macro (name, t, params, code) ->
          macros <- StringMap.add name (t, params, code) macros;
      | Prog.Comment s ->
          let lic = String.split s '\n' in
          print_list (fun f s -> Format.fprintf f "#%s@\n" s) nosep f lic
      | _ -> ()) sep_nl) prog.Prog.funs
      (print_option self#instructions) prog.Prog.main
      
end
