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

(** Objective-C Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Helper
open Stdlib

let rec ptype tyenv f t =
  let open Ast.Type in
  let open Format in match unfix t with
    | Integer -> fprintf f "int"
    | String -> fprintf f "char*"
    | Array a -> fprintf f "%a*" (ptype tyenv) a
    | Void ->  fprintf f "void"
    | Bool -> fprintf f "int"
    | Char -> fprintf f "char"
    | Named n -> begin match Typer.expand tyenv t
        default_location |> Type.unfix with
        | Type.Struct _ -> Format.fprintf f "%s *" n
        | Type.Enum _ -> Format.fprintf f "%s" n
        | _ -> assert false
    end
    | Enum _ | Struct _ | Auto | Lexems | Tuple _ -> assert false

let print_instr0 ptype c i f pend =
  let open Ast.Instr in
  let open Format in
  match i with
  | AllocRecord (name, ty, list, opt) -> fprintf f "%a %a = [%s alloc]%a@\n%a"
        ptype ty
        c.print_varname name
        (match Type.unfix ty with | Type.Named n -> n | _ -> assert false) pend ()
        (CPrinter.def_fields c name) list
  | _ -> CPrinter.print_instr0 ptype c i f pend
      
class objCPrinter = object(self)
  inherit CPrinter.cPrinter as baseprinter
  method lang () = "objc"

  method instr f t =
    let rewrite i = match Instr.unfix i with
      | Instr.ClikeLoop (init, cond, incr, li) ->
          let init = List.map (fun i -> match Instr.unfix i with
          | Instr.Declare (var, ty, e, _) ->
              let mut = Mutable.var var in
              Instr.affect mut e
          | _ -> i) init
          in Instr.ClikeLoop (init, cond, incr, li) |> Instr.fix
      | _ -> i
    in
    let t = Instr.Fixed.Deep.map rewrite t in
  let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc "objc" li
        with Not_found -> List.assoc "" li) macros
   in (CPrinter.print_instr print_instr0 (ptype (baseprinter#getTyperEnv ())) macros t) f
     
  method prog f prog =
    Format.fprintf f "#import <Foundation/Foundation.h>@\n#include<stdio.h>@\n#include<stdlib.h>@\n%a@\n%a%a@\n@\n"
      (fun f () ->
        if Tags.is_taged "use_math"
        then Format.fprintf f "#include<math.h>@\n"
      ) ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method main f main =
    let li_fori, li_forc = self#collect_for main false in
    Format.fprintf f "@[<v 2>int main(void){@\nNSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];@\n%a%a%a@\n[pool drain];@\nreturn 0;@]@\n}"
      (self#declare_for "int") li_fori
      (self#declare_for "char") li_forc
      self#instructions main

  method ptype f t = ptype (baseprinter#getTyperEnv ()) f t

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        Format.fprintf f "@@interface %a : NSObject@\n{@\n@[<v 2>  %a@]@\n}@\n@@end@\n@@implementation %a @\n@@end@\n"
          self#typename name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "@@public %a %a;" self#ptype type_ self#field name
             ) sep_nl
          ) li
          self#typename name
    | Type.Enum li ->
      Format.fprintf f "typedef enum %a {@\n@[<v2>  %a@]@\n} %a;"
        self#typename name
        (print_list
           (fun t name -> Format.fprintf t "%s" name)
           (sep "%a,@\n%a")
        ) li
        self#typename name
    | _ ->
      Format.fprintf f "typedef %a %a;"
        baseprinter#ptype t
        baseprinter#typename name

end
