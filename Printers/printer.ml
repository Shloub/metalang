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

let lang = "abstract"

type oppart =
| Left | Right

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

  method expr f e =
    let print_mut conf priority f m = Ast.Mutable.Fixed.Deep.fold
        (print_mut0 "%a%a" "[%a]" "%a.%s" conf) m f priority in
    print_expr
      { prio_binop; prio_unop; print_varname; print_lief; print_op;
        print_unop;
        macros=(StringMap.map (fun (ty, params, li) ->
          ty, params,
          try List.assoc (self#lang ()) li
          with Not_found -> List.assoc "" li) macros);
        print_mut} e f nop

  method binding f b = print_varname f b

  method field f i = Format.fprintf f "%s" i
  method enumfield f i = Format.fprintf f "%s" i
  method funname f i = Format.fprintf f "%s" i
  method typename f i = Format.fprintf f "%s" i

  method declaration f var t e =
    Format.fprintf f "@[<hov>def %a@ %a@ =@ %a@]"
      self#ptype t
      self#binding var
      self#expr e

  method affect f mutable_ (expr : Utils.expr) =
    Format.fprintf f "@[<hov>%a@ =@ %a%a@]" self#mutable_set mutable_ self#expr expr self#separator ()

  method bloc f li = Format.fprintf f "@[<v>do@\n%a@]@\nend"
    (print_list self#instr sep_nl) li

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<hov>for@ %a=%a@ to@ %a@\n@]%a"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#bloc li

  method whileloop f expr li =
    Format.fprintf f "@[<hov>while %a@]@\n%a"
      self#expr expr
      self#bloc li

  method comment f str =
    Format.fprintf f "/*%s*/" str

  method return f e =
    Format.fprintf f "@[<hov>return@ %a@]" self#expr e

  method ptype f (t:Type.t) =
    let open Type in
    let open Format in
    let ptype ty f () = match ty with
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
           (fun t (name, type_) -> fprintf t "%a : %a;" self#field name type_ ()) nosep
        ) li
    | Enum li -> fprintf f "enum{%a}" (print_list self#enumfield sep_space) li
    in Fixed.Deep.fold ptype t f ()

  method p_option f = function
  | { Ast.Instr.useless = true } -> Format.fprintf f "useless "
  | { Ast.Instr.useless = false } -> ()

  method allocarray f binding type_ len useless =
    Format.fprintf f "@[<hov>def %aarray<%a> %a[%a]"
      self#p_option useless
      self#ptype type_
      self#binding binding
      self#expr len

  method allocarray_lambda f binding type_ len binding2 lambda useless =
    Format.fprintf f "@[<hov>def %a array<%a>%a[%a] with %a do@\n@[<v 2>  %a@]@\nend@]"
      self#p_option useless
      self#ptype type_
      self#binding binding
      self#expr len
      self#binding binding2
      self#instructions lambda

  method m_variable f b = self#binding f b
  method m_variable_get f b = self#m_variable f b
  method m_variable_set f b = self#m_variable f b

  method m_field f m field = Format.fprintf f "%a.%a" self#mutable_get m self#field field
  method m_field_get f m field = self#m_field f m field
  method m_field_set f m field = self#m_field f m field

  method m_array f m indexes = Format.fprintf f "%a[%a]" self#mutable_get m (print_list self#expr (sep "%a][%a")) indexes
  method m_array_get f m indexes = self#m_array f m indexes
  method m_array_set f m indexes = self#m_array f m indexes

  method mutable_set f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) -> self#m_field_set f m field
    | Mutable.Var binding -> self#m_variable_set f binding
    | Mutable.Array (m, indexes) -> self#m_array_set f m indexes

  method mutable_get f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) -> self#m_field_get f m field
    | Mutable.Var binding -> self#m_variable_get f binding
    | Mutable.Array (m, indexes) -> self#m_array_get f m indexes

  method lang () = lang

  method call f var li =
    Format.fprintf f "%a%a" (fun f () -> self#apply f var li) ()
      self#separator ()

  method separator f () = Format.fprintf f ";"

  method apply f var li =
    match StringMap.find_opt var macros with
    | Some ( (t, params, code) ) ->
        let li = List.map (fun e f () -> self#expr f e) li in
        let code = try List.assoc (self#lang ()) code
        with Not_found -> List.assoc "" code in
        pmacros f "%s" t params code li ()
    | None ->
      Format.fprintf
        f
        "@[<hov>%a(%a)@]"
        self#funname var
        (print_list self#expr sep_c) li

  method stdin_sep f =
    Format.fprintf f "skip"

  method def_fields name f li =
    Format.fprintf f "@[<hov>%a@]"
      (print_list
         (fun f (fieldname, expr) ->
           Format.fprintf f "%a = %a"
             self#field fieldname
             self#expr expr
         ) sep_nl)
      li

  method allocrecord f name t el =
    Format.fprintf f "def %a %a = with %a end"
      self#ptype t
      self#binding name
      (self#def_fields name) el

  method selfAssoc f m e2 = function
  | Expr.Add -> begin match Expr.unfix e2 with
    | Expr.Lief (Expr.Integer 1) ->
      Format.fprintf f "@[<hov>%a++;@]" self#mutable_set m
    | _ ->
      Format.fprintf f "@[<hov>%a += %a;@]" self#mutable_set m
        self#expr e2
  end
  | Expr.Sub ->
    begin match Expr.unfix e2 with
    | Expr.Lief (Expr.Integer 1) ->
      Format.fprintf f "@[<hov>%a --;@]" self#mutable_set m
    | _ ->
      Format.fprintf f "@[<hov>%a -= %a;@]" self#mutable_set m
        self#expr e2
    end
  | Expr.Mul ->
    Format.fprintf f "@[<hov>%a *= %a;@]" self#mutable_set m self#expr e2
  | Expr.Div ->
    Format.fprintf f "@[<hov>%a /= %a;@]" self#mutable_set m self#expr e2
  | Expr.Mod ->
    Format.fprintf f "@[<hov>%a %%= %a;@]" self#mutable_set m self#expr e2
  | _ -> assert false

  method hasSelfAffect op = true

  method instr f t =
    match Instr.unfix t with
    | Instr.Tag s ->  Format.fprintf f "tag %s@\n" s
    | Instr.Unquote li -> Format.fprintf f "${%a}" self#expr li
    | Instr.Declare (varname, type_, expr, _option) -> self#declaration f varname type_ expr
    | Instr.Incr mutable_ ->
        let op = Expr.Add in
        let expr = Expr.integer 1 in
        if self#hasSelfAffect op then
          self#selfAssoc f mutable_ expr op
        else self#affect f mutable_ (Expr.binop op (Expr.access mutable_) expr)
    | Instr.Decr mutable_ ->
        let op = Expr.Sub in
        let expr = Expr.integer 1 in
        if self#hasSelfAffect op then
          self#selfAssoc f mutable_ expr op
        else self#affect f mutable_ (Expr.binop op (Expr.access mutable_) expr)
    | Instr.SelfAffect (mutable_, op, expr) ->
        if self#hasSelfAffect op then
          self#selfAssoc f mutable_ expr op
        else self#affect f mutable_ (Expr.binop op (Expr.access mutable_) expr)
    | Instr.Affect (mutable_, expr) ->
      begin match Expr.unfix expr with
      | Expr.BinOp (e1, op, e2) ->
        let fallback () =
          if op = Expr.Add || op = Expr.Mul then
            begin match Expr.unfix e2 with
            | Expr.Access m ->
              if Mutable.equals (=) m mutable_ then
                self#selfAssoc f m e1 op
              else self#affect f mutable_ expr
            | _ -> self#affect f mutable_ expr
            end
          else self#affect f mutable_ expr
        in
        if self#hasSelfAffect op then
          begin match Expr.unfix e1 with
          | Expr.Access m ->
            if Mutable.equals (=) m mutable_ then
              self#selfAssoc f m e2 op
            else fallback ()
          | _ -> fallback ()
          end
        else self#affect f mutable_ expr
      | _ -> self#affect f mutable_ expr
      end
    | Instr.Loop (varname, expr1, expr2, li) ->
      self#forloop f varname expr1 expr2 li
    | Instr.While (expr, li) ->
      self#whileloop f expr li
    | Instr.Comment str -> self#comment f str
    | Instr.Return e -> self#return f e
    | Instr.AllocRecord (name, t, el, _) ->
      self#allocrecord f name t el
    | Instr.AllocArray (binding, type_, len, None, u) ->
      self#allocarray f binding type_ len u
    | Instr.AllocArray (binding, type_, len, Some ( (b, l) ), u) ->
      self#allocarray_lambda f binding type_ len b l u
    | Instr.AllocArrayConst (b, t, len, e, opt) ->
        self#allocarrayconst f b t len e opt
    | Instr.If (e, ifcase, elsecase) ->
      self#if_ f e ifcase elsecase
    | Instr.Call (var, li) -> self#call f var li
    | Instr.Read li -> self#multi_read f li
    | Instr.Print [Instr.StringConst str] -> self#print_const f str
    | Instr.Print [Instr.PrintExpr (t, e)] -> self#print f t e
    | Instr.Print li -> self#multi_print f li
    | Instr.Untuple (li, e, _) -> self#untuple f li e
    | Instr.ClikeLoop _ -> assert false

  method allocarrayconst f b t len e opt = assert false

  method untuple f li e =
    Format.fprintf f "(%a) = %a"
      (print_list self#binding sep_c) (List.map snd li)
      self#expr e


  method noformat s = let s = Format.sprintf "%S" s
                      in String.replace "%" "%%" s

  method format_type f (t:Type.t) = Format.fprintf f "%s" (self#formater_type t)

  method read f t mutable_ =
    Format.fprintf f "@[read %a %a@]" self#ptype t self#mutable_set mutable_

  method read_decl f t v =
    Format.fprintf f "@[def read %a %a@]"
      self#ptype t
      self#binding v

  method print f t expr =
    Format.fprintf f "@[print %a %a@]" self#ptype t self#expr expr

  method print_const f str = self#print f Type.string (Expr.string str)

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<hov>if@ %a@]@\nthen@\n@[<v2>  %a@]@\nend"
        self#expr e
        self#instructions ifcase
    | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<hov>if@ %a@] then@\n@[<v 2>  %a@]@\nels%a"
        self#expr e
        self#instructions ifcase
        self#instr instr
    | _ ->
      Format.fprintf f "@[<hov>if@ %a@]@\nthen@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]@\nend"
        self#expr e
        self#instructions ifcase
        self#instructions elsecase

  method printp f e =
    Format.fprintf f "@[<hov 2>(%a)@]" self#expr e

  method print_proto f (funname, t, li) =
    Format.fprintf f "def@ %a %a(%a)"
      self#ptype t
      self#funname funname
      (print_list
         (fun f (n, t) ->
           Format.fprintf f "%a@ %a"
             self#ptype t
             self#binding n) sep_c) li

  method print_fun f funname t li instrs =
    Format.fprintf f "@[<hov>%a@]@\n@[<v 2>  %a@]@\nend@\n"
      self#print_proto (funname, t, li)
      self#instructions instrs

  method prog_item (f:Format.formatter) t =
    match t with
    | Prog.Comment s -> self#comment f s;
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
      Format.fprintf f "record %a %a@\nend@\n"
        self#typename name
        (print_list
           (fun t (name, type_) ->
             Format.fprintf t "%a %a;@\n" self#ptype type_ self#field name
           ) nosep
        ) li
    | Type.Enum li ->
      Format.fprintf f "enum %a @\n@[<v2>  %a@]@\nend@\n"
        self#typename name
        (print_list
           (fun t name ->
             self#enumfield t name
           ) sep_nl
        ) li
    | _ ->
      Format.fprintf f "type %a = %a;" self#typename name self#ptype t

  method prog f (prog: Utils.prog) =
    Format.fprintf f "%a%a@\n"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method multi_read f li =
    let li = List.map (function
      | Instr.Separation -> fun f () -> self#stdin_sep f
      | Instr.DeclRead (t, var, _option) -> fun f () -> self#read_decl f t var
      | Instr.ReadExpr (t, mutable_) -> fun f () -> self#read f t mutable_ ) li
    in print_list (fun f e -> e f ()) sep_nl f li

  method multi_print f li =
    let li = List.map (function
      | Instr.StringConst str -> fun f () -> self#print_const f str
      | Instr.PrintExpr (t, expr) -> fun f () ->self#print f t expr ) li
    in print_list (fun f e -> e f ()) sep_nl f li

  method formater_type t = format_type t
  method limit_nprint () = 100000

  method instructions f instrs =
    print_list self#instr sep_nl f instrs

  method proglist f funs =
    Format.fprintf f "%a" (print_list self#prog_item nosep) funs

  val mutable recursives_definitions = StringSet.empty
  method setRecursive b = recursives_definitions <- b
  method is_rec funname = StringSet.mem funname recursives_definitions

  method extract_multi_print (li:Utils.expr Instr.printable list) =
    let s, e = List.fold_left (fun (format, exprs) -> function
      | Instr.StringConst str ->
          let s = self#noformat str in
          format ^ (String.sub s 1 (String.length s - 2)), exprs
      | Instr.PrintExpr (t, expr) -> format ^ (self#formater_type t), (t, expr)::exprs) ("",  []) li
    in s, List.rev e

  method extract_multi_printers (li:Utils.expr Instr.printable list) =
    List.fold_left (fun acc -> function
      | Instr.StringConst str -> (fun f () -> self#expr f (Expr.string str)) :: acc
      | Instr.PrintExpr (t, expr) -> (fun f () -> self#expr f expr) :: acc) [] li |> List.rev

  method main f (main : Utils.instr list) =
    Format.fprintf f "main@\n@[<v 2>  %a@]@\nend"
      self#instructions main
end
