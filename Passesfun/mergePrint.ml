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

open Stdlib
open AstFun

(**
   Passes de transformations sur l'ast fonctionnel
   Cette passe permet de merger plusieurs prints en un seul.
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open AstFun

let combine_prints li =
  let formats, exprs = List.fold_left (fun (formats, exprs) (e, ty) ->
				       match Expr.unfix e with
				       | Expr.Lief (Expr.String s) ->
					  (Expr.StringConstant s) :: formats, exprs
				       | _ -> let f = match Ast.Type.unfix ty with
						| Ast.Type.Integer -> Expr.IntFormat
						| Ast.Type.String -> Expr.StringFormat
						| Ast.Type.Char -> Expr.CharFormat
						| _ -> assert false
					      in  f:: formats, (e, ty) :: exprs
				      ) ([], []) li
  in List.rev formats, List.rev exprs

let rec extract_prints acc = function
  | [] -> List.rev acc, []
  | hd::tl -> match Expr.unfix hd with
	      | Expr.Block li -> extract_prints acc (List.append tl li)
	      | Expr.Print (e, ty) -> extract_prints ((e, ty)::acc) tl
	      | _ -> List.rev acc, hd::tl

let rec merge li =
  if li = [] then [] else
    let prints, li2 = extract_prints [] li in
    match prints with
    | [] | [_] ->
	    begin match li with
		    | hd::tl -> hd::(merge tl)
		    | _ -> li
	    end
    | _ ->
       let formats, lie = combine_prints prints in
       (Expr.multiprint formats lie) :: (merge li2)

let tr e = match Expr.unfix e with
  | Expr.Block li ->
     begin match merge li with
	   | [item] -> item
	   | li -> Expr.block li
     end
  | _ -> e

let apply p =
  let declarations = List.map (function
  | Declaration (name, e) -> Declaration (name, Expr.Fixed.Deep.map tr e)
  | x -> x
  ) p.declarations
  in {p with declarations = declarations }

