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

(** Ada Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast
open Printer

let print_expr macros e f p =
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
  let pchar f c = 
    let i = int_of_char c in
    if is_printable_i i then fprintf f "%C" c
    else fprintf f "Character'Val(%d)" i in
  let print_lief prio f = function
    | Char c -> pchar f c
    | Integer i ->
        if i < 0 then parens prio (1000) f "%i" i
        else fprintf f "%i" i
    | String s -> fprintf f "new char_array'( To_C(%a))"
          (string_noprintable pchar true) s
    | Bool true -> fprintf f "TRUE"
    | Bool false -> fprintf f "FALSE"
    | x -> print_lief prio f x in
  let print_unop f op =
    fprintf f (match op with
    | Neg -> "-"
    | Not -> "not ")
  in
  let print_expr0 config e f prio_parent = match e with
  | UnOp (a, Neg) -> fprintf f "(-%a)" a 1
  | Call(funname, []) when not (StringMap.mem funname macros) -> fprintf f "%s" funname
  | _ -> print_expr0 config e f prio_parent
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
  let print_mut conf prio f m = Mutable.Fixed.Deep.fold
      (print_mut0 "%a%a" "(%a)" "%a.%s" conf) m f prio in
  let config = {
    prio_binop;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
  } in Expr.Fixed.Deep.fold (print_expr0 config) e f p

class adaPrinter = object(self)
  inherit PasPrinter.pasPrinter as super

  method expr f e = print_expr
      (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) e f nop

  val mutable progname = ""

  method lang () = "ada"

  method print f t expr =
    match Type.unfix t with
    | Type.Integer -> Format.fprintf f "@[<hov>PInt(%a);@]" self#expr expr
    | Type.Char -> Format.fprintf f "@[<hov>PChar(%a);@]" self#expr expr
    | _ -> Format.fprintf f "@[<hov>PString(%a);@]" self#expr expr

  method comment f s =
    let lic = String.split s '\n' in
    print_list
      (fun f s -> Format.fprintf f "--%s@\n" s) nosep
      f
      lic

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

  method return f e =
    Format.fprintf f "@[<hov>return %a;@]"
      self#expr e

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

  method stdin_sep f =
    Format.fprintf f "@[<hov>SkipSpaces;@]"

  method read f t m = match Type.unfix t with
  | Type.Integer ->
    Format.fprintf f "@[<hov>Get(%a);@]" self#mutable_get m
  | Type.Char ->
    Format.fprintf f "@[<hov>Get(%a);@]" self#mutable_get m
  | _ -> assert false (* type non géré*)

  method read_decl f t v = match Type.unfix t with
  | Type.Integer ->
    Format.fprintf f "@[<hov>Get(%a);@]" self#binding v
  | Type.Char ->
    Format.fprintf f "@[<hov>Get(%a);@]" self#binding v
  | _ -> assert false (* type non géré*)

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

  method call f var li = Format.fprintf f "%a;" (fun f () -> self#apply f var li) ()

  method apply f var li =
    match StringMap.find_opt var macros with
    | Some _ -> super#apply f var li
    | None ->
        if li = [] then Format.fprintf f "%a" self#funname var
        else Format.fprintf f "%a(%a)" self#funname var (print_list self#expr sep_c) li

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<hov>if@ %a@]@\nthen@\n@[<v2>  %a@]@\nend if;"
        self#expr e
        self#instructions ifcase
    | _ ->
      Format.fprintf f "@[<hov>if@ %a@]@\nthen@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]@\nend if;"
        self#expr e
        self#instructions ifcase
        self#instructions elsecase

  method declaredvars bindings instrs =
    List.fold_left
      (Instr.Writer.Deep.fold
         (fun bindings i ->
           match Instr.Fixed.unfix i with
           | Instr.DeclRead (t, b, _)
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
    current_function <- funname;
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

  method instructions f li =
    if
      List.filter (fun i -> match Instr.unfix i with
      | Instr.Comment _ -> false
      | _ -> true) li = [] then (* en ada, un bloc vide ne compile pas...*)
      Format.fprintf f "NULL;@\n"
    else super#instructions f li

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<hov>for@ %a@ in integer range %a..%a loop@\n@]  @[<v>%a@]@\nend loop;"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#instructions li

  method whileloop f expr li =
    Format.fprintf f "@[<hov>while %a loop@]@\n  @[<v>%a@]@\nend loop;"
      self#expr expr
      self#instructions li

  method print_body f instrs =
    Format.fprintf f "%a@\nbegin@\n@[<v 2>  %a@]@\nend;"
      self#declarevars instrs
      self#instructions instrs

  method bloc f li = Format.fprintf f "@[<v 2>begin@\n%a@]@\nend;"
    (print_list self#instr sep_nl) li

  method m_field f m field = super#base_m_field f m field

  method m_array f m indexes =
      Format.fprintf f "%a(%a)"
        self#mutable_get m
        (print_list self#expr (sep "%a)(%a")) indexes

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
        Format.fprintf f "%a.%a := %a;"
          self#binding name
          self#field fieldname
          self#expr expr
      ) sep_nl
      f
      li

  method allocrecord f name t el =
    Format.fprintf f "%a := new %a;@\n%a"
      self#binding name
      self#typename_aux t
      (self#def_fields name) el

  method typename_aux f t = match Type.unfix t with
  | Type.Named n -> Format.fprintf f "%s" n
  | _ -> assert false

  method allocarray f binding type_ len _ =
    match TypeMap.find_opt (Type.array type_) declared_types with
    | Some s -> Format.fprintf f "@[<hov>%a := new %s (0..%a);@]"
      self#binding binding
      (StringMap.find s declared_types_assoc)
      self#expr len
    | None -> Format.fprintf f "(no-type)"

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
