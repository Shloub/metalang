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

(** C Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Stdlib
open Helper
let lang = "c"

let print_expr macros e f p =
  let open Format in
  let open Expr in
  let print_lief prio f l = match l with
  | Bool true -> fprintf f "1"
  | Bool false -> fprintf f "0"
  | Char c -> clike_char f c
  | x -> print_lief prio f x in
  let print_mut conf prio f m = Mutable.Fixed.Deep.fold
      (print_mut0 "%a%a" "[%a]" "%a->%s" conf) m f prio in
  let print_expr0 config e f prio_parent = match e with
  | _ -> print_expr0 config e f prio_parent in
  let config = {
    prio_binop = prio_binop_equal;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
  } in Fixed.Deep.fold (print_expr0 config) e f p


class cPrinter = object(self)
  inherit Printer.printer as baseprinter

  method base_multi_print = baseprinter#multi_print

  method lang () = lang

  method expr f e = print_expr (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) e f nop

  method ptype f t =
    match Type.unfix t with
    | Type.Integer -> Format.fprintf f "int"
    | Type.String -> Format.fprintf f "char*"
    | Type.Array a -> Format.fprintf f "%a*" self#ptype a
    | Type.Void ->  Format.fprintf f "void"
    | Type.Bool -> Format.fprintf f "int"
    | Type.Char -> Format.fprintf f "char"
    | Type.Named n -> begin match Typer.expand (baseprinter#getTyperEnv ()) t
        default_location |> Type.unfix with
        | Type.Struct _ ->
          Format.fprintf f "struct %s *" n
        | Type.Enum _ ->
          Format.fprintf f "%s" n
        | _ -> assert false
    end
    | Type.Enum _ -> Format.fprintf f "an enum"
    | Type.Struct _ -> Format.fprintf f "a struct"
    | Type.Auto | Type.Tuple _ | Type.Lexems -> assert false

  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ %a@ =@ %a%a@]"
      self#ptype t
      self#binding var
      self#expr e
      self#separator ()

  method allocrecord f name t el =
    Format.fprintf f "%a %a = malloc (sizeof(%a) )%a@\n%a"
      self#ptype t
      self#binding name
      self#binding name
      self#separator ()
      (self#def_fields name) el

  method def_fields name f li =
    Format.fprintf f "@[<h>%a@]"
      (print_list
         (fun f (fieldname, expr) ->
           Format.fprintf f "%a->%a=%a%a"
             self#binding name
             self#field fieldname
             self#expr expr
             self#separator ()
         ) sep_nl
      )
      li

  method allocarray f binding type_ len _ =
    Format.fprintf f "@[<h>%a@ *%a@ =@ calloc(@ %a@ , sizeof(%a))%a@]"
      self#ptype type_
      self#binding binding
      self#expr len
      self#ptype type_
      self#separator ()

  method forloop f varname expr1 expr2 li =
      self#forloop_content f (varname, expr1, expr2, li)

  method forloop_content f (varname, expr1, expr2, li) =
    let default () =
      Format.fprintf f "@[<h>for@ (%a@ =@ %a;@ %a@ <=@ %a;@ %a++)@\n@]%a"
        self#binding varname
        self#expr expr1
        self#binding varname
        self#expr expr2
        self#binding varname
        self#bloc li
    in match Expr.unfix expr2 with
    | Expr.BinOp (expr3, Expr.Sub, Expr.Fixed.F (_, Expr.Lief (Expr.Integer 1))) ->
      Format.fprintf f "@[<h>for@ (%a@ =@ %a;@ %a@ <@ %a;@ %a++)@\n@]%a"
        self#binding varname
        self#expr expr1
        self#binding varname
        self#expr expr3
        self#binding varname
        self#bloc li
    | _ -> default ()

  method main f main =
    let li_fori, li_forc = self#collect_for main in
    Format.fprintf f "@[<v 4>int main(void) {@\n%a%a%a@\nreturn 0%a@]@\n}"
      (self#declare_for "int") li_fori
      (self#declare_for "char") li_forc
      self#instructions main
      self#separator ()

  method bloc f li = match li with
  | [ Instr.Fixed.F ( _, ((Instr.AllocRecord _)
                             | (Instr.AllocArray _)
                             | (Instr.Read _)
                             | (Instr.Declare _)
                             | (Instr.Comment _)))
    ] ->
    Format.fprintf f "@[<v 4>{@\n%a@]@\n}" self#instructions li
  | [i] -> Format.fprintf f "  %a" self#instr i
  | _ ->  Format.fprintf f "@[<v 4>{@\n%a@]@\n}" self#instructions li

  method blocinif f li = match li with
  | [ Instr.Fixed.F ( _, ((Instr.AllocRecord _)
                             | (Instr.AllocArray _)
                             | (Instr.Read _)
                             | (Instr.Declare _)
                             | (Instr.Comment _)
                             | (Instr.If (_, _, _) ) (* sans accolades, on a un conflit sur le else *)
  ))
    ] ->
    Format.fprintf f "@[<v 4>{@\n%a@]@\n}" self#instructions li
  | [i] -> Format.fprintf f "  %a" self#instr i
  | _ ->  Format.fprintf f "@[<v 4>{@\n%a@]@\n}" self#instructions li


  method prototype f t = self#ptype f t

  method print_proto f (funname, t, li) =
    Format.fprintf f "%a %a(%a)"
      self#ptype t
      self#funname funname
      (print_list
         (fun t (binding, type_) ->
           Format.fprintf t "%a@ %a"
             self#prototype type_
             self#binding binding
         ) sep_c
      ) li

  method stdin_sep f = Format.fprintf f "@[scanf(\"%%*[ \\t\\r\\n]c\");@]"

  method m_field f m field = Format.fprintf f "%a->%a"
      self#mutable_get m
      self#field field

  method read_decl f t v =
    Format.fprintf f "@[scanf(\"%a\", &%a);@]"
      self#format_type t
      self#binding v

  method read f t m =
    Format.fprintf f "@[scanf(\"%a\", &%a);@]" self#format_type t self#mutable_get m

  method printf f () = Format.fprintf f "printf"

  method multi_print f li = let format, exprs = self#extract_multi_print li in
      Format.fprintf f "@[<h>%a(\"%s\", %a)%a@]" self#printf () format
        (print_list
           (fun f (t, e) -> self#expr f e) sep_c ) exprs
        self#separator ()

  method print f t expr = match Expr.unfix expr with
  | Expr.Lief (Expr.String s) -> Format.fprintf f "@[%a(%s)%a@]" self#printf () ( self#noformat s ) self#separator ()
  | _ -> Format.fprintf f "@[%a(\"%a\", %a)%a@]" self#printf () self#format_type t self#expr expr self#separator ()

  method prog f prog =
    Format.fprintf f "#include <stdio.h>@\n#include <stdlib.h>@\n%a@\n%a%a@\n@\n"
      (fun f () ->
        if Tags.is_taged "use_math"
        then Format.fprintf f "#include <math.h>@\n"
      ) ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        let b = List.exists (fun (n, t) -> match Type.unfix t with
          | Type.Named n -> n = name
          | _ -> false) li in
        Format.fprintf f "%atypedef struct %a {@\n@[<v 4>  %a@]@\n} %a%a@\n"
          (fun f b ->
            if b then Format.fprintf f "struct %a%a@\n" self#typename name self#separator ()
          ) b
          self#typename name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "%a %a%a" self#ptype type_ self#field name self#separator ()
             ) sep_nl
          ) li
          self#typename name
          self#separator ()
    | Type.Enum li ->
      Format.fprintf f "typedef enum %a {@\n@[<v2>  %a@]@\n} %a%a"
        self#typename name
        (print_list (fun t name -> Format.fprintf t "%s" name) sep_c) li
        self#typename name
        self#separator ()
    | _ ->
      Format.fprintf f "typedef %a %a%a"
        baseprinter#ptype t
        baseprinter#typename name
        self#separator ()

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
          | _ -> acci, accc ) (acci, accc) li
      | Instr.Loop (i, _, _, _) -> let acci = if List.mem i acci then acci else i::acci in acci, accc
      | _ -> (acci, accc)
      ) acc i
    in
    List.fold_left collect ([], []) instrs

  method declare_for s f li =
    if li <> [] then
      Format.fprintf f "%s %a%a@\n"
        s
        (print_list self#binding sep_c) li
        self#separator ()

  method print_fun f funname t li instrs =
    let li_fori, li_forc = self#collect_for instrs in
    Format.fprintf f "@\n@[<h>%a@] {@\n@[<v 4>    %a%a%a@]@\n}@\n"
      self#print_proto (funname, t, li)
      (self#declare_for "int") li_fori
      (self#declare_for "char") li_forc
      self#instructions instrs

  method return f e =
    Format.fprintf f "@[<h>return@ %a%a@]" self#expr e self#separator ()

  method whileloop f expr li =
    Format.fprintf f "@[<h>while (%a)@]@\n%a"
      self#expr expr
      self#bloc li

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] -> Format.fprintf f "@[<h>if@ (%a)@]@\n%a"
      self#expr e
      self#blocinif ifcase
    | [Instr.Fixed.F ( _, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ (%a)@]@\n%a@\nelse %a"
        self#expr e
        self#blocinif ifcase
        self#instr instr
    | _ -> Format.fprintf f "@[<h>if@ (%a)@]@\n%a@\nelse@\n%a"
      self#expr e
      self#blocinif ifcase
      self#bloc elsecase

  method base_multi_read f li = baseprinter#multi_read f li

  method multi_read f li =
    let format, variables =
      List.fold_left (fun (format, variables) i -> match i with
      | Instr.Separation -> (format ^ " ", variables)
      | Instr.DeclRead (t, var, _) ->
        let mutable_ = Mutable.var var in
        let addons = format_type t in
        (format ^ addons, mutable_::variables)
      | Instr.ReadExpr (t, mutable_) ->
        let addons = format_type t in
        (format ^ addons, mutable_::variables)
      ) ("", []) li
    in
    Format.fprintf f "scanf(\"%s\"%a);"
      format
      (print_list (fun f x -> Format.fprintf f ", &%a" self#mutable_get x) nosep)
      (List.rev variables)

end
