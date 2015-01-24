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
   On concerve les effets de bords sur les records et les arrays.
   Aucune technique ne permet de se passer de ces effets de bords sans pourrir le code.
   Par contre, on supprime les références et les returns.
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

module F = AstFun
module A = Ast

let may_return i =
  let f tra acc i =
    match A.Instr.unfix i with
    | A.Instr.Return i -> true
    | A.Instr.AllocArray _ -> acc
    | _ -> tra acc i
  in f (A.Instr.Writer.Traverse.fold f) false i
let bad_return li = List.exists may_return li

let rec name_of_mutable m = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> Some varname
  | A.Mutable.Array (m, _)
  | A.Mutable.Dot (m, _) -> None

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

let rec accessmut (m:F.Expr.t A.Mutable.t) : F.Expr.t = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> F.Expr.binding varname
  | A.Mutable.Array (m, li) ->
    F.Expr.arrayaccess (accessmut m) li
  | A.Mutable.Dot (mut, field) ->
    let mut = accessmut mut in F.Expr.recordaccess mut field

let rec affect_mutable (cont:F.Expr.t) (m:F.Expr.t A.Mutable.t) (e:F.Expr.t) = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> F.Expr.apply cont [e]
  | A.Mutable.Array (mut, []) -> assert false
  | A.Mutable.Array (mut, item) -> F.Expr.arrayaffectin (accessmut mut) item e cont
  | A.Mutable.Dot (mut, field) -> F.Expr.recordaffectin (accessmut mut) field e cont

let affected li =
  List.fold_left (fun acc i ->
    A.Instr.Writer.Deep.fold (fun acc i -> match A.Instr.unfix i with
    | A.Instr.Read (_, m)
    | A.Instr.Affect (m, _) -> begin match name_of_mutable m with
      | None -> acc
      | Some s -> A.BindingSet.add s acc
    end
    | _ -> acc
    ) acc i
  ) A.BindingSet.empty li

