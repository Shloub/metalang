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

let need_cont e =
  A.Expr.Writer.Deep.exists (fun e -> match A.Expr.unfix e with
  | A.Expr.Call _ -> true
  | _ -> false ) e

let accessmut_nocont m = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> F.Expr.binding varname
  | A.Mutable.Array (m, li) -> assert false (* TODO *)
  | A.Mutable.Dot (mut, field) -> assert false

let rec expr_nocont e =
  match A.Expr.unfix e with
  | A.Expr.UnOp (e, op) -> F.Expr.unop (expr_nocont e) op
  | A.Expr.BinOp (e1, op, e2) ->  F.Expr.binop (expr_nocont e1) op (expr_nocont e2)
  | A.Expr.Lief l -> F.Expr.lief (lief l)
  | A.Expr.Access m -> accessmut_nocont m
  | A.Expr.Call(funname, params) -> assert false
(*   | A.Expr.Tuple li -> F.Expr.tuple (List.map expr li)
  | A.Expr.Record r -> F.Expr.record (List.map (fun (a, b) -> a, expr b) r) *)
  | A.Expr.Lexems _ -> assert false


let rec expr cont e =
  if need_cont e then
    match A.Expr.unfix e with
    | A.Expr.UnOp (e, op) ->
      let f = Fresh.fresh () in
      let cont = F.Expr.fun_ [f] (F.Expr.apply cont [F.Expr.unop (F.Expr.binding f) op])
      in expr cont e
    | A.Expr.BinOp (e1, op, e2) ->
      let f1 = Fresh.fresh () in
      let f2 = Fresh.fresh () in
      let c = F.Expr.fun_ [f1; f2]
        (F.Expr.apply cont [F.Expr.binop (F.Expr.binding f1) op (F.Expr.binding f2)]) in
      let c = expr c e2 in
      expr c e1
    | A.Expr.Lief l -> F.Expr.apply cont [F.Expr.lief (lief l)]
    | A.Expr.Access m -> accessmut cont m
    | A.Expr.Call(funname, params) ->
      let c = F.Expr.apply (F.Expr.binding funname) [cont] in
      List.fold_left expr c params
  (*   | A.Expr.Tuple li -> F.Expr.tuple (List.map expr li)
       | A.Expr.Record r -> F.Expr.record (List.map (fun (a, b) -> a, expr b) r) *)
    | A.Expr.Lexems _ -> assert false
  else F.Expr.apply cont [expr_nocont e]

and accessmut cont m = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> F.Expr.apply cont [F.Expr.binding varname]
  | A.Mutable.Array (m, li) -> assert false (* TODO *)
  | A.Mutable.Dot (mut, field) -> assert false

let affect_mutable cont m e = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> expr cont e
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
      let tl = instrs suite contsuite contreturn (v::env) tl in
      expr (F.Expr.fun_ [v] tl) e

    | A.Instr.DeclRead (t, v, _) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.readin (F.Expr.fun_ [v] tl) t

    | A.Instr.Affect (m, e) ->
      let v = name_of_mutable m in
      let nenv = if List.mem v env then env else v::env in
      let tl = instrs suite contsuite contreturn nenv tl in
      affect_mutable (F.Expr.fun_ [v] tl) m e

    | A.Instr.Return e ->
      begin match contreturn with
      | Some contreturn -> expr contreturn e
      | None -> assert false
      end
    | A.Instr.Call (funname, eli) ->
      let next = instrs suite contsuite contreturn env tl in
      let next = F.Expr.fun_ [] next in (* continuation *)
      let c = F.Expr.apply (F.Expr.binding funname) [next] in
      List.fold_left expr c eli
    | A.Instr.Comment str ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.comment str next
    | A.Instr.If (e, l1, l2) ->
      let next = instrs suite contsuite contreturn env tl in
      let next = F.Expr.fun_ env next in
      let body1 = instrs true next contreturn env l1 in
      let body2 = instrs true next contreturn env l2 in
      let l1: F.Expr.t = F.Expr.fun_ [] body1 in
      let l2: F.Expr.t = F.Expr.fun_ [] body2 in
      let f = Fresh.fresh () in
      let c = F.Expr.fun_ [f] (F.Expr.apply (F.Expr.if_ (F.Expr.binding f) l1 l2) []) in
      expr c e
    | A.Instr.Print (ty, e) ->
      let next = instrs suite contsuite contreturn env tl in
      let f = Fresh.fresh () in
      let c = F.Expr.fun_ [f] (F.Expr.print (F.Expr.binding f) ty next) in
      expr c e
    | A.Instr.StdinSep ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.skipin next

    | A.Instr.While (e, li) ->
      let next = instrs suite contsuite contreturn env tl in
      let next = F.Expr.funtuple env next in
      let returnenv = F.Expr.tuple (List.map F.Expr.binding env) in
      let returnenv_fun = F.Expr.fun_ env returnenv in
      let content = instrs true returnenv_fun contreturn env li in
      let content = F.Expr.funtuple env content in
      let b = Fresh.fresh () in
      let loop = Fresh.fresh () in
      let env2 = Fresh.fresh () in
      let conte = F.Expr.fun_ [b] (F.Expr.if_ (F.Expr.binding b)
                                     (F.Expr.apply (F.Expr.binding loop) [F.Expr.apply content [returnenv]])
                                     (F.Expr.apply next [returnenv])) in
      let e = expr conte e in

      F.Expr.letrecin loop [env2] (F.Expr.apply
                                     (F.Expr.funtuple env e)
                                     [F.Expr.binding env2]
      )
        (F.Expr.apply (F.Expr.binding loop) [returnenv])
        
        


(*
    | A.Instr.Loop (var, from, end_, li) ->
      let body = instrs contreturn contsuite (var::env) li in
      let next = instrs contreturn contsuite env tl in
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
