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
open Printer

class cPrinter = object(self)
  inherit printer as baseprinter

  method base_multi_print = baseprinter#multi_print

  method lang () = "c"

  method bool f = function
  | true -> Format.fprintf f "1"
  | false -> Format.fprintf f "0"

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
         )
         (fun t f1 e1 f2 e2 ->
           Format.fprintf t
             "%a@\n%a" f1 e1 f2 e2)
      )
      li

  method allocarray f binding type_ len _ =
    Format.fprintf f "@[<h>%a@ *%a@ =@ malloc(@ %a@ *@ sizeof(%a))%a@]"
      self#ptype type_
      self#binding binding
      (fun f a ->
        if self#nop (Expr.unfix a) then self#expr f a
        else self#printp f a) len
      self#ptype type_
      self#separator ()

  method forloop f varname expr1 expr2 li =
      self#forloop_content f (varname, expr1, expr2, li)

  method forloop_content f (varname, expr1, expr2, li) =
    let default () =
      Format.fprintf f "@[<h>for@ (%a@ =@ %a@ ;@ %a@ <=@ %a;@ %a++)@\n@]%a"
        self#binding varname
        self#expr expr1
        self#binding varname
        self#expr expr2
        self#binding varname
        self#bloc li
    in match Expr.unfix expr2 with
    | Expr.BinOp (expr3, Expr.Sub, Expr.Fixed.F (_, Expr.Lief (Expr.Integer 1))) ->
      Format.fprintf f "@[<h>for@ (%a@ =@ %a@ ;@ %a@ <@ %a;@ %a++)@\n@]%a"
        self#binding varname
        self#expr expr1
        self#binding varname
        self#expr expr3
        self#binding varname
        self#bloc li
    | _ -> default ()

  method main f main =
    let li_fori, li_forc = self#collect_for main in
    Format.fprintf f "@[<v 2>int main(void){@\n%a%a%a@\nreturn 0%a@]@\n}"
      (self#declare_for "int") li_fori
      (self#declare_for "char") li_forc
      self#instructions main
      self#separator ()

  method bloc f li = match li with
  | [ Instr.Fixed.F ( _, ((Instr.AllocRecord _)
                             | (Instr.AllocArray _)
                             | (Instr.DeclRead _)
                             | (Instr.Declare _)
                             | (Instr.Comment _)))
    ] ->
    Format.fprintf f "@[<v 2>{@\n%a@]@\n}" self#instructions li
  | [i] -> Format.fprintf f "  %a" self#instr i
  | _ ->  Format.fprintf f "@[<v 2>{@\n%a@]@\n}" self#instructions li

  method blocinif f li = match li with
  | [ Instr.Fixed.F ( _, ((Instr.AllocRecord _)
                             | (Instr.AllocArray _)
                             | (Instr.DeclRead _)
                             | (Instr.Declare _)
                             | (Instr.Comment _)
                             | (Instr.If (_, _, _) ) (* sans accolades, on a un conflit sur le else *)
  ))
    ] ->
    Format.fprintf f "@[<v 2>{@\n%a@]@\n}" self#instructions li
  | [i] -> Format.fprintf f "  %a" self#instr i
  | _ ->  Format.fprintf f "@[<v 2>{@\n%a@]@\n}" self#instructions li


  method prototype f t = self#ptype f t

  method print_proto f (funname, t, li) =
    Format.fprintf f "%a %a(%a)"
      self#prototype t
      self#funname funname
      (print_list
         (fun t (binding, type_) ->
           Format.fprintf t "%a@ %a"
             self#prototype type_
             self#binding binding
         )
         (fun t f1 e1 f2 e2 -> Format.fprintf t
           "%a,@ %a" f1 e1 f2 e2)
      ) li

  method stdin_sep f = Format.fprintf f "@[scanf(\"%%*[ \\t\\r\\n]c\");@]"

  method mutable_ f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) ->
      Format.fprintf f "%a->%a"
        self#mutable_ m
        self#field field
    | Mutable.Var binding -> self#binding f binding
    | Mutable.Array (m, indexes) ->
      Format.fprintf f "%a[%a]"
        self#mutable_ m
        (print_list
           self#expr
           (fun f f1 e1 f2 e2 ->
             Format.fprintf f "%a][%a" f1 e1 f2 e2
           ))
        indexes

  method read_decl f t v =
    Format.fprintf f "@[scanf(\"%a\", &%a);@]"
      self#format_type t
      self#binding v

  method read f t m =
    Format.fprintf f "@[scanf(\"%a\", &%a);@]" self#format_type t self#mutable_ m

  method printf f () = Format.fprintf f "printf"
  method combine_formats () = true
  method multi_print f format exprs =
    if exprs = [] then
      Format.fprintf f "@[<h>%a(\"%s\")%a@]" self#printf () format self#separator ()
    else
      Format.fprintf f "@[<h>%a(\"%s\", %a)%a@]" self#printf () format
        (print_list
           (fun f (t, e) -> self#expr f e)
           (fun t f1 e1 f2 e2 -> Format.fprintf t "%a,@ %a" f1 e1 f2 e2)) exprs
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
        Format.fprintf f "%atypedef struct %a {@\n@[<v 2>  %a@]@\n} %a%a@\n"
          (fun f b ->
            if b then Format.fprintf f "struct %a%a@\n" self#typename name self#separator ()
          ) b
          self#typename name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "%a %a%a" self#ptype type_ self#field name self#separator ()
             )
             (fun t fa a fb b -> Format.fprintf t "%a@\n%a" fa a fb b)
          ) li
          self#typename name
          self#separator ()
    | Type.Enum li ->
      Format.fprintf f "typedef enum %a {@\n@[<v2>  %a@]@\n} %a%a"
        self#typename name
        (print_list
           (fun t name ->
             self#enum t name
           )
           (fun t fa a fb b -> Format.fprintf t "%a,@\n%a" fa a fb b)
        ) li
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
      | Instr.DeclRead (ty, i, _) ->
        begin match Type.unfix ty with
        | Type.Integer ->  let acci = if List.mem i acci then acci else i::acci in acci, accc
        | Type.Char ->  let accc = if List.mem i accc then accc else i::accc in acci, accc
        | _ -> assert false
        end
      | Instr.Loop (i, _, _, _) -> let acci = if List.mem i acci then acci else i::acci in acci, accc
      | _ -> (acci, accc)
      ) acc i
    in
    List.fold_left collect ([], []) instrs

  method declare_for s f li =
    if li <> [] then
      Format.fprintf f "%s %a%a@\n"
        s
        (print_list self#binding
           (fun f pa a pb b -> Format.fprintf f "%a, %a" pa a pb b)
        ) li
        self#separator ()

  method print_fun f funname t li instrs =
    let li_fori, li_forc = self#collect_for instrs in
    Format.fprintf f "@[<h>%a@]{@\n@[<v 2>  %a%a%a@]@\n}@\n"
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


  method basemultiread f instrs = baseprinter#multiread f instrs

  method multiread f instrs =
    let format, variables =
      List.fold_left (fun (format, variables) i -> match Instr.unfix i with
      | Instr.StdinSep -> (format ^ " ", variables)
      | Instr.DeclRead (t, var, _) ->
        let mutable_ = Mutable.var var in
        let addons = format_type t in
        (format ^ addons, mutable_::variables)
      | Instr.Read (t, mutable_) ->
        let addons = format_type t in
        (format ^ addons, mutable_::variables)
      | _ -> assert false
      ) ("", []) instrs
    in
    Format.fprintf f "scanf(\"%s\"%a);"
      format
      (print_list (fun f x -> Format.fprintf f ", &%a" self#mutable_ x)
         (fun t fa a fb b -> Format.fprintf t "%a%a" fa a fb b))
      (List.rev variables)
end
