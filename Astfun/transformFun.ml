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
   Ce module transforme un ast metalang impératif en ast fonctionnel
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

let rec mutable_type tyenv t = match A.Type.unfix t with
  | A.Type.Integer -> false
  | A.Type.String -> false
  | A.Type.Char -> false
  | A.Type.Array _ -> true
  | A.Type.Void -> false
  | A.Type.Bool -> false
  | A.Type.Lexems -> false
  | A.Type.Struct _ -> true
  | A.Type.Enum _ -> false
  | A.Type.Named name -> mutable_type tyenv (Typer.byname name tyenv)
  | A.Type.Tuple li -> List.exists (mutable_type tyenv) li
  | A.Type.Auto -> assert false (* on a besoin d'un truc typế à ce moment de la compilation *)

let rec accessmut m = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> F.Expr.binding varname
  | A.Mutable.Array (m, li) ->
    let m = accessmut m in
    List.fold_left (fun acc i ->
      let e = expr i in
      F.Expr.intmapget e acc
    ) m li
  | A.Mutable.Dot (mut, field) ->
    let mut = accessmut mut in
    F.Expr.recordaccess mut field
and expr e =
  match A.Expr.unfix e with
  | A.Expr.UnOp (e, op) -> F.Expr.unop (expr e) op
  | A.Expr.BinOp (e1, op, e2) ->  F.Expr.binop (expr e1) op (expr e2)
  | A.Expr.Lief l -> F.Expr.lief (lief l)
  | A.Expr.Access m -> accessmut m
  | A.Expr.Call(funname, params) ->
    F.Expr.apply (F.Expr.binding funname) (List.map expr params)
   | A.Expr.Tuple li -> F.Expr.tuple (List.map expr li)
  | A.Expr.Record r -> F.Expr.record (List.map (fun (a, b) -> expr b, a) r)
  | A.Expr.Lexems _ -> assert false

let rec affect_mutable cont m e = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> F.Expr.apply cont [expr e]
  | A.Mutable.Array (mut, []) -> assert false
  | A.Mutable.Array (mut, [item]) ->
    let namemut = Fresh.fresh () in
    let cont = F.Expr.fun_ [namemut]
      (F.Expr.apply cont [F.Expr.intmapadd
			     (expr item)
			     (expr e)
			     (F.Expr.binding namemut)
			 ])
    in
    F.Expr.apply cont [accessmut mut]
  | A.Mutable.Array (mut, hd::tl) -> assert false (* TODO *)
  | A.Mutable.Dot (mut, field) ->
    affect_mutable_f cont mut (F.Expr.recordwith (accessmut mut) (expr e) field)
and affect_mutable_f cont m e = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> F.Expr.apply cont [e]
  | A.Mutable.Array (m, li) -> assert false
  | A.Mutable.Dot (mut, field) -> affect_mutable_f cont mut (F.Expr.recordwith (accessmut mut) e field)

let rec instrs suite contsuite (contreturn:F.Expr.t option) env = function
  | [] ->
    if suite then contsuite
    else begin match contreturn with
    | Some c -> c
    | None -> F.Expr.unit
    end
  | hd::tl -> match A.Instr.unfix hd with
    | A.Instr.Declare (v, ty, e, _) -> (* letin ? *)
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.apply (F.Expr.fun_ [v] tl) [expr e]
    | A.Instr.DeclRead (t, v, _) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.readin (F.Expr.fun_ [v] tl) t
    | A.Instr.AllocRecord (v, ty, li) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.apply (F.Expr.fun_ [v] tl) [F.Expr.record (List.map (fun (a, b) -> expr b, a) li)]
    | A.Instr.Affect (m, e) ->
      let v = name_of_mutable m in
      let nenv = if List.mem v env then env else v::env in
      let tl = instrs suite contsuite contreturn nenv tl in
      affect_mutable (F.Expr.fun_ [v] tl) m e
    | A.Instr.Read (ty, m) ->
      let v = name_of_mutable m in
      let nenv = if List.mem v env then env else v::env in
      let tl = instrs suite contsuite contreturn nenv tl in
      let f = Fresh.fresh () in
      let cont = affect_mutable_f (F.Expr.fun_ [v] tl) m (F.Expr.binding f) in
      F.Expr.readin (F.Expr.fun_ [f] cont) ty
    | A.Instr.Return e ->
      begin match contreturn with
      | Some contreturn -> F.Expr.apply contreturn [expr e]
      | None -> expr e
      end
    | A.Instr.Call (funname, eli) ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.block
	[
	  F.Expr.apply (F.Expr.binding funname) (List.map expr eli);
	  next
	]
    | A.Instr.Comment str ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.comment str next
    | A.Instr.If (e, l1, l2) ->
      let next = instrs suite contsuite contreturn env tl in
      let next = F.Expr.fun_ env next in
      let nextname = Fresh.fresh () in
      let ncont = F.Expr.apply (F.Expr.binding nextname) (List.map F.Expr.binding env) in 
      let body1 = instrs true ncont contreturn env l1 in
      let body2 = instrs true ncont contreturn env l2 in
      F.Expr.apply
	(F.Expr.fun_ [nextname] (F.Expr.if_ (expr e) body1 body2))
	[next]
    | A.Instr.Print (ty, e) ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.print (expr e) ty next
    | A.Instr.StdinSep ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.skipin next
    | A.Instr.While (e, li) ->
      let next = instrs suite contsuite contreturn env tl in
      let b = Fresh.fresh () in
      let loop = Fresh.fresh () in
      let returnenv = List.map F.Expr.binding env in
      let nextLoop = F.Expr.apply (F.Expr.binding loop) returnenv in
      let content = instrs true nextLoop contreturn env li in
      F.Expr.letrecin loop env (F.Expr.if_ (expr e)
				     content
				     next
      )
        (F.Expr.apply (F.Expr.binding loop) returnenv)
    | A.Instr.Loop (var, from_, end_, li) ->
      let var_plus_un = F.Expr.binop (F.Expr.binding var) Ast.Expr.Add (F.Expr.integer 1) in
      let next = instrs suite contsuite  contreturn env tl in
      let loop = Fresh.fresh () in
      let returnenv = List.map F.Expr.binding env in
      let calloop = F.Expr.apply (F.Expr.binding loop) ((var_plus_un)::returnenv) in
      let content = instrs true calloop contreturn env li in
      let from = Fresh.fresh () in
      let to_ = Fresh.fresh () in
      let content = F.Expr.if_ (F.Expr.binop (F.Expr.binding var) Ast.Expr.LowerEq (F.Expr.binding to_) )
        content next in
      let cont = F.Expr.fun_ [from; to_]
        (F.Expr.letrecin loop (var::env) content
           (F.Expr.apply (F.Expr.binding loop) ((F.Expr.binding from)::returnenv))
        ) in
      F.Expr.apply cont [expr from_; expr end_]
    | A.Instr.AllocArray (name, t, e, Some li) -> assert false
    | A.Instr.AllocArray (name, t, e, None) -> (* WARNING : on ignore complètement e... *)
      let tl = instrs suite contsuite contreturn (name::env) tl in
      F.Expr.apply (F.Expr.fun_ [name] tl) [F.Expr.intmapempty]
    | A.Instr.Untuple (vars, e) ->
      let vars = List.map snd vars in
      let tl = instrs suite contsuite contreturn (List.append vars env) tl in
      F.Expr.apply (F.Expr.funtuple vars tl) [expr e]
    | A.Instr.AllocArray (name, t, e, None) -> assert false
    | A.Instr.Tag s -> assert false
    | A.Instr.Unquote e -> assert false

let transform (tyenv, prog) =
  let fonctions = List.filter_map
    (function
    | Ast.Prog.DeclarFun (name, _, params, is, _) ->
      let params = List.map fst params in
      let e = instrs false (F.Expr.unit) None params is in
      Some (F.Declaration (name, F.Expr.fun_ params e))
    | Ast.Prog.DeclareType (typename, ty) ->
      Some (F.DeclareType (typename, ty))
    | _ -> None) prog.Ast.Prog.funs
  in match prog.Ast.Prog.main with
  | None -> fonctions
  | Some m ->
    let main = instrs false (F.Expr.unit) None [] m in
    List.append fonctions [F.Declaration ("main", main)]
