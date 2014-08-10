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


type acc = int list StringMap.t (* les paramètres qui se font écraser *)

(* ce type sert à encapsuler les valeurs qui pourraient être affectées lors d'appels de fonctions *)
type compiledExpr =
| Into of ((F.Expr.t -> F.Expr.t) -> F.Expr.t)
| Expr of F.Expr.t

let expand_fun f = function
  | Expr e -> f e
  | Into e -> e f

let expand = expand_fun (fun e -> e)

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

let rec accessmut (m:compiledExpr A.Mutable.t) : compiledExpr = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> Expr (F.Expr.binding varname)
  | A.Mutable.Array (m, li) ->
    let m = accessmut m in
    List.fold_left (fun acc e -> match (acc, e) with
    | Expr acc, Expr e -> Expr (F.Expr.intmapget e acc)
    | Into acc, Expr e -> Into (fun into -> acc (fun acc -> into ( F.Expr.intmapget e acc)))
    | Expr acc, Into e -> Into (fun into -> e (fun e -> into ( F.Expr.intmapget e acc)))
    | Into acc, Into e -> Into (fun into -> e (fun e -> acc (fun acc -> into ( F.Expr.intmapget e acc))))
    ) m li
  | A.Mutable.Dot (mut, field) -> begin match accessmut mut with
    | Expr mut -> Expr (F.Expr.recordaccess mut field)
    | Into mut -> Into (fun into -> mut (fun mut -> into (F.Expr.recordaccess mut field)))
  end

let rec affect_mutable (cont:F.Expr.t) (m:compiledExpr A.Mutable.t) (e:F.Expr.t) = match A.Mutable.unfix m with
  | A.Mutable.Var varname -> Expr (F.Expr.apply cont [e])
  | A.Mutable.Array (mut, []) -> assert false
  | A.Mutable.Array (mut, [Expr item]) ->
    let namemut = Fresh.fresh () in
    let cont e = F.Expr.fun_ [namemut]
      (F.Expr.apply cont [F.Expr.intmapadd
			     item
			     e
			     (F.Expr.binding namemut)
			 ])
    in begin match accessmut mut with
    | Expr mut -> Expr (F.Expr.apply (cont e) [mut])
    | Into mut -> Into (fun into -> mut (fun mut -> into (F.Expr.apply (cont e) [mut])))

    end
  | A.Mutable.Array (mut, hd::tl) -> assert false (* TODO *)
  | A.Mutable.Dot (mut, field) ->
    let affecte muta = F.Expr.recordwith muta e field
    in match accessmut mut with
    | Expr muta -> affect_mutable cont mut (affecte muta)
    | Into muta ->
      let name = Fresh.fresh () in
      let e = F.Expr.binding name in
      match affect_mutable cont mut e with
      | Expr m -> (* Into (fun into -> muta (fun muta -> into (F.Expr.apply m [affecte muta]))) *)
	assert false
      | Into m -> assert false


let rec instrs suite contsuite (contreturn:F.Expr.t option) env = function
  | [] ->
    if suite then contsuite
    else begin match contreturn with
    | Some c -> c
    | None -> F.Expr.unit
    end
  | hd::tl -> match A.Instr.unfix hd with
    | A.Instr.Declare (v, ty, Expr e, _) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.apply (F.Expr.fun_ [v] tl) [e]
    | A.Instr.Declare (v, ty, Into e, _) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      e (fun e -> F.Expr.apply (F.Expr.fun_ [v] tl) [e])
    | A.Instr.DeclRead (t, v, _) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.readin (F.Expr.fun_ [v] tl) t
(*
    | A.Instr.AllocRecord (v, ty, li) ->
      let tl = instrs suite contsuite contreturn (v::env) tl in
      F.Expr.apply (F.Expr.fun_ [v] tl) [F.Expr.record (List.map (fun (a, b) -> b, a) li)]
*)
    | A.Instr.Affect (m, Expr e) ->
      let v = name_of_mutable m in
      let nenv = if List.mem v env then env else v::env in
      let tl = instrs suite contsuite contreturn nenv tl in
      expand @$ affect_mutable (F.Expr.fun_ [v] tl) m e
    | A.Instr.Affect (m, Into e) ->
      let v = name_of_mutable m in
      let nenv = if List.mem v env then env else v::env in
      let tl = instrs suite contsuite contreturn nenv tl in
      e (fun e -> expand @$ affect_mutable (F.Expr.fun_ [v] tl) m e)

    | A.Instr.Read (ty, m) ->
      let v = name_of_mutable m in
      let nenv = if List.mem v env then env else v::env in
      let tl = instrs suite contsuite contreturn nenv tl in
      let f = Fresh.fresh () in
      let cont = affect_mutable (F.Expr.fun_ [v] tl) m (F.Expr.binding f) in
      begin match cont with
      | Expr cont -> F.Expr.readin (F.Expr.fun_ [f] cont) ty
      | Into cont -> cont (fun cont -> F.Expr.readin (F.Expr.fun_ [f] cont) ty)
      end
    | A.Instr.Return (Expr e) ->
      begin match contreturn with
      | Some contreturn -> F.Expr.apply contreturn [e]
      | None -> e
      end
    | A.Instr.Return (Into e) ->
      begin match contreturn with
      | Some contreturn -> e (fun e -> F.Expr.apply contreturn [e])
      | None -> e (fun e -> e)
      end
    | A.Instr.Call (funname, eli) ->
      let next = instrs suite contsuite contreturn env tl in
      let call = List.fold_left (fun acc e -> match acc, e with
	| Expr acc, Expr e -> Expr (F.Expr.apply acc [e])
	| Expr acc, Into e -> Into (fun into -> e (fun e -> into ( F.Expr.apply acc [e] )))
	| Into acc, Expr e -> Into (fun into -> acc (fun acc -> into ( F.Expr.apply acc [e] )))
	| Into acc, Into e -> Into (fun into -> acc (fun acc -> e (fun e -> into ( F.Expr.apply acc [e] ))))
      ) (Expr (F.Expr.binding funname)) eli
      in begin match call with
      | Expr call -> F.Expr.block [call; next]
      | Into call -> call (fun call -> F.Expr.block [call; next])
      end
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
      expand_fun (fun e ->
	F.Expr.apply
	  (F.Expr.fun_ [nextname] (F.Expr.if_ e body1 body2))
	  [next]) e
    | A.Instr.Print (ty, Expr e) ->
      let next = instrs suite contsuite contreturn env tl in
      F.Expr.print e ty next
    | A.Instr.Print (ty, Into e) ->
      let next = instrs suite contsuite contreturn env tl in
      e (fun e -> F.Expr.print e ty next)  
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
      let contentif = expand_fun (fun e -> F.Expr.if_ e content next) e in
      F.Expr.letrecin loop env contentif (F.Expr.apply (F.Expr.binding loop) returnenv)
      
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
      expand_fun (fun from_ -> expand_fun (fun end_ -> F.Expr.apply cont [from_; end_]) end_ ) from_
    | A.Instr.AllocArray (name, t, e, Some li) -> assert false

    | A.Instr.AllocArray (name, t, e, None) -> (* WARNING : on ignore complètement e... *)
      let tl = instrs suite contsuite contreturn (name::env) tl in
      F.Expr.apply (F.Expr.fun_ [name] tl) [F.Expr.intmapempty]

    | A.Instr.Untuple (vars, e) ->
      let vars = List.map snd vars in
      let tl = instrs suite contsuite contreturn (List.append vars env) tl in
      expand_fun (fun e -> F.Expr.apply (F.Expr.funtuple vars tl) [e]) e
    | A.Instr.Tag s -> assert false
    | A.Instr.Unquote e -> assert false

let rec expr (acc:acc) e =
  let e = A.Expr.Fixed.map (expr acc) (A.Expr.unfix e) in
  match e with
  | A.Expr.UnOp (Expr e, op) -> Expr (F.Expr.unop e op)
  | A.Expr.UnOp (Into e, op) -> Into (fun into -> e (fun e -> into (F.Expr.unop e op)))
  | A.Expr.BinOp (Into e1, op, Into e2) ->
    Into (fun into -> e1 (fun e1 -> e2 (fun e2 -> into (F.Expr.binop e1 op e2 ))))
  | A.Expr.BinOp (Into e1, op, Expr e2) ->
    Into (fun into -> e1 (fun e1 -> into (F.Expr.binop e1 op e2 )))
  | A.Expr.BinOp (Expr e1, op, Into e2) ->
    Into (fun into -> e2 (fun e2 -> into (F.Expr.binop e1 op e2 )))
  | A.Expr.BinOp (Expr e1, op, Expr e2) ->
    Expr (F.Expr.binop e1 op e2)
  | A.Expr.Lief l -> Expr (F.Expr.lief (lief l))
  | A.Expr.Access m -> accessmut m
  | A.Expr.Call(funname, params) ->
    let paramsacc = Option.default [] (StringMap.find_opt funname acc) in
    snd @$ List.fold_left (fun (i, acc) e ->
(*      if List.mem i paramsacc then *)
      i + 1, match acc, e with
    | Expr acc, Expr e -> Expr (F.Expr.apply acc [e])
    | Expr acc, Into e -> Into (fun into -> e (fun e -> into ( F.Expr.apply acc [e] )))
    | Into acc, Expr e -> Into (fun into -> acc (fun acc -> into ( F.Expr.apply acc [e] )))
    | Into acc, Into e -> Into (fun into -> acc (fun acc -> e (fun e -> into ( F.Expr.apply acc [e] ))))
    ) (0, (Expr (F.Expr.binding funname))) params
(*
  | A.Expr.Tuple li -> F.Expr.tuple li
  | A.Expr.Record r -> F.Expr.record (List.map (fun (a, b) -> b, a) r)
*)
  | A.Expr.Lexems _ -> assert false

let rec instr_to_finstr acc i =
  let f e = expr acc e in
  (* let i2 = A.Instr.map_expr f i in *)
  let unfixed = match A.Instr.unfix i with
  | A.Instr.Declare (vn, t, e, opt) -> A.Instr.Declare (vn, t, f e, opt)
  | A.Instr.Affect (mut, e) -> A.Instr.Affect (A.Mutable.map_expr f mut, f e)
  | A.Instr.Loop (varname, e1, e2, li) -> A.Instr.Loop (varname, f e1, f e2, List.map (instr_to_finstr acc) li)
  | A.Instr.While (e, li) -> A.Instr.While (f e, List.map (instr_to_finstr acc) li)
  | A.Instr.Comment s -> A.Instr.Comment s
  | A.Instr.Tag s -> A.Instr.Tag s
  | A.Instr.Return e -> A.Instr.Return (f e)
  | A.Instr.AllocArray (varname, ty, e, opt) ->
    A.Instr.AllocArray (varname, ty, f e, Option.map (fun (name, li) ->
      name, List.map (instr_to_finstr acc) li) opt)
  | A.Instr.AllocRecord (varname, ty, li) ->
    A.Instr.AllocRecord (varname, ty, List.map (fun (field, e) -> field, f e) li)
  | A.Instr.If (e, l1, l2) ->
    A.Instr.If (f e, List.map (instr_to_finstr acc) l1, List.map (instr_to_finstr acc) l2)
  | A.Instr.Call (funname, li) ->
    A.Instr.Call (funname, List.map f li)
  | A.Instr.Print (ty, e) -> A.Instr.Print (ty, f e)
  | A.Instr.Read (ty, mut) -> A.Instr.Read (ty, A.Mutable.map_expr f mut)
  | A.Instr.DeclRead (ty, name, opt) -> A.Instr.DeclRead (ty, name, opt)
  | A.Instr.Untuple (li, e) -> A.Instr.Untuple (li, f e)
  | A.Instr.StdinSep -> A.Instr.StdinSep
  | A.Instr.Unquote e -> A.Instr.Unquote (f e)
  in A.Instr.fixa (A.Instr.Fixed.annot i) unfixed

let instrs acc suite contsuite contreturn env li =
  let li = List.map (instr_to_finstr acc) li in
  instrs suite contsuite contreturn env li

let transform (tyenv, prog) =
  let acc, fonctions = List.fold_left_map
    (fun acc item -> match item with
    | Ast.Prog.DeclarFun (name, _, params, is, _) ->
      let params = List.map fst params in
      let e = instrs acc false (F.Expr.unit) None params is in
      acc, Some (F.Declaration (name, F.Expr.fun_ params e))
    | Ast.Prog.DeclareType (typename, ty) ->
      acc, Some (F.DeclareType (typename, ty))
    | _ -> acc, None) StringMap.empty prog.Ast.Prog.funs
  in let fonctions = List.filter_map (fun x -> x) fonctions
  in match prog.Ast.Prog.main with
  | None -> fonctions
  | Some m ->
    let main = instrs acc false (F.Expr.unit) None [] m in
    List.append fonctions [F.Declaration ("main", main)]
