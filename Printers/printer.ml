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

let format_type t = match Type.unfix t with
  | Type.Integer -> "%d"
  | Type.Char -> "%c"
  | Type.String ->  "%s"
  | Type.Bool -> "%b"
  | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Type.type_t_to_string t))
)

type oppart =
| Left | Right

class printer = object(self)

  (** used variables *)
  val mutable used_variables = BindingSet.empty

  method used_affect () = false
  method calc_used_variables (instrs : Utils.instr list ) =
    let rec fold_expr acc e =
      match Expr.unfix e with
      | Expr.Access m -> Mutable.Writer.Deep.fold fold_mut acc m
      | _ -> acc
    and fold_mut acc m = match Mutable.unfix m with
      | Mutable.Var varname -> BindingSet.add varname acc
      | Mutable.Array (_, lie) -> List.fold_left
        dfold_expr acc lie
      | _ -> acc
    and dfold_expr acc e =
      Expr.Writer.Deep.fold fold_expr
        (fold_expr acc e) e
    in
    let fold_instr acc i =
      let acc = Instr.Fixed.Deep.foldg (fun e acc -> dfold_expr acc e) i acc in
      Instr.Writer.Deep.fold (fun acc i -> match Instr.unfix i with
      | Instr.Affect (m, e) ->
        begin match Mutable.unfix m with
        | Mutable.Var var ->
          if self#used_affect () then BindingSet.add var acc
          else acc
        | _ -> Mutable.Writer.Deep.fold fold_mut acc m
        end
      | _ -> acc) acc i
    in
    used_variables <-
      List.fold_left fold_instr BindingSet.empty
      instrs


  val mutable typerEnv : Typer.env = Typer.empty

  method typename_of_field field = Typer.typename_for_field field typerEnv

  method getTyperEnv () = typerEnv

  method setTyperEnv t = typerEnv <- t

  val mutable macros = StringMap.empty

  method binding f = function
  | UserName i -> Format.fprintf f "%s"i 
  | InternalName i -> Format.fprintf f "internal__%d" i

  method field f i = Format.fprintf f "%s" i
  method enum f i = Format.fprintf f "%s" i
  method enumfield f i = Format.fprintf f "%s" i
  method funname f i = Format.fprintf f "%s" i
  method typename f i = Format.fprintf f "%s" i
  method string f i = Format.fprintf f "%S" i

  method string_nodolar f s =
    let s = Printf.sprintf "%S" s in
    Format.fprintf f "%s" (String.replace "$" "\\$" s)

  method is_printable_i i =
    let lowerchar = i >= (int_of_char 'a') && i <= (int_of_char 'z') in
    let upperchar = i >= (int_of_char 'A') && i <= (int_of_char 'Z') in
    let digit = i >= (int_of_char '0') && i <= (int_of_char '9') in
    let specials = List.map int_of_char [ ' '; '|';
					  '#'; '&'; '(';
					  ')'; '*'; '+'; ','; '-';
					  '.'; '/'; ':'; ';'; '<';
					  '='; '>'; '_'; '|'; '!';
					  '%'; '?'; '@'; '[';
					  ']'; '^'; '`'; '{';
					  '}'; '~']
	in let specials = List.mem i specials
	   in lowerchar || upperchar || digit || specials

  method is_printable c = self#is_printable_i (int_of_char c)

  method string_noprintable print_first_char f s =
    let li = Array.to_list @$ String.chararray s in
    let fst, printable = List.fold_left
      (fun (fst, printable) c ->
	if fst then
	  if self#is_printable c then begin
	    Format.fprintf f "\"%c" c;
	    (false, true)
	  end
	  else if print_first_char then
	    begin Format.fprintf f "\"\" & %a" self#char c;
	      (false, false) end
	  else
	    begin Format.fprintf f "%a" self#char c;
	      (false, false) end
	else if self#is_printable c then
	  if printable then begin
	    Format.fprintf f "%c" c;
	    (false, true)
	  end
	  else begin
	    Format.fprintf f " & \"%c" c;
	    (false, true)
	  end
	else
	  if printable then begin
	    Format.fprintf f "\" & %a" self#char c;
	    (false, false)
	  end
	  else begin
	    Format.fprintf f " & %a" self#char c;
	    (false, false)
	  end
      ) (true, false) li
    in if printable then
	Format.fprintf f "\""
      else if fst then
	Format.fprintf f "\"\""


  method declaration f var t e =
    Format.fprintf f "@[<hov>def %a@ %a@ =@ %a@]"
      self#ptype t
      self#binding var
      self#expr e

  method affect f mutable_ (expr : 'lex Expr.t) =
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
    match Type.unfix t with
    | Type.Tuple li ->
      Format.fprintf f "@[<hov>(%a)@]"
        (print_list self#ptype sep_c) li
    | Type.Auto -> ()
    | Type.Integer -> Format.fprintf f "int"
    | Type.String -> Format.fprintf f "string"
    | Type.Array a -> Format.fprintf f "array<%a>" self#ptype a
    | Type.Void ->  Format.fprintf f "void"
    | Type.Bool -> Format.fprintf f "bool"
    | Type.Char -> Format.fprintf f "char"
    | Type.Named n -> Format.fprintf f "@@%s" n
    | Type.Lexems -> Format.fprintf f "lexems"
    | Type.Struct li ->
      Format.fprintf f "record@\n @[<hov>%a@]@\nend"
        (print_list
           (fun t (name, type_) ->
             Format.fprintf t "%a : %a;" self#field name self#ptype type_
           ) nosep
        ) li
    | Type.Enum li ->
      Format.fprintf f "enum{%a}"
        (print_list self#enumfield sep_space) li

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

  method expand_macro_apply f name t params code li =
    self#expand_macro_call f name t params code li

  method lang () = "abstract"

  method expand_macro_call f name t params code li =
    let lang = self#lang () in
    let code_to_expand = List.fold_left
      (fun acc (clang, expantion) ->
        match acc with
        | Some _ -> acc
        | None ->
          if clang = "" || clang = lang then
            Some expantion
          else None
      ) None
      code
    in match code_to_expand with
    | None -> failwith ("no definition for macro "^name^" in language "^lang)
    | Some s ->
      let listr = List.map
        (fun e ->
          let b = Buffer.create 1 in
          let fb = Format.formatter_of_buffer b in
          Format.fprintf fb "@[<hov>%a@]%!" self#expr e;
          Buffer.contents b
        ) li in
      let expanded = List.fold_left
        (fun s ((param, _type), string) ->
          String.replace ("$__MACRO__PARAM__"^param) string s
        )
        (String.replace "$" "$__MACRO__PARAM__" s)
        (List.combine params listr)
      in let expanded = String.replace "$__MACRO__PARAM__" "$" expanded
      in Format.fprintf f "%s" expanded

  method call f var li =
    Format.fprintf f "%a%a" (fun f () -> self#apply f var li) ()
      self#separator ()

  method separator f () = Format.fprintf f ";"


  method apply f var li = 
    match StringMap.find_opt var macros with
    | Some ( (t, params, code) ) ->
      self#expand_macro_call f var t params code li
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
      Format.fprintf f "@[<hov>%a ++;@]" self#mutable_set m
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
    | Instr.StdinSep -> self#stdin_sep f
    | Instr.Declare (varname, type_, expr, _option) -> self#declaration f varname type_ expr
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
    | Instr.Read (t, mutable_) -> self#read f t mutable_
    | Instr.DeclRead (t, var, _option) -> self#read_decl f t var
    | Instr.Print (t, expr) -> self#print f t expr
    | Instr.Untuple (li, e, _) -> self#untuple f li e

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

  method bool f b = Format.fprintf f (if b then "true" else "false")

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "/"
      | Expr.Mod -> "%"
      | Expr.Or -> "||"
      | Expr.And -> "&&"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | Expr.Eq -> "=="
      | Expr.Diff -> "!="
      )

  method unop f op a =
    let pop f () = match op with
      | Expr.Neg -> Format.fprintf f "-"
      | Expr.Not -> Format.fprintf f "!"
    in if self#nop (Expr.unfix a) then
        Format.fprintf f "%a%a" pop () self#expr a
      else
        Format.fprintf f "%a(%a)" pop () self#expr a

  method nop = function
  | Expr.Lief _ -> true
  | Expr.Access _ -> true
  | Expr.Call (_, _) -> true
  | _ -> false

  method printp f e =
    Format.fprintf f "@[<hov 2>(%a)@]" self#expr e

  method chf op side f x = match (Expr.unfix x) with
  | Expr.BinOp (_, op2, _) ->
    begin match (op, side, op2) with
    | ((Expr.Eq | Expr.Diff | Expr.Lower |
        Expr.LowerEq | Expr.Higher | Expr.HigherEq
    ), _, (Expr.Add | Expr.Mul | Expr.Sub | Expr.Div)) ->
      self#expr f x

    | ((Expr.And | Expr.Or), _, (Expr.Eq | Expr.Diff | Expr.Lower |
        Expr.LowerEq | Expr.Higher | Expr.HigherEq
    )) ->
      self#expr f x
    | ((Expr.Add | Expr.Sub), _, (Expr.Mul | Expr.Div | Expr.Mod))
      ->
      self#expr f x
    | (Expr.Sub, Left, (Expr.Sub | Expr.Add))
      ->
      self#expr f x
    | (Expr.Add, _, Expr.Add)
      ->
      self#expr f x
    | (Expr.Mul, _, Expr.Mul)
      ->
      self#expr f x
    | (Expr.And, _, Expr.And)
      ->
      self#expr f x
    | (Expr.Or, _, Expr.Or)
      ->
      self#expr f x
    | _ ->
      self#printp f x
    end
  | _ -> self#expr f x

  method binop f op a b =
    Format.fprintf f "%a %a@;%a"
      (self#chf op Left) a
      self#print_op op
      (self#chf op Right) b

  method integer f i =
    Format.fprintf f "%i" i

  method lexems f (li : (Parser.token, Utils.expr) Lexems.t list )  =
    Utils.lexems f li

  method lief f = function
    | Expr.Enum e -> self#enum f e
    | Expr.Bool b -> self#bool f b
    | Expr.Integer i -> self#integer f i
    | Expr.String i -> self#string f i
    | Expr.Char (c) -> self#char f c

  method expr f t =
    let t = Expr.unfix t in
    match t with
    | Expr.Lief l -> self#lief f l
    | Expr.Lexems li -> self#lexems f li
    | Expr.UnOp (a, op) -> self#unop f op a
    | Expr.BinOp (a, op, b) -> self#binop f op a b
    | Expr.Access m ->
      self#access f m
    | Expr.Call (funname, li) -> self#apply f funname li
    | Expr.Tuple li -> self#tuple f li
    | Expr.Record li -> self#record f li

  method tuple f li =
    Format.fprintf f "(%a)"
      (print_list self#expr sep_c) li

  method record f li =
    Format.fprintf f "record %a end"
      (self#def_fields (InternalName 0)) li

  method unicode f c =
    let cs = Printf.sprintf "%C" c in
    if String.length cs == 6 then
      Format.fprintf f "'\\u00%02x'" (int_of_char c)
    else
      Format.fprintf f "%s" cs

  method char f c =
    let cs = Printf.sprintf "%C" c in
    if String.length cs == 6 then
      Format.fprintf f "'\\x%02x'" (int_of_char c)
    else
      Format.fprintf f "%s" cs

  method access f m =
    self#mutable_get f m

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

  method multi_print f format exprs =
    Format.fprintf f "@[<v>%a@]"
      (print_list (fun f (t, e) -> self#print f t e) sep_nl ) exprs

  method combine_formats () = false

  method multiread f instrs = (print_list self#instr sep_nl) f instrs

  method is_print i = match Instr.unfix i with
  | Instr.Print _ -> true
  | _ -> false

  method is_stdin i = match Instr.unfix i with
  | Instr.Read _ -> true
  | Instr.DeclRead _ -> true
  | Instr.StdinSep -> true
  | _ -> false

  method formater_type t = format_type t
  method limit_nprint () = 100000

  method instructions0 f instrs =
    if List.for_all self#is_stdin instrs then
      self#multiread f instrs
    else if (match instrs with [_] -> false | _ -> true)
      && List.for_all self#is_print instrs then
      if List.length instrs > self#limit_nprint () then
        print_list self#instructions0 sep_nl f
          (List.pack (self#limit_nprint ()) instrs)
      else
      let li = List.map (fun i -> match Instr.unfix i with
        | Instr.Print (t, i) -> self#formater_type t, (t, i)
        | _ -> assert false
      ) instrs in
      let li =
        if self#combine_formats () then
          List.map ( fun (format, (ty, e)) -> match Expr.unfix e with
          | Expr.Lief (Expr.String s) ->
            let s = self#noformat s in
            (String.sub s 1 ((String.length s) - 2)  , (ty, e))
          | _ -> (format, (ty, e))
          ) li else li in
      let formats, exprs = List.unzip li in
      let rec g acc = function
        | [] -> acc
        | hd::tl -> g (acc ^ hd) tl
      in
      let format = g "" formats in
      let exprs =
        if self#combine_formats () then
          List.filter (fun (ty, e) -> match Expr.unfix e with
          | Expr.Lief (Expr.String _) -> false
          | _ -> true
          ) exprs
        else exprs
      in
      self#multi_print f format exprs
    else (print_list self#instr sep_nl) f instrs

  method instructions f instrs =
    let rec g kind acc1 acc2 = function
      | hd::tl ->
        let kind2 = (self#is_print hd, self#is_stdin hd) in
        if kind2 = kind
        then g kind acc1 (hd::acc2) tl
        else g kind2 ((List.rev acc2)::acc1) [hd] tl
      | [] -> List.rev ( (List.rev acc2) :: acc1 )
    in
    let lili = g (false, false) [] [] instrs in
    let lili = List.filter ( (<>) [] ) lili in
    (print_list self#instructions0 sep_nl) f lili

  method proglist f funs =
    Format.fprintf f "%a" (print_list self#prog_item nosep) funs


  val mutable recursives_definitions = StringSet.empty
  method setRecursive b = recursives_definitions <- b
  method is_rec funname = StringSet.mem funname recursives_definitions

  method main f (main : Utils.instr list) =
    Format.fprintf f "main@\n@[<v 2>  %a@]@\nend"
      self#instructions main
end
