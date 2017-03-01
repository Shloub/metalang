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
open Stdlib
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
    macros = Stdlib.StringMap.empty;
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

class printer = object(self)

  (** used variables *)
  val mutable used_variables = BindingSet.empty

  method used_affect () = false
  method calc_used_variables (instrs : Utils.instr list ) =
    used_variables <- calc_used_variables (self#used_affect ()) instrs

  val mutable typerEnv : Typer.env = Typer.empty

  method typename_of_field field = Typer.typename_for_field field typerEnv

  method getTyperEnv () = typerEnv

  method setTyperEnv t = typerEnv <- t

  val mutable macros = StringMap.empty
  
  method ptype f (t:Type.t) = ptype f t
    
  method print_proto f (funname, t, li) =
    Format.fprintf f "def@ %a %s(%a)"
      self#ptype t funname
      (print_list
         (fun f (n, t) ->
            Format.fprintf f "%a@ %a"
              self#ptype t print_varname n) sep_c) li
      
  method instructions f t =
      let macros = StringMap.map (fun (ty, params, li) ->
          ty, params,
          try List.assoc "php" li
          with Not_found -> List.assoc "" li) macros
      in print_list (fun f t -> (print_instr macros t) f) sep_nl f t

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<hov>%a@]@\n@[<v 2>  %a@]@\nend@\n"
      self#print_proto (funname, t, li)
      self#instructions instrs

  method prog_item (f:Format.formatter) t =
    match t with
    | Prog.Comment s -> clike_comment f s;
      Format.fprintf f "@\n"
    | Prog.DeclarFun (var, t, li, instrs, _opt) ->
      self#print_fun f var t li instrs;
      Format.fprintf f "@\n"
    | Prog.Macro (name, t, params, code) ->
      macros <- StringMap.add
          name (t, params, code)
          macros;
      ()
    | Prog.Unquote _ -> assert false
    | Prog.DeclareType (name, t) ->
      self#decl_type f name t;
      Format.fprintf f "@\n"

  method decl_type f name t =
    match (Type.unfix t) with
    | Type.Struct li ->
      Format.fprintf f "record %s %a@\nend@\n" name
        (print_list
           (fun t (name, type_) ->
              Format.fprintf t "%a %s;@\n" self#ptype type_ name
           ) nosep
        ) li
    | Type.Enum li ->
      Format.fprintf f "enum %s @\n@[<v2>  %a@]@\nend@\n" name
        (print_list
           (fun f name -> Format.fprintf f "%s" name) sep_nl
        ) li
    | _ -> Format.fprintf f "type %s = %a;" name self#ptype t

  method prog f (prog: Utils.prog) =
    Format.fprintf f "%a%a@\n"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method proglist f funs =
    Format.fprintf f "%a" (print_list self#prog_item nosep) funs

  val mutable recursives_definitions = StringSet.empty
  method setRecursive b = recursives_definitions <- b
  method is_rec funname = StringSet.mem funname recursives_definitions

  method main f (main : Utils.instr list) =
    Format.fprintf f "main@\n@[<v 2>  %a@]@\nend"
      self#instructions main
end
