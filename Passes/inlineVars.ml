(*
 * Copyright (c) 2014, Prologin
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
   Cette passe permet d'inliner des variables
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)


open Stdlib
open Ast

type acc0 = unit
type 'a acc = unit
let init_acc () = ()



type info = {
  instruction: Utils.instr;
  expression : Utils.expr option;
  affected: bool;
  declaration:bool;
  dad : Utils.instr option;
}

type infos = {
  infos : info list StringMap.t;
  linenumbers : int IntMap.t;
}

let addinfos acc name info =
  let info = match StringMap.find_opt name acc with
    | None -> [info]
    | Some li -> info::li
  in StringMap.add name info acc

let rec name_of_mut mut = match Mutable.unfix mut with
  | Mutable.Var v -> v
  | Mutable.Array (m, _)
  | Mutable.Dot (m, _) -> name_of_mut m

let rec getinfos_expr instr dad infos e =
  let getinfos infos e =
    match Expr.unfix e with
    | Expr.Call (name, li) ->
      infos
    | Expr.Access mut ->
      let infos = getinfos_mut instr dad infos mut in
      let name = name_of_mut mut in
      let infos = addinfos infos name {instruction=instr; expression=Some e; affected=false; declaration=false; dad=dad} in
      infos
    | _ -> infos
  in Expr.Writer.Deep.fold getinfos infos e

and getinfos_mut instr dad infos m =
  match Mutable.unfix m with
  | Mutable.Var name -> infos (*Warning : ici, on ne le reporte pas : on ne sait pas si on est en mode accès ou pas *)
  | Mutable.Array (m, li) ->
    let infos = getinfos_mut instr dad infos m in
    List.fold_left (getinfos_expr instr dad) infos li
  | Mutable.Dot (m, _) -> getinfos_mut instr dad infos m



let rec getinfo_i dad infos hd = match Instr.unfix hd with
  | Instr.Declare (name, ty, e, _) ->
    let infos = addinfos infos name {instruction=hd; expression=None; affected=false; declaration=true; dad=dad}
    in getinfos_expr hd dad infos e
  | Instr.Affect (mut, e) ->
    let infos = getinfos_expr hd dad infos e in
    let infos = getinfos_mut hd dad infos mut in
    let name = name_of_mut mut in
    let infos = addinfos infos name {instruction=hd; expression=None; affected=true; declaration=false; dad=dad} in
    infos
  | Instr.Loop (varname, e1, e2, li) ->
    let infos = getinfos_expr hd dad infos e1 in
    let infos = getinfos_expr hd dad infos e2 in
    let infos = getinfos infos (Some hd) li in
    infos
  | Instr.While (e, li) ->
    let infos = getinfos_expr hd dad infos e in
    let infos = getinfos infos (Some hd) li in
    infos
  | Instr.Comment _
  | Instr.StdinSep
  | Instr.Tag _ -> infos
  | Instr.Call (_, lie) -> List.fold_left (getinfos_expr hd dad) infos lie
  | Instr.Print (_, e)
  | Instr.Return e -> getinfos_expr hd dad infos e
  | Instr.Untuple (li, e) ->
    let infos = getinfos_expr hd dad infos e in
    let infos = List.fold_left (fun infos (_, name) ->
      addinfos infos name {instruction=hd; expression=None; affected=false; declaration=true; dad=dad}
    ) infos li in
    infos
  | Instr.AllocArray (name, ty, e, None) ->
    let infos = getinfos_expr hd dad infos e in
    addinfos infos name {instruction=hd; expression=None; affected=false; declaration=true; dad=dad}
  | Instr.AllocArray (name, ty, e, Some (var, li)) ->
    let infos = getinfos_expr hd dad infos e in
    let infos = addinfos infos name {instruction=hd; expression=None; affected=false; declaration=true; dad=dad} in
    let infos = getinfos infos (Some hd) li in
    infos
  | Instr.AllocRecord (name, _, li) ->
    let infos = List.fold_left (getinfos_expr hd dad) infos @$ List.map snd li in
    let infos = addinfos infos name {instruction=hd; expression=None; affected=false; declaration=true; dad=dad} in
    infos
  | Instr.If (e, li1, li2) ->
    let infos = getinfos_expr hd dad infos e in
    let infos = getinfos infos (Some hd) li1 in
    let infos = getinfos infos (Some hd) li2 in
    infos
  | Instr.Read (_, mut) ->
    let infos = getinfos_mut hd dad infos mut in
    let name = name_of_mut mut in
    let infos = addinfos infos name {instruction=hd; expression=None; affected=true; declaration=false; dad=dad} in
    infos
  | Instr.DeclRead (_, name, _) ->
    addinfos infos name {instruction=hd; expression=None; affected=false; declaration=true; dad=dad}
  | Instr.Unquote e -> assert false
and getinfos infos dad li = List.fold_left (getinfo_i dad ) infos li

let getinfos instrs =
  let infos = StringMap.empty in
  getinfos infos None instrs

let replace_name name e li =
  List.map (fun i -> Instr.map_expr (fun e2 -> Expr.Writer.Deep.map
    (fun e2 -> match Expr.unfix e2 with
    | Expr.Access m ->
      begin match Mutable.unfix m with
      | Mutable.Var v -> if v = name then e else e2
      | _ -> if name_of_mut m = name then assert false
        else e2
      end
    | _ -> e2
    ) e2 ) i ) li

