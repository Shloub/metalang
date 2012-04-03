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
* @see http://prologin.org
* @author Prologin <info@prologin.org>
* @author Maxime Audouin <coucou747@gmail.com>
*
*)

(*
TODO console
*)
open Stdlib
open Ast
open Printer
open JavaPrinter

class csharpPrinter = object(self)
  inherit javaPrinter as super

  method lang () = "csharp"


  method print_scanner f _ = ()

  method prog f (progname, funs, main) =
    Format.fprintf f
      "using System;@\n@\npublic class %s@\n@[<v 2>{@\n%a@\n%a@\n%a@]@\n}@\n"
      progname
      self#print_scanner main
      self#proglist funs
      self#main main

  method print f t expr =
    Format.fprintf f "@[Console.Write(%a);@]" self#expr expr

  method main f main =
    Format.fprintf f "public static void Main(String[] args)@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#instructions main

  method stdin_sep f = ()

  method read f t m =
    match Type.unfix t with
      | Type.Integer ->
	Format.fprintf f "@[<h>%a = Console.Read();@]"
	  self#mutable_ m
      | Type.Char -> Format.fprintf f "@[<h>%a = Console.ReadKey();@]"
	self#mutable_ m

end

let printer = new csharpPrinter;;

