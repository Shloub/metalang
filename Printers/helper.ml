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

(** some utility functions for printers
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

let print_option (f : Format.formatter -> 'a -> unit) t obj =
  match obj with
  | None -> ()
  | Some s -> f t s

let print_list = Printers.print_list

let sep format f pa a pb b = Format.fprintf f format pa a pb b
let nosep f = sep "%a%a" f
let sep_space f = sep "%a %a" f
let sep_nl f = sep "%a@\n%a" f
let sep_c f = sep "%a, %a" f
let sep_cnl f = sep "%a,@\n%a" f
let sep_dc f = sep "%a; %a" f


let print_list_indexed print sep f li =
  print_list
    (fun f (toprint, index) ->
      print f toprint index
    )
    sep
    f
    (snd (List.fold_left_map
            (fun i m -> (i+1), (m, i))
            0
            li
     ))

let print_ntimes n f s =
  for i = 1 to n do
    Format.fprintf f "%s" s
  done

let simple_expression e =
  let f tra acc e = match Ast.Expr.unfix e with
  | Ast.Expr.Access m -> begin match Ast.Mutable.unfix m with
    | Ast.Mutable.Var _ -> acc
    | _ -> false
  end
  | Ast.Expr.Lief l -> acc
  | Ast.Expr.UnOp _
  | Ast.Expr.BinOp _ -> tra acc e
  | _ -> false
  in f (Ast.Expr.Writer.Traverse.fold f) true e

let contains_instr f prog =
    let cli = List.exists (Ast.Instr.Writer.Deep.exists f) in
    Option.map_default false cli prog.Ast.Prog.main ||
    (List.exists (function Ast.Prog.DeclarFun (_, _, _, instrs, _) -> cli instrs | _ -> false)
    prog.Ast.Prog.funs)