let can_map_name e =
  match Expr.unfix e with
  | Expr.Access mut -> begin
    match Mutable.unfix mut with
    | Mutable.Var _ -> true
    | Mutable.Array _ -> false
    | Mutable.Dot _ -> false
  end
  | _ -> false

let rec all_variables_mut acc m =
  Mutable.Writer.Deep.fold (fun acc m ->
    match Mutable.unfix m with
    | Mutable.Var i -> if List.mem i acc then acc else i::acc
    | Mutable.Array (m, li) -> List.fold_left all_variables_expr acc li
    | _ -> acc
  ) acc m
and all_variables_expr acc e =
  Expr.Writer.Deep.fold (fun acc e ->
    match Expr.unfix e with
    | Expr.Access m -> all_variables_mut acc m
    | _ -> acc
  ) acc e

let all_variables e = all_variables_expr [] e

let rec no_affectation li ilimit name =
  match li with
  | [] -> true
  | hd::tl -> if hd = ilimit then true else
      (no_affectation tl ilimit name) &&
        (match Instr.unfix hd with
        | Instr.Affect (m, _)
        | Instr.Read (_, m) ->
          let m = name_of_mut m in
          m <> name
        | _ -> true
        )

let is_readvar i = match Instr.unfix i with
  | Instr.Read (_, m) -> begin match Mutable.unfix m with
    | Mutable.Var _ -> true
    | _ -> false
  end
  | _ -> false

let is_affect_copyvar i name = match Instr.unfix i with
  | Instr.Affect (_, e) -> begin match Expr.unfix e with
    | Expr.Access m -> begin match Mutable.unfix m with
      | Mutable.Var v -> v = name
      | _ -> false
    end
    | _ -> false
  end
  | _ -> false

let is_declare_copyvar i name = match Instr.unfix i with
  | Instr.Declare (_, _, e, _) -> begin match Expr.unfix e with
    | Expr.Access m -> begin match Mutable.unfix m with
      | Mutable.Var v -> v = name
      | _ -> false
    end
    | _ -> false
  end
  | _ -> false

let affected_mutable i = match Instr.unfix i with
  | Instr.Affect (m, _) -> m
  | _ -> assert false

let name_declared i = match Instr.unfix i with
  | Instr.Declare (v,_, _, _) -> v
  | _ -> assert false

let remove_instruction li i =
List.filter ((<>) i) li

let rec map_instrs (infos:infos) = function
  | [] -> []
  | hd::tl -> match Instr.unfix hd with
    | Instr.DeclRead (ty, name, { Instr.useless = true } ) ->
      begin match StringMap.find_opt name infos.infos with
      | Some [
        {instruction=i2; expression=_; affected=false; declaration=false; dad=dad2};
        {instruction=i1; expression=_; affected=false; declaration=true; dad=dad1}]
          when is_affect_copyvar i2 name
            ->
        let tl = map_instrs infos @$ remove_instruction tl i2 in
        (Instr.read ty @$ affected_mutable i2)::tl
      | _ -> hd :: (map_instrs infos tl)
	    end
    | Instr.Declare (name, ty, e, { Instr.useless = true } ) ->
      begin match StringMap.find_opt name infos.infos with
      | Some [item2; item1] ->
	      if item2.affected then
	        hd :: (map_instrs infos tl)
	      else begin match item1, item2 with
	      | ({instruction=_; expression=None; affected=false; declaration=true; dad=dad1},
	         {instruction=i2; expression=Some e2; affected=false; declaration=false; dad=dad2}) when dad1 = dad2 &&
                                                                                       (* pas d'affectation pour aucune des variables de la déclaration *)
                                                                                            List.forall (no_affectation tl i2) (all_variables e) ->
	        if can_map_name e2 then
	          let tl = replace_name name e tl in
	          map_instrs infos tl
	        else hd :: (map_instrs infos tl)
	      | _ ->
	        hd :: (map_instrs infos tl)
	      end
      | Some li ->
	      hd :: (map_instrs infos tl)
      | None ->
	      hd :: (map_instrs infos tl)
      end
    | _ -> hd :: (map_instrs infos tl)

let getlines instrs =
  fst @$ List.fold_left (fun acc i ->
    Instr.Writer.Deep.fold (fun (acc, n) i ->
      let acc = IntMap.add (Instr.Fixed.annot i) n acc in
      acc, n+1
    ) acc i
  ) (IntMap.empty, 0) instrs

let map_instrs instrs =
  let infos = { infos = getinfos instrs ; linenumbers = getlines instrs } in
  let instrs = map_instrs infos instrs in
  let instrs = List.map (fun i ->
    let a = Instr.Fixed.annot i in
    let i = Instr.map_bloc (map_instrs infos) @$ Instr.unfix i in
    Instr.fixa a i
  ) instrs in
  instrs

let map_instrs instrs =
  let instrs = map_instrs instrs in
  let instrs = map_instrs instrs in
  let instrs = map_instrs instrs in
  let instrs = map_instrs instrs in
  instrs


let process () (i:Utils.t_fun) = match i with
  | Prog.DeclarFun (name, ty, params, instrs, opt ) ->
    let instrs = map_instrs instrs
    in (), Prog.DeclarFun (name, ty, params, instrs, opt)
  | _ -> (), i

let process_main () instrs =
  (), map_instrs instrs