let rec instrs suite contsuite (contreturn:F.Expr.t option) env = function
  | [] ->
    if suite then contsuite
    else begin match contreturn with
    | Some c -> c
    | None -> F.Expr.unit
    end
  | hd::tl -> match A.Instr.unfix hd with
    | A.Instr.Declare (v, ty, e, _) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.apply (F.Expr.fun_ [v] tl) [e]
    | A.Instr.DeclRead (t, v, _) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.readin (F.Expr.fun_ [v] tl) t
    | A.Instr.AllocRecord (v, ty, li, _) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.apply (F.Expr.fun_ [v] tl) [F.Expr.record (List.map (fun (a, b) -> b, a) li)]
    | A.Instr.Affect (m, e) ->
      let v = name_of_mutable m in
      let nenv = Option.map_default env (fun v -> if List.mem v env then env else v::env) v in
      let tl = instrs suite contsuite contreturn nenv tl in
      begin match v with
      | Some v -> affect_mutable (F.Expr.fun_ [v] tl) m e
      | None -> affect_mutable tl m e
      end
    | A.Instr.Read (ty, m) ->
      let v = name_of_mutable m in
      let nenv = Option.map_default env (fun v -> if List.mem v env then env else v::env) v in
      let tl = instrs suite contsuite contreturn nenv tl in
      let f = Fresh.fresh () in
      let cont = match v with
	| Some v -> affect_mutable (F.Expr.fun_ [v] tl) m (F.Expr.binding f)
	| None -> affect_mutable tl m (F.Expr.binding f)
      in F.Expr.readin (F.Expr.fun_ [f] cont) ty
    | A.Instr.Return ( e) ->
      begin match contreturn with
      | Some contreturn -> F.Expr.apply contreturn [e]
      | None -> e
      end
    | A.Instr.Call (funname, eli) ->
      let next = instrs suite contsuite contreturn env tl in
      let call = F.Expr.apply (F.Expr.binding funname) eli
      in F.Expr.block [call; next]
   | A.Instr.Comment str ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.comment str next
    | A.Instr.If (e, l1, l2) ->
      let affectedl1 = affected l1 in
      let affectedl2 = affected l2 in
      let affected = A.BindingSet.elements @$ A.BindingSet.union affectedl1 affectedl2 in
      let affected = List.filter (fun x -> List.mem x env) affected in
      let next = instrs suite contsuite contreturn env tl in
      let brl1 = bad_return l1 in
      let brl2 = bad_return l2 in
      if (brl1 || brl2) && not (brl1 && brl2) then (* xor *)
	let body1 = instrs true next contreturn env l1 in
	let body2 = instrs true next contreturn env l2 in
	F.Expr.if_ e body1 body2
      else if brl2 || brl1 then
	let next = F.Expr.fun_ affected next in
	let nextname = Fresh.fresh () in
	let ncont = F.Expr.apply (F.Expr.binding nextname) (List.map F.Expr.binding affected) in 
	let body1 = instrs true ncont contreturn env l1 in
	let body2 = instrs true ncont contreturn env l2 in
	F.Expr.apply
	  (F.Expr.fun_ [nextname] (F.Expr.if_ e body1 body2))
	  [next]
      else
	let next = F.Expr.funtuple affected next in
	let ncont = F.Expr.tuple (List.map F.Expr.binding affected) in 
	let body1 = instrs true ncont contreturn env l1 in
	let body2 = instrs true ncont contreturn env l2 in
	F.Expr.apply next [F.Expr.if_ e body1 body2]
    | A.Instr.Print (ty, e) ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.print e ty next
    | A.Instr.StdinSep ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.skipin next
    | A.Instr.While (e, li) ->
      let affected = List.filter (fun x -> List.mem x env) @$ A.BindingSet.elements @$ affected li in
      let next = instrs suite contsuite contreturn env tl in
      let b = Fresh.fresh () in
      let loop = Fresh.fresh () in
      let returnenv = List.map F.Expr.binding affected in
      let nextLoop = F.Expr.apply (F.Expr.binding loop) returnenv in
      let content = instrs true nextLoop contreturn env li in
      let contentif = F.Expr.if_ e content next in
      F.Expr.letrecin loop affected contentif (F.Expr.apply (F.Expr.binding loop) returnenv)
    | A.Instr.Loop (var, from_, end_, li) ->
      let affected = List.filter (fun x -> List.mem x env) @$ A.BindingSet.elements @$ affected li in
      let var_plus_un = F.Expr.binop (F.Expr.binding var) Ast.Expr.Add (F.Expr.integer 1) in
      let next = instrs suite contsuite contreturn env tl in
      let loop = Fresh.fresh () in
      let returnenv = List.map F.Expr.binding affected in
      let calloop = F.Expr.apply (F.Expr.binding loop) ((var_plus_un)::returnenv) in
      let content = instrs true calloop contreturn env li in
      let from = Fresh.fresh () in
      let to_ = Fresh.fresh () in
      let content = F.Expr.if_ (F.Expr.binop (F.Expr.binding var) Ast.Expr.LowerEq (F.Expr.binding to_) )
        content next in
      let cont = F.Expr.fun_ [from; to_]
        (F.Expr.letrecin loop (var::affected) content
           (F.Expr.apply (F.Expr.binding loop) ((F.Expr.binding from)::returnenv))
        ) in
      F.Expr.apply cont [from_; end_]
    | A.Instr.AllocArray (name, t, e, Some (varname, li), _) ->
      let affected = List.filter (fun x -> List.mem x env) @$ A.BindingSet.elements @$ affected li in
      let o = Fresh.fresh () in
      let returnenv = F.Expr.tuple (List.map F.Expr.binding affected) in
      let returncont = F.Expr.fun_ [o] (F.Expr.tuple [returnenv; F.Expr.binding o] ) in
      let content = instrs false contsuite (Some returncont) (varname::env) li in
      let content = F.Expr.funtuple affected content in
      let content = F.Expr.fun_ [varname] content in
      let next = instrs suite contsuite  contreturn env tl in
      let next = F.Expr.fun_ [name] next in
      F.Expr.apply next [F.Expr.arraymake e content returnenv]
    | A.Instr.AllocArray (name, t, e, None, _) -> assert false
    | A.Instr.Untuple (vars, e, _) ->
      let vars = List.map snd vars in
      let tl = instrs suite contsuite contreturn (List.append vars env) tl in
      F.Expr.apply (F.Expr.funtuple vars tl) [e]
    | A.Instr.Tag s -> assert false
    | A.Instr.Unquote e -> assert false

