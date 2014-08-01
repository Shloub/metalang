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

(**
   Ce module transforme un ast metalang en ast fonctionnel
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

module F = AstFun
module A = Ast

let rec name_of_mutable m = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> varname
  | A.Mutable.Array (m, _)
  | A.Mutable.Dot (m, _) -> name_of_mutable m

let lief = function
  | A.Expr.Char c -> F.Expr.Char c
  | A.Expr.String s -> F.Expr.String s
  | A.Expr.Integer i -> F.Expr.Integer i
  | A.Expr.Bool b -> F.Expr.Bool b
  | A.Expr.Enum e -> F.Expr.Enum e

let rec expr e = match A.Expr.unfix e with
  | A.Expr.UnOp (e, op) ->
    F.Expr.unop (expr e) op
  | A.Expr.BinOp (e1, op, e2) ->
    F.Expr.binop (expr e1) op (expr e2)
  | A.Expr.Lief l -> F.Expr.lief (lief l)
  | A.Expr.Access m -> accessmut m
  | A.Expr.Call(funname, params) ->
    F.Expr.apply (F.Expr.binding funname) (List.map expr params)
(*   | A.Expr.Tuple li -> F.Expr.tuple (List.map expr li)
  | A.Expr.Record r -> F.Expr.record (List.map (fun (a, b) -> a, expr b) r) *)
  | A.Expr.Lexems _ -> assert false
and accessmut m = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> F.Expr.binding varname
  | A.Mutable.Array (m, li) ->
    let m = accessmut m in
    let li = List.map expr li in
    List.fold_left (fun e param ->
      F.Expr.apply e [param]
    ) m li
  | A.Mutable.Dot (mut, field) -> assert false

let affect_mutable m e = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> e
  | _ -> assert false (* TODO *)

let rec instrs suite contsuite (contreturn:F.Expr.t option) env = function
  | [] ->
    if suite then F.Expr.apply contsuite (List.map F.Expr.binding env)
    else begin match contreturn with
    | Some c -> F.Expr.apply c []
    | None -> F.Expr.unit
    end
  | hd::tl -> match A.Instr.unfix hd with
    | A.Instr.Declare (v, ty, e, _) -> (* letin ? *)
      let e = expr e in
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.apply (F.Expr.fun_ [v] tl) [e]

    | A.Instr.DeclRead (t, v, _) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.readin (F.Expr.fun_ [v] tl) t

    | A.Instr.Affect (m, e) -> 
      let e = expr e in
      let v = name_of_mutable m in
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.apply (F.Expr.fun_ [v] tl) [affect_mutable m e]

    | A.Instr.Return e ->
      begin match contreturn with
      | Some contreturn -> F.Expr.apply contreturn [expr e] (* TODO assert tl is empty *)
      | None -> assert false
      end
    | A.Instr.Call (funname, eli) ->
      let next = instrs suite contsuite contreturn env tl in
      let next = F.Expr.fun_ [] next in (* continuation *)
      F.Expr.apply (F.Expr.binding funname) (next::(List.map expr eli))
    | A.Instr.Comment str ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.comment str next
    | A.Instr.If (e, l1, l2) ->
      let next = instrs suite contsuite contreturn env tl in
      let next = F.Expr.fun_ env next in
      let body1 = instrs true next contreturn env l1 in
      let body2 = instrs true next contreturn env l2 in
      let e: F.Expr.t = expr e in
      let l1: F.Expr.t = F.Expr.fun_ [] body1 in
      let l2: F.Expr.t = F.Expr.fun_ [] body2 in
      F.Expr.apply (F.Expr.if_ e l1 l2) []
    | A.Instr.Print (ty, e) ->
      let next = instrs suite contsuite contreturn env tl in
      let e = expr e in
      F.Expr.print e ty next

    | A.Instr.StdinSep ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.skipin next

(*
    | A.Instr.Loop (var, from, end_, li) ->
      let body = instrs contreturn contsuite (var::env) li in
      let next = instrs contreturn contsuite env tl in
    | A.Instr.While (e, li) ->
    | A.Instr.AllocArray (name, t, e, Some li) ->
    | A.Instr.Read (t, mut) ->
*)

    | A.Instr.AllocRecord (varname, ty, li) -> assert false (* TODO *)
    | A.Instr.Untuple (vars, e) -> assert false (* TODO *)
    | A.Instr.AllocArray (name, t, e, None) -> assert false
    | A.Instr.Tag s -> assert false
    | A.Instr.Unquote e -> assert false

let transform (tyenv, prog) =
  let fonctions = List.filter_map
    (function
    | Ast.Prog.DeclarFun (name, _, params, is, _) ->
      let params = "return" :: (List.map fst params) in
      let e = instrs false (F.Expr.binding "return") (Some (F.Expr.binding "return")) [] is in
      Some (name, F.Expr.fun_ params e)
    | _ -> None) prog.Ast.Prog.funs
  in match prog.Ast.Prog.main with
  | None -> fonctions
  | Some m ->
    let main = instrs false (F.Expr.binding "return") None [] m in
    List.append fonctions ["main", main]
