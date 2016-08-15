(*
 * Copyright (c) 2012 - 2016, Prologin
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

(** Ada Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast
open Printer

let print_lief prio f =
  let open Expr in
  let open Format in
  let pchar f c = 
    let i = int_of_char c in
    if is_printable_i i then fprintf f "%C" c
    else fprintf f "Character'Val(%d)" i in
  function
  | Char c -> pchar f c
  | Integer i ->
    if i < 0 then parens prio (1000) f "%i" i
    else fprintf f "%i" i
  | String s -> fprintf f "new char_array'( To_C(%a))"
                  (string_noprintable pchar true) s
  | Bool true -> fprintf f "TRUE"
  | Bool false -> fprintf f "FALSE"
  | x -> print_lief prio f x

let print_mut conf prio f m = Mutable.Fixed.Deep.fold
    (print_mut0 "%a%a" "(%a)" "%a.%s" conf) m f prio

let config macros =
  let open Format in
  let open Expr in
  let prio_binop op = match op with
    | Mul -> assoc 5
    | Div
    | Mod -> nonassocr 7
    | Add -> assoc 9
    | Sub -> nonassocr 9
    | Lower
    | LowerEq
    | Higher
    | HigherEq
    | Eq
    | Diff -> nonassoclr 11 (* pour éviter l'erreur : unexpected relational operator *)
    | And
    | Or -> nonassoclr 15
  in
  let print_unop f op =
    fprintf f (match op with
        | Neg -> "-"
        | Not -> "not ")
  in
  let print_op f op = fprintf f (match op with
      | Add -> "+"
      | Sub -> "-"
      | Mul -> "*"
      | Div -> "/"
      | Mod -> "rem"
      | Or -> "or else"
      | And -> "and then"
      | Lower -> "<"
      | LowerEq -> "<="
      | Higher -> ">"
      | HigherEq -> ">="
      | Eq -> "="
      | Diff -> "/=") in
  {
    prio_binop;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
  }

let print_expr macros e f p =
  let open Format in
  let open Expr in
  let config = config macros in
  let print_expr0 config e f prio_parent = match e with
    | UnOp (a, Neg) -> fprintf f "(-%a)" a 1
    | Call(funname, []) when not (StringMap.mem funname macros) -> fprintf f "%s" funname
    | _ -> print_expr0 config e f prio_parent
  in Expr.Fixed.Deep.fold (print_expr0 config) e f p

let print_instr macros declared_types declared_types_assoc i =
  let open Ast.Instr in
  let open Format in
  let config = config macros in
  let instructions f li =
    if
      List.filter (fun i -> not i.is_comment) li = [] then (* en ada, un bloc vide ne compile pas...*)
      fprintf f "NULL;@\n"
    else
      (print_list (fun f i -> i.p f ()) sep_nl) f li in
  let def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
         Format.fprintf f "%a.%s := %a;"
           print_varname name
           fieldname
           expr nop
      ) sep_nl f li in
  let typename_aux f t = match Type.unfix t with
    | Type.Named n -> fprintf f "%s" n
    | _ -> assert false in
  let print f t expr =
    match Type.unfix t with
    | Type.Integer -> Format.fprintf f "@[<hov>PInt(%a);@]" expr nop
    | Type.Char -> Format.fprintf f "@[<hov>PChar(%a);@]" expr nop
    | _ -> Format.fprintf f "@[<hov>PString(%a);@]" expr nop in
  let p f () =
    match i with
      Tag _ | Untuple _ | SelfAffect _
    | Unquote _-> assert false
    | Declare (var, _, expr, _) ->
      fprintf f "@[<h>%a@ :=@ %a;@]" print_varname var expr nop
    | Affect (mutable_, expr) ->
      fprintf f "@[<h>%a@ :=@ %a;@]" (config.print_mut config nop) mutable_ expr nop
    | ClikeLoop (init, cond, incr, li) -> assert false
    | Loop (varname, expr1, expr2, li) ->
      fprintf f "@[<hov>for@ %a@ in integer range %a..%a loop@\n@]  @[<v>%a@]@\nend loop;"
        print_varname varname expr1 nop expr2 nop instructions li
    | While (expr, li) ->
      fprintf f "@[<hov>while %a loop@]@\n  @[<v>%a@]@\nend loop;" expr nop instructions li
    | Comment s -> 
      let lic = String.split s '\n' in
      print_list (fun f s -> Format.fprintf f "--%s@\n" s) nosep f lic
    | Return e -> fprintf f "@[<hov>return %a;@]" e nop
    | AllocRecord (name, t, el, _) ->
      fprintf f "%a := new %a;@\n%a"
        print_varname name typename_aux t (def_fields name) el
    | AllocArray (binding, type_, len, None, u) ->
      begin match TypeMap.find_opt (Type.array type_) declared_types with
        | Some s -> fprintf f "@[<hov>%a := new %s (0..%a);@]"
                      print_varname binding (StringMap.find s declared_types_assoc) len nop
        | None -> fprintf f "(no-type)"
      end
    | AllocArray (binding, type_, len, Some ( (b, l) ), u) -> assert false
    | AllocArrayConst (b, t, len, e, opt) -> assert false
    | If (e, ifcase, elsecase) -> begin match elsecase with
        | [] -> fprintf f "@[<hov>if@ %a@]@\nthen@\n@[<v2>  %a@]@\nend if;"
                  e nop instructions ifcase
        | _ ->
          fprintf f "@[<hov>if@ %a@]@\nthen@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]@\nend if;"
            e nop instructions ifcase instructions elsecase
      end
    | Call (var, li) -> begin match StringMap.find_opt var macros with
        | Some ( (t, params, code) ) -> pmacros f "%s;" t params code li nop
        | None ->
          if li = [] then fprintf f "%s;" var
          else fprintf f "%s(%a);" var (print_list (fun f expr -> expr f nop) sep_c) li
      end
    | Read li ->
      let li = List.map (function
          | Separation -> fun f -> fprintf f "@[<hov>SkipSpaces;@]"
          | DeclRead (t, var, _option) -> fun f -> fprintf f "@[<hov>Get(%a);@]" print_varname var
          | ReadExpr (t, m) -> fun f -> fprintf f "@[<hov>Get(%a);@]" (config.print_mut config nop) m) li
      in print_list (fun f e -> e f) sep_nl f li
    | Print li ->
      let li = List.map (function
          | StringConst str -> fun f -> print f Type.string (fun f prio -> config.print_lief prio f (Expr.String str))
          | PrintExpr (t, expr) -> fun f -> print f t expr ) li
      in print_list (fun f e -> e f) sep_nl f li      
  in
  {
    is_multi_instr = false;
    is_if=is_if i;
    is_if_noelse=is_if_noelse i;
    is_comment=is_comment i;
    p=p;
    default=();
    print_lief = print_lief;
  }

let print_instr macros declared_types declared_types_assoc i =
  let open Ast.Instr.Fixed.Deep in
  fold (print_instr macros declared_types declared_types_assoc) (mapg (print_expr macros) i)

class adaPrinter = object(self)
  inherit PasPrinter.pasPrinter as super

  val mutable progname = ""

  method lang () = "ada"
  method comment f s =
    let lic = String.split s '\n' in
    print_list
      (fun f s -> Format.fprintf f "--%s@\n" s) nosep
      f lic
  method decl_procedure f funname li =
    Format.fprintf f "@[<hov>procedure %a%a is@]"
      self#funname funname
      (fun f li -> match li with
         | [] -> ()
         | _ -> Format.fprintf f "(%a)"
                  (print_list
                     (fun t (binding, type_) ->
                        Format.fprintf t "%a : in %a"
                          self#binding binding
                          self#ptype type_
                     ) sep_dc
                  ) li) li

  method decl_function f funname t li =
    match li with
    | [] ->
      Format.fprintf f "@[<hov>function %a return %a is@]"
        self#funname funname
        self#ptype t
    | _ ->
      Format.fprintf f "@[<hov>function %a(%a) return %a is@]"
        self#funname funname
        (print_list
           (fun t (binding, type_) ->
              Format.fprintf t "%a : in %a"
                self#binding binding
                self#ptype type_
           ) sep_dc
        ) li
        self#ptype t

  method prog f prog =
    let contains t0 =
      contains_instr (fun i -> match Instr.unfix i with
          | Instr.Print li ->
            List.exists (function
                | Instr.StringConst _ -> t0 = Type.String
                | Instr.PrintExpr(t, _) -> Type.unfix t = t0) li
          | _ -> false) prog
    in
    Format.fprintf f "
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;
%a%a@\n

type stringptr is access all char_array;
%a%a%a%a%a%a"
      (fun f () -> if Tags.is_taged "use_math"
        then Format.fprintf f "with Ada.Numerics.Elementary_Functions;@\n") ()
      (fun f () -> self#decl_procedure f prog.Prog.progname [] ) ()
      (fun f () -> if contains Type.String then
          Format.fprintf f "procedure PString(s : stringptr) is
begin
  String'Write (Text_Streams.Stream (Current_Output), To_Ada(s.all));
end;
") ()
      (fun f () -> if contains Type.Char then
          Format.fprintf f "procedure PChar(c : in Character) is
begin
  Character'Write (Text_Streams.Stream (Current_Output), c);
end;
") ()
      (fun f () -> if contains Type.Integer then
          Format.fprintf f "procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;
") ()


      (fun f () ->
         if prog.Prog.hasSkip then
           Format.fprintf f "@[<v>procedure SkipSpaces is@\n  @[<v>C : Character;@\nEol : Boolean;@]@\nbegin@\n  @[<v>loop@\n  @[<v>Look_Ahead(C, Eol);@\nexit when Eol or C /= ' ';@\nGet(C);@]@\nend loop;@]@\nend;@]@\n"
      ) ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method declaredvars bindings instrs =
    List.fold_left
      (Instr.Writer.Deep.fold
         (fun bindings i ->
            match Instr.Fixed.unfix i with
            | Instr.Read li -> List.fold_left (fun bindings -> function
                | Instr.DeclRead (t, b, _) -> BindingMap.add b t bindings
                | _ -> bindings ) bindings li
            | Instr.Declare (b, t, _, _) ->
              BindingMap.add b t bindings
            | Instr.AllocArray (b, t, _, _, _) ->
              BindingMap.add b (Type.array t) bindings
            | Instr.AllocRecord (b, t, _, _) ->
              BindingMap.add b t bindings
            | _ -> bindings
         )
      )
      bindings
      instrs

  val mutable addondeclaredvars = BindingMap.empty

  method print_fun f funname t li instrs =
    let affected = List.fold_left
        (Instr.Writer.Deep.fold
           (fun acc i ->
              match Instr.unfix i with
              | Instr.Read li ->
                List.fold_left (fun acc -> function
                    | Instr.ReadExpr (_, Mutable.Fixed.F (_, Mutable.Var varname)) -> BindingSet.add varname acc
                    | _ -> acc ) acc li
              | Instr.Affect (Mutable.Fixed.F (_, Mutable.Var varname), _) -> BindingSet.add varname acc
              | _ -> acc
           ))
        BindingSet.empty
        instrs
    in
    let li_assoc, li = List.unzip @$ List.map
                         (fun (name, t) ->
                            if BindingSet.mem name affected then
                              let name2 = UserName (Fresh.fresh_user ()) in
                              Some (name, t, name2), (name2, t)
                            else None, (name, t) ) li
    in
    let li_assoc = List.filter_map (fun x -> x) li_assoc in
    addondeclaredvars <- List.fold_left (fun acc (name, t, _) -> BindingMap.add name t acc) BindingMap.empty li_assoc;
    declared_types <- self#declare_type declared_types f t;
    self#declare_types f instrs;
    declared_types <- List.fold_left (fun declared_types(_, t) -> self#declare_type declared_types f t) declared_types li;

    let instrs = List.append
        (List.map (fun (name, t, name2) ->
             Instr.declare name t (Expr.access (Mutable.var name2)) Instr.default_declaration_option
           ) li_assoc)
        instrs
    in
    Format.fprintf f "%a%a@\n"
      self#print_proto (funname, t, li)
      self#print_body instrs

  method declarevars f instrs =
    let bindings = self#declaredvars addondeclaredvars instrs in
    if bindings = BindingMap.empty then ()
    else
      let li = BindingMap.fold
          (fun key value acc ->
             (fun f () ->
                Format.fprintf f "%a : %a;"
                  self#binding key
                  self#ptype value) :: acc
          )
          bindings
          []
      in Format.fprintf f "@\n  @[<v>%a@]" (print_list (fun p f -> f p ()) sep_nl) li;

  val mutable declared_types_assoc = StringMap.empty

  method decl_type f name t =
    declared_types <- self#declare_type declared_types f t;
    match (Type.unfix t) with
      Type.Struct li ->
      let name2 = name ^ "_PTR" in
      Format.fprintf f "@\ntype %a;@\ntype %a is access %a;@\ntype %a is record@\n@[<v 2>  %a@]@\nend record;@]@\n"
        self#typename name
        self#typename name2
        self#typename name
        self#typename name
        (print_list
           (fun t (name, type_) ->
              Format.fprintf t "%a : %a;" self#field name self#ptype type_
           ) sep_nl
        ) li;

    | Type.Enum li ->
      Format.fprintf f "Type %a is (@\n@[<v2>  %a@]);@\n"
        self#typename name
        (print_list (fun f s -> Format.fprintf f "%s" s) (sep "%a,@\n %a")) li
    | _ ->
      Format.fprintf f "type %a = %a;"
        super#ptype t
        super#typename name

  method declare_type declared_types f t =
    Type.Fixed.Deep.fold_acc (fun declared_types t -> self#declare_type0 declared_types f t) declared_types t

  method settypes d = declared_types <- d

  method declare_type0 declared_types f t =
    match Type.unfix t with
    | Type.Array _ ->
      begin
        match TypeMap.find_opt t declared_types with
        | Some _ -> declared_types
        | None ->
          let name : string = Fresh.fresh_user () in
          let name2 = name ^ "_PTR" in
          self#settypes declared_types; (* hack pour informer ptype de la nouvelle map. *)
          Format.fprintf f "type %s is %a;@\ntype %s is access %s;@\n"
            name self#ptype t name2 name;
          declared_types_assoc <- StringMap.add name2 name declared_types_assoc ;
          TypeMap.add t name2 declared_types
      end
    | _ -> declared_types

  method instr f t =
    let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros
    in (print_instr macros declared_types declared_types_assoc t).p f ()

  method instructions f li =
    if
      List.filter (fun i -> match Instr.unfix i with
          | Instr.Comment _ -> false
          | _ -> true) li = [] then (* en ada, un bloc vide ne compile pas...*)
      Format.fprintf f "NULL;@\n"
    else super#instructions f li

  method print_body f instrs =
    Format.fprintf f "%a@\nbegin@\n@[<v 2>  %a@]@\nend;"
      self#declarevars instrs
      self#instructions instrs

  method ptype f t =
    match TypeMap.find_opt t declared_types with
    | Some s -> Format.fprintf f "%s" s
    | None ->
      match Type.unfix t with
      | Type.Integer -> Format.fprintf f "Integer"
      | Type.String -> Format.fprintf f "stringptr"
      | Type.Array a -> Format.fprintf f "Array (Integer range <>) of %a" self#ptype a
      | Type.Void -> assert false
      | Type.Bool -> Format.fprintf f "Boolean"
      | Type.Char -> Format.fprintf f "Character"
      | Type.Named n ->
        begin match Typer.byname n (super#getTyperEnv ()) |> Type.unfix with
          | Type.Enum _ -> Format.fprintf f "%s" n
          | Type.Struct _ -> Format.fprintf f "%s_PTR" n
          | _ -> assert false
        end
      | Type.Struct li -> Format.fprintf f "a struct"
      | Type.Enum _ -> Format.fprintf f "an enum"
      | Type.Tuple _ | Type.Lexems | Type.Auto -> assert false
end
