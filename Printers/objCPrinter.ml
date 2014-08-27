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
open Stdlib
open Printer
open CPrinter

class objCPrinter = object(self)
  inherit cPrinter as baseprinter

  method lang () = "objc"

  method prog f prog =
    Format.fprintf f "#import <Foundation/Foundation.h>@\n#include<stdio.h>@\n#include<stdlib.h>@\n%a@\n%a%a@\n@\n"
      (fun f () ->
        if Tags.is_taged "use_math"
        then Format.fprintf f "#include<math.h>@\n"
      ) ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method main f main =
    let li_fori, li_forc = self#collect_for main in
    Format.fprintf f "@[<v 2>int main(void){@\nNSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];@\n%a%a%a@\n[pool drain];@\nreturn 0;@]@\n}"
      (self#declare_for "int") li_fori
      (self#declare_for "char") li_forc
      self#instructions main

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
        | Type.Struct _ -> Format.fprintf f "%s *" n
        | Type.Enum _ -> Format.fprintf f "%s" n
        | _ -> assert false
    end
    | Type.Enum _ -> Format.fprintf f "an enum"
    | Type.Struct _ -> Format.fprintf f "a struct"
    | Type.Auto -> assert false
    | Type.Lexems -> assert false

  method allocrecord f name t el =
    Format.fprintf f "%a %a = [%s alloc];@\n%a"
      self#ptype t
      self#binding name
      (match Type.unfix t with | Type.Named n -> n | _ -> assert false)
      (self#def_fields name) el

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        Format.fprintf f "@@interface %a : NSObject@\n{@\n@[<v 2>  %a@]@\n}@\n@@end@\n@@implementation %a @\n@@end@\n"
          self#binding name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "@@public %a %a;" self#ptype type_ self#binding name
             )
             (fun t fa a fb b -> Format.fprintf t "%a@\n%a" fa a fb b)
          ) li
          self#binding name
    | Type.Enum li ->
      Format.fprintf f "typedef enum %a {@\n@[<v2>  %a@]@\n} %a;"
        self#binding name
        (print_list
           (fun t name ->
             self#binding t name
           )
           (fun t fa a fb b -> Format.fprintf t "%a,@\n%a" fa a fb b)
        ) li
        self#binding name
    | _ ->
      Format.fprintf f "typedef %a %a;"
        baseprinter#ptype t
        baseprinter#binding name

end
