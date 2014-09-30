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
open Ast
open Printer
open PasPrinter

class adaPrinter = object(self)
  inherit pasPrinter as super

  method binop f op a b = super#baseBinop f op a b


  val mutable progname = ""

  method lang () = "ada"

  method bool f = function
  | true -> Format.fprintf f "TRUE"
  | false -> Format.fprintf f "FALSE"

  method integer f i =
    Format.fprintf f "(%d)" i

  method is_printable_i i = i > 10 && i < 128
  method is_printable c = self#is_printable_i (int_of_char c)

  method unop f op a =
    Format.fprintf f "(%a)" (fun f () -> super#unop f op a) ()

  method char (f:Format.formatter) (c:char) =
    let i = int_of_char c in
    if self#is_printable_i i then Format.fprintf f "%C" c
    else Format.fprintf f "Character'Val(%d)" i

  method string f s =
    let li = Array.to_list @$ String.chararray s in
    Format.fprintf f "\"%a\""
      (Printer.print_list
	 (fun f c ->
	   if self#is_printable c && c != '"' then
	     Format.fprintf f "%c" c
	   else Format.fprintf f "\" & %a & \"" self#char c
	 )
	 (fun f pa a pb b -> Format.fprintf f "%a%a" pa a pb b)
    ) li

  method print f t expr =
    match Type.unfix t with
    | Type.Integer -> Format.fprintf f "@[<h>Put(%a,0);@]" self#expr expr
    | _ -> Format.fprintf f "@[<h>Put(%a);@]" self#expr expr

  method comment f s =
    let lic = String.split s '\n' in
    Printer.print_list
      (fun f s -> Format.fprintf f "--%s@\n" s)
      (fun f pa a pb b -> Format.fprintf f "%a%a" pa a pb b)
      f
      lic

  method decl_procedure f funname li =
    Format.fprintf f "@[<h>procedure %a%a is@]"
      self#funname funname
      (fun f li -> match li with
      | [] -> ()
      | _ -> Format.fprintf f "(%a)"
	(print_list
           (fun t (binding, type_) ->
             Format.fprintf t "%a : in %a"
               self#binding binding
               self#ptype type_
           )
           (fun t f1 e1 f2 e2 -> Format.fprintf t
             "%a;@ %a" f1 e1 f2 e2)
	) li) li

  method return f e =
    Format.fprintf f "@[<h>return %a;@]"
      self#expr e

  method decl_function f funname t li =
      Format.fprintf f "@[<h>function %a(%a) return %a is@]"
        self#funname funname
        (print_list
           (fun t (binding, type_) ->
             Format.fprintf t "%a : in %a"
               self#binding binding
               self#ptype type_
           )
           (fun t f1 e1 f2 e2 -> Format.fprintf t
             "%a;@ %a" f1 e1 f2 e2)
        ) li
        self#ptype t

  method stdin_sep f =
    Format.fprintf f "@[<h>SkipSpaces;@]"

  method read f t m = match Type.unfix t with
  | Type.Integer ->
    Format.fprintf f "@[<h>Get(%a);@]" self#mutable_ m
  | Type.Char ->
    Format.fprintf f "@[<h>Get(%a);@]" self#mutable_ m
  | _ -> assert false (* type non géré*)

  method read_decl f t v = match Type.unfix t with
  | Type.Integer ->
    Format.fprintf f "@[<h>Get(%a);@]" self#binding v
  | Type.Char ->
    Format.fprintf f "@[<h>Get(%a);@]" self#binding v
  | _ -> assert false (* type non géré*)

  method prog f prog =
    Format.fprintf f "with ada.text_io, ada.Integer_text_IO;@\nuse ada.text_io, ada.Integer_text_IO;@\n@\n%a
  procedure SkipSpaces is
     C : Character;
     Eol : Boolean;
  begin
     loop
	Look_Ahead(C, Eol);
	exit when Eol or C /= ' ';
        Get(C);
     end loop;
  end;
%a%a"
      (fun f () -> self#decl_procedure f prog.Prog.progname [] ) ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

 method apply f var li =
    match BindingMap.find_opt var macros with
    | Some ( (t, params, code) ) ->
      self#expand_macro_apply f var t params code li
    | None ->
      if li = [] then
	Format.fprintf f "%a" self#funname var
      else
	Format.fprintf
          f
          "%a(%a)"
          self#funname var
          (print_list
             self#expr
             (fun t f1 e1 f2 e2 ->
               Format.fprintf t "%a,@ %a" f1 e1 f2 e2
             )
          ) li

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<h>if@ %a@]@\nthen@\n@[<v2>  %a@]@\nend if;"
        self#expr e
        self#instructions ifcase
    | _ ->
      Format.fprintf f "@[<h>if@ %a@]@\nthen@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]@\nend if;"
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
           | Instr.AllocArray (b, t, _, _) ->
             BindingMap.add b (Type.array t) bindings
           | Instr.AllocRecord (b, t, _) ->
             BindingMap.add b t bindings
           | _ -> bindings
         )
      )
      bindings
      instrs

  method print_fun f funname t li instrs =
    let () = current_function <- funname in
    
    declared_types <- self#declare_type declared_types f t;
    self#declare_types f instrs;
    declared_types <- List.fold_left (fun declared_types(_, t) -> self#declare_type declared_types f t) declared_types li;
    Format.fprintf f "%a%a@\n"
      self#print_proto (funname, t, li)
      self#print_body instrs

  method declarevars f instrs =
    let bindings = self#declaredvars BindingMap.empty instrs
    in
    if bindings = BindingMap.empty then ()
    else
      Format.fprintf f "@\n@[<v 2>%a@]"
        (BindingMap.fold
           (fun key value next f () ->
             Format.fprintf f "%a@\n%a : %a;"
               next ()
               self#binding key
               self#ptype value
           )
           bindings
           (fun f () -> ())
        )
        ();

  val mutable declared_types_assoc = StringMap.empty

  method declare_type declared_types f t =
    match Type.unfix t with
    | Type.Array _ ->
      begin
        match TypeMap.find_opt t declared_types with
        | Some _ -> declared_types
        | None ->
          let name : string = Fresh.fresh () in
	  let name2 = name ^ "_PTR" in
	  declared_types_assoc <- StringMap.add name2 name declared_types_assoc ;
          Format.fprintf f "type %s is %a;@\ntype %s is access %s;@\n" name self#ptype t name2 name;
	  TypeMap.add t name2 declared_types
      end
    | _ -> declared_types

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ %a@ in integer range %a..%a loop@\n@]  @[<v>%a@]@\nend loop;"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#instructions li

  method whileloop f expr li =
    Format.fprintf f "@[<h>while %a loop@]@\n  @[<v>%a@]@\nend loop;"
      self#expr expr
      self#instructions li

  method print_body f instrs =
    Format.fprintf f "%a@\nbegin@\n@[<v 2>  %a@]@\nend;"
      self#declarevars instrs
      self#instructions instrs

  method bloc f li = Format.fprintf f "@[<v 2>begin@\n%a@]@\nend;"
    (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
      "%a@\n%a" f1 e1 f2 e2)) li

  method mutable_ f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) ->
      Format.fprintf f "%a^.%a"
        self#mutable_ m
        self#field field
    | Mutable.Var binding -> self#binding f binding
    | Mutable.Array (m, indexes) ->
      Format.fprintf f "%a(%a)"
        self#mutable_ m
        (print_list
           self#expr
           (fun f f1 e1 f2 e2 ->
             Format.fprintf f "%a)(%a" f1 e1 f2 e2
           ))
        indexes

  method allocarray f binding type_ len =
    let s = TypeMap.find (Type.array type_) declared_types in
    Format.fprintf f "@[<h>%a := new %s (0..%a);@]"
      self#binding binding
      (StringMap.find s declared_types_assoc)
      self#expr len

  method ptype f t =
    match TypeMap.find_opt t declared_types with
    | Some s -> Format.fprintf f "%s" s
    | None ->
      match Type.unfix t with
      | Type.Integer -> Format.fprintf f "Integer"
      | Type.String -> Format.fprintf f "String"
      | Type.Array a -> Format.fprintf f "Array (Integer range <>) of %a" self#ptype a
      | Type.Void -> assert false
      | Type.Bool -> Format.fprintf f "Boolean"
      | Type.Char -> Format.fprintf f "Character"
      | Type.Named n -> Format.fprintf f "%s" n
      | Type.Struct li -> Format.fprintf f "a struct"
      | Type.Enum _ -> Format.fprintf f "an enum"
      | Type.Lexems | Type.Auto -> assert false

end
