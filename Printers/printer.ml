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

(** Main printer
    This printer write metalang code.
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Ext
open Helper
    
let print_mut conf priority f m = Ast.Mutable.Fixed.Deep.fold
    (print_mut0 "%a%a" "[%a]" "%a.%s" conf) m f priority
    
let ptype ty f () = 
  let open Type in
  let open Format in
  match ty with
  | Tuple li -> fprintf f "@[<hov>(%a)@]" (print_list (fun f p -> p f ()) sep_c) li
  | Auto -> ()
  | Integer -> fprintf f "int"
  | String -> fprintf f "string"
  | Array a -> fprintf f "array<%a>" a ()
  | Option a -> fprintf f "option<%a>" a ()
  | Void ->  fprintf f "void"
  | Bool -> fprintf f "bool"
  | Char -> fprintf f "char"
  | Named n -> fprintf f "@@%s" n
  | Lexems -> fprintf f "lexems"
  | Struct li ->
    fprintf f "record@\n @[<hov>%a@]@\nend"
      (print_list
         (fun t (name, type_) -> fprintf t "%s : %a;" name type_ ()) nosep
      ) li
  | Enum li -> fprintf f "enum{%a}" (print_list (fun f n -> Format.fprintf f "%s" n) sep_space) li

let ptype f t = Ast.Type.Fixed.Deep.fold ptype t f ()


let config =
  {
    prio_binop;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    macros = StringMap.empty;
    print_mut;
  }

let print_instr i =
  let open Ast.Instr in
  let open Format in
  let instructions f instrs = print_list (fun f i -> i.p f ()) sep_nl f instrs in
  let bloc f li = fprintf f "@[<v 2>do@\n%a@]@\nend" instructions li in
  let def_fields f li =
    print_list
      (fun f (fieldname, expr) ->
         Format.fprintf f "%s := %a"
           fieldname
           expr nop
      ) sep_nl f li in
  let p f ()  = match i with
    | Untuple (li, e, _) ->
      fprintf f "(%a) = %a"
        (print_list (fun f (t, e) -> Format.fprintf f "%a %a"
                        ptype t
                        print_varname e) sep_c) li
        e nop
    | Incr i -> fprintf f "%a++" (print_mut config nop) i
    | Decr i -> fprintf f "%a--" (print_mut config nop) i
    | Tag s -> fprintf f "tag %S" s
    | SelfAffect _ | Unquote _-> assert false
    | Declare (var, ty, expr, _) -> fprintf f "@[<h>def %a %a@ =@ %a@]" ptype ty print_varname var expr nop
    | Affect (mutable_, expr) -> fprintf f "@[<h>%a@ =@ %a@]" (print_mut config nop) mutable_ expr nop
    | ClikeLoop (init, cond, incr, li) -> assert false
    | Loop (varname, expr1, expr2, li) -> fprintf f "@[<h>for@ %a@ =@ %a@ to @ %a@\n@]%a"
                                            print_varname varname expr1 nop expr2 nop bloc li
    | While (expr, li) ->
      fprintf f "@[<hov>while %a@]@\n%a" expr nop bloc li
    | Comment s -> clike_comment f s
    | Return e -> fprintf f "@[<hov>return %a@]" e nop
    | AllocRecord (name, t, el, _) -> fprintf f "def %a = record %a end@\n"
                                        print_varname name def_fields el
    | AllocArray (binding, type_, len, None, u) -> assert false
    | AllocArray (binding, type_, len, Some ( (b, l) ), u) ->
      fprintf f "def array<%a> %a[%a] with %a %a" ptype type_ print_varname binding len nop
        print_varname b bloc l
    | AllocArrayConst (b, t, len, e, opt) -> assert false
          | If (e, ifcase, []) ->
      fprintf f "@[<h>if@ %a@]@\nthen@\n@[<v 2>  %a@]@\nend"
        e nop instructions ifcase
    | If (e, ifcase, elsecase) ->
      fprintf f "@[<h>if@ %a@]@\nthen@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]@\nend"
        e nop instructions ifcase instructions elsecase
    | Call (var, li) -> fprintf f "%s(%a)" var (print_list (fun f expr -> expr f nop) sep_c) li
    | Read li ->
      let li = List.map (function
          | Separation -> fun f -> fprintf f "skip"
          | DeclRead (t, var, _option) -> fun f -> fprintf f "def read %a %a" ptype t print_varname var
          | ReadExpr (t, m) -> fun f -> fprintf f "read %a %a" ptype t (print_mut config nop) m) li
      in print_list (fun f e -> e f) sep_nl f li
    | Print li ->
      let li = List.map (function
          | StringConst str -> fun f -> fprintf f "print string %a" (print_lief nop) (Expr.String str)
          | PrintExpr (t, expr) -> fun f -> fprintf f "print %a %a" ptype t expr nop ) li
      in print_list (fun f e -> e f) sep_nl f li
  in
  let is_multi_instr = match i with
    | Print (hd::tl) -> true
    | Read (hd::tl) -> true
    | _ -> false in
  {
    is_multi_instr=is_multi_instr;
    is_if=is_if i;
    is_if_noelse=is_if_noelse i;
    is_comment=is_comment i;
    p=p;
    default = ();
    print_lief = print_lief;
  }

let print_instr macros i =
  let open Ast.Instr.Fixed.Deep in
  let c = config in
  let i = (fold print_instr (mapg (print_expr c) i))
  in fun f -> i.p f i.default

let instructions macros f t =
      let macros = StringMap.map (fun (ty, params, li) ->
          ty, params,
          try List.assoc "php" li
          with Not_found -> List.assoc "" li) macros
      in print_list (fun f t -> (print_instr macros t) f) sep_nl f t

let decl_type f name t =
    match (Type.unfix t) with
    | Type.Struct li ->
      Format.fprintf f "record %s %a@\nend@\n" name
        (print_list
           (fun t (name, type_) ->
              Format.fprintf t "%a %s;@\n" ptype type_ name
           ) nosep
        ) li
    | Type.Enum li ->
      Format.fprintf f "enum %s @\n@[<v2>  %a@]@\nend@\n" name
        (print_list
           (fun f name -> Format.fprintf f "%s" name) sep_nl
        ) li
    | _ -> Format.fprintf f "type %s = %a;" name ptype t

let prog f (prog: Utils.prog) =
    let macros, items = List.fold_left
        (fun (macros, li) item -> match item with
           | Prog.Comment s ->
             macros, (fun f -> clike_comment f s) :: li
           | Prog.DeclarFun (funname, t, vars, instrs, _opt) ->
             macros, (fun f ->
                 Format.fprintf f "@[<hov>def %a %s (%a)@]@\n@[<v 2>  %a@]@\nend@\n"
                   ptype t funname
                   (print_list (fun f (n, t) ->
                        Format.fprintf f "%a@ %a"
                          ptype t print_varname n) sep_c) vars
                   (instructions macros) instrs
               ) :: li
           | Prog.Macro (name, t, params, code) ->
             let macros = StringMap.add name (t, params, code) macros in macros, li
           | Prog.Unquote _ -> macros, li
           | Prog.DeclareType (name, t) ->
             macros, (fun f -> decl_type f name t) :: li
        ) (StringMap.empty, []) prog.Prog.funs
    in
    Format.fprintf f "%a@\n%a@\n" (print_list (fun f g -> g f) sep_nl) (List.rev items)
      (print_option (fun f main ->
           Format.fprintf f "main@\n@[<v 2>  %a@]@\nend"
             (instructions macros) main
         )) prog.Prog.main
