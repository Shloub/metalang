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

(** Cette passe compte le nombre de constructions qui n'ont pas de position attachée. Elle est utile pour débuguer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

type acc0 = unit
type 'a acc = int

let init_acc () = 0

let ftype acc e =
  let acc = if Ast.PosMap.mem (Type.Fixed.annot e) then acc
    else acc + 1
  in acc

let count_type e = ftype (Type.Writer.Deep.fold ftype 0 e) e

let rec fmut acc e =
  let acc = if Ast.PosMap.mem (Mutable.Fixed.annot e) then acc
    else acc + 1
  in match Mutable.unfix e with
  | Mutable.Array (_, li) -> acc + count_exprs li
  | _ -> acc

and count_mut e = fmut (Mutable.Writer.Deep.fold fmut 0 e) e

and fexpr acc e =
  let acc = if Ast.PosMap.mem (Expr.Fixed.annot e) then acc
    else acc + 1
  in match Expr.unfix e with
  | Expr.Access mut -> acc + count_mut mut
  | _ -> acc

and count_expr e = fexpr (Expr.Writer.Deep.fold fexpr 0 e) e
and count_exprs e = List.fold_left (fun acc e -> acc + count_expr e) 0 e

let count_tys e = List.fold_left (fun acc e -> acc + count_type e) 0 e


let finstr acc (i: 'a Ast.Instr.t) =
  let acc = if Ast.PosMap.mem (Instr.Fixed.annot i) then acc
    else acc + 1
  in match Instr.unfix i with
  | Instr.Tag _ | Instr.Comment _ -> acc
  | Instr.Declare (_, t, e, _) -> acc + count_type t + count_expr e
  | Instr.Affect (m, e) -> acc + count_expr e + count_mut m
  | Instr.Loop (_, e1, e2, _) -> acc + count_expr e1 + count_expr e2
  | Instr.While (e, _) -> acc + count_expr e
  | Instr.Return e -> acc + count_expr e
  | Instr.AllocArray (_, t, e, _, _) -> acc + count_type t + count_expr e
  | Instr.AllocArrayConst (_, t, e, _, _) -> acc + count_type t + count_expr e
  | Instr.AllocRecord (_, t, li, _) -> acc + count_type t + count_exprs (List.map snd li)
  | Instr.If (e, _, _) -> acc + count_expr e
  | Instr.Call (_, li) ->acc + count_exprs li
  | Instr.Print (t, e) -> acc + count_type t + count_expr e
  | Instr.Read (t, e) -> acc + count_type t + count_mut e
  | Instr.DeclRead (t, _, _) -> acc + count_type t
  | Instr.StdinSep -> acc
  | Instr.Unquote e -> acc + count_expr e
  | Instr.Untuple (vars, e, _) -> acc + count_expr e

let count (li: 'a Ast.Expr.t Ast.Instr.t list) =
  List.fold_left
    (fun acc i ->
      finstr (Instr.Writer.Deep.fold finstr acc i) i
    ) 0 li

let process acc p =
  match p with
  | Prog.DeclarFun (funname, t, params, instrs, opt) ->
    (acc + count instrs +
       count_type t +
       count_tys (List.map snd params)
    ), Prog.DeclarFun (funname, t, params, instrs, opt)
  | _ -> acc, p

let process_main acc m = acc + count m, m