let rec expr e =
  let e = A.Expr.Fixed.map expr (A.Expr.unfix e) in
  match e with
  | A.Expr.UnOp (e, op) -> F.Expr.unop e op
  | A.Expr.BinOp (e1, op, e2) -> F.Expr.binop e1 op e2
  | A.Expr.Lief l -> F.Expr.lief (lief l)
  | A.Expr.Access m -> accessmut m
  | A.Expr.Call(funname, params) -> F.Expr.apply (F.Expr.binding funname) params
  | A.Expr.Tuple li -> F.Expr.tuple li
  | A.Expr.Record r -> F.Expr.record (List.map (fun (a, b) -> b, a) r)
  | A.Expr.Lexems _ -> assert false

let rec instr_to_finstr i =
  let f e = expr e in
  (* let i2 = A.Instr.map_expr f i in *)
  let unfixed = match A.Instr.unfix i with
  | A.Instr.Declare (vn, t, e, opt) -> A.Instr.Declare (vn, t, f e, opt)
  | A.Instr.Affect (mut, e) -> A.Instr.Affect (A.Mutable.map_expr f mut, f e)
  | A.Instr.Loop (varname, e1, e2, li) -> A.Instr.Loop (varname, f e1, f e2, List.map instr_to_finstr li)
  | A.Instr.While (e, li) -> A.Instr.While (f e, List.map instr_to_finstr li)
  | A.Instr.Comment s -> A.Instr.Comment s
  | A.Instr.Tag s -> A.Instr.Tag s
  | A.Instr.Return e -> A.Instr.Return (f e)
  | A.Instr.AllocArray (varname, ty, e, opt, opt2) ->
    A.Instr.AllocArray (varname, ty, f e, Option.map (fun (name, li) ->
      name, List.map instr_to_finstr li) opt, opt2)
  | A.Instr.AllocRecord (varname, ty, li, opt) ->
    A.Instr.AllocRecord (varname, ty, List.map (fun (field, e) -> field, f e) li, opt)
  | A.Instr.If (e, l1, l2) ->
    A.Instr.If (f e, List.map instr_to_finstr l1, List.map instr_to_finstr l2)
  | A.Instr.Call (funname, li) ->
    A.Instr.Call (funname, List.map f li)
  | A.Instr.Print (ty, e) -> A.Instr.Print (ty, f e)
  | A.Instr.Read (ty, mut) -> A.Instr.Read (ty, A.Mutable.map_expr f mut)
  | A.Instr.DeclRead (ty, name, opt) -> A.Instr.DeclRead (ty, name, opt)
  | A.Instr.Untuple (li, e, opt) -> A.Instr.Untuple (li, f e, opt)
  | A.Instr.StdinSep -> A.Instr.StdinSep
  | A.Instr.Unquote e -> A.Instr.Unquote (f e)
  in A.Instr.fixa (A.Instr.Fixed.annot i) unfixed

let instrs suite contsuite contreturn env li =
  let li = List.map instr_to_finstr li in
  instrs suite contsuite contreturn env li

let transform (tyenv, prog) =
  let fonctions = List.filter_map (function
    | Ast.Prog.DeclarFun (name, _, params, is, _) ->
      let params = List.map fst params in
      let e = instrs false (F.Expr.unit) None params is in
      Some (F.Declaration (name, F.Expr.fun_ params e))
    | Ast.Prog.DeclareType (typename, ty) ->
      Some (F.DeclareType (typename, ty))
    | Ast.Prog.Macro (name, ty, params, code) ->
      Some (F.Macro (name, ty, params, code))
    | _ -> None) prog.Ast.Prog.funs
  in let declarations = match prog.Ast.Prog.main with
  | None -> fonctions
  | Some m ->
    let main = instrs false (F.Expr.unit) None [] m in
    List.append fonctions [F.Declaration ("main", main)]
     in { AstFun.declarations = declarations; options = {
       AstFun.reads = prog.Ast.Prog.reads;
       AstFun.hasSkip = prog.Ast.Prog.hasSkip;
     }}
