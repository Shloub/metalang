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

(** Some passes
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils
open ExpandPasses

let rec returns instrs =
  List.fold_left
    returns_i false instrs
and returns_i acc i = match Instr.unfix i with
  | Instr.Return _ -> true
  | Instr.If (_, li1, li2) ->
    acc or ( (returns li1) && returns li2 )
  | _ -> acc

module IfMerge : SigPass with type acc0 = unit = struct
  type acc0 = unit
  type 'a acc = unit;;
  let init_acc () = ();;
  let process () i =
    let rec f acc = function
      | [] -> List.rev acc
      | [i] ->
	let i = g i in
	List.rev (i :: acc)
      | hd::tl ->
	let hd = g hd in
        match Instr.unfix hd with
          | Instr.If (e, l1, l2) ->
            let l1 = f [] l1 in
            let l2 = f [] l2 in
            if returns l1 then
              let l2 = l2 @ tl in
              let l2 = f [] l2 in
              (Instr.if_ e l1 l2 ) :: acc |> List.rev
            else if returns l2 then
              let l1 = l1 @ tl in
              let l1 = f [] l1 in
              (Instr.if_ e l1 l2 ) :: acc |> List.rev
            else f (hd :: acc) tl
          | _ -> f (hd :: acc) tl
    and g instr =
      let annot = Instr.Fixed.annot instr in
      let instr = Instr.map g (Instr.unfix instr) |> Instr.fixa annot
      in
      match Instr.unfix instr with
      | Instr.AllocArray (var, ty, e, Some (var2, li)) ->
	let li = f [] li in
	let unfixed = Instr.alloc_array_lambda var ty e var2 li |> Instr.unfix
	in Instr.fixa annot unfixed
      | i -> instr
    in
    (), f [] i;;
end

module Rename = struct
  type acc0 = unit
  type 'a acc = varname BindingMap.t

  let map = ref BindingMap.empty;;

  let add name =
    map := BindingMap.add name (name ^ "_") !map

  let clear () =
    map := BindingMap.empty

  let init_acc () = !map

  let mapname map name =
    match BindingMap.find_opt name map with
      | Some s -> s
      | None -> name

  let rec mapmutable map m =
    match m |> Mutable.unfix with
      | Mutable.Var v -> Mutable.Var (mapname map v) |> Mutable.fix
      | Mutable.Array (v, li) ->
        Mutable.Array ((mapmutable map v), List.map (process_expr map) li) |> Mutable.fix
      | Mutable.Dot (m, f) ->
        Mutable.Dot ((mapmutable map m), f) |> Mutable.fix

  and process_expr map e =
    let f e = Expr.Fixed.fixa (Expr.Fixed.annot e) (match Expr.Fixed.unfix e with
      | Expr.Access mutable_ ->
        Expr.Access (mapmutable map mutable_)
      | Expr.Call (funname, li) ->
        Expr.Call ((mapname map funname), li)
      | e -> e)
    in Expr.Writer.Deep.map f e

  let rec process_instr map i =
    let i2 = match Instr.unfix i with
      | Instr.Declare (v, t, e) ->
        Instr.Declare ( (mapname map v), t, process_expr map e)
      | Instr.Affect (m, e) ->
        Instr.Affect ((mapmutable map m), process_expr map e)
      | Instr.Loop (var, e1, e2, li) ->
        Instr.Loop ( (mapname map var), (process_expr map e1), (process_expr map e2), List.map (process_instr map) li )
      | Instr.While (e, li) ->
        Instr.While ((process_expr map e), List.map (process_instr map) li )
      | Instr.Comment s -> Instr.Comment s
      | Instr.Return e -> Instr.Return (process_expr map e)
      | Instr.AllocArray (name, t, e, None) ->
        Instr.AllocArray ((mapname map name), t, (process_expr map e), None)
      | Instr.AllocArray (name, t, e, Some ((var, li))) ->
        let li2 = List.map (process_instr map) li in
        Instr.AllocArray ((mapname map name), t, (process_expr map e), Some (( (mapname map var), li2)))
      | Instr.AllocRecord (name, t, el) ->
        Instr.AllocRecord ((mapname map name), t,
                           (List.map
                              (fun (field, e) ->
                                (field, process_expr map e))
                           ) el)
      | Instr.If (e, li1, li2) ->
        Instr.If ((process_expr map e),
                  (List.map (process_instr map) li1 ),
                  (List.map (process_instr map) li2 )
        )
      | Instr.Call (name, li) ->
        Instr.Call ((mapname map name), List.map (process_expr map) li)
      | Instr.Print (t, e) ->
        Instr.Print (t, process_expr map e)
      | Instr.Read (t, m) ->
        Instr.Read (t, mapmutable map m)
      | Instr.DeclRead (t, v)->
        Instr.DeclRead (t, mapname map v)
      | Instr.StdinSep -> Instr.StdinSep
    in Instr.Fixed.fixa (Instr.Fixed.annot i) i2

  let process_main acc m = acc, List.map (process_instr acc) m
  let process acc p =
    let p = match p with
      | Prog.DeclarFun (funname, t, params, instrs) ->
        Prog.DeclarFun (mapname acc funname, t,
                        (List.map (fun (n, t) -> (mapname acc n), t) params),
                        (List.map (process_instr acc) instrs))
      | _ -> p (* TODO *)
    in acc, p
end

module RemoveTags = struct
  type acc0 = unit
  type 'a acc = unit

  let init_acc () = ()

  let rec map li =
    List.filter_map (fun i ->
      match Instr.unfix i with
      | Instr.Tag s -> let () = Tags.tag s in None
      | Instr.Loop (v, e1, e2, li) ->
	let li = map li in
	Some ( Instr.fixa (Instr.Fixed.annot i) (Instr.Loop (v, e1, e2, li)))
      | _ -> Some i
    ) li

  let process acc p =
    match p with
    | Prog.DeclarFun (funname, t, params, instrs) ->
      acc, Prog.DeclarFun (funname, t, params, map instrs)
    | _ -> acc, p

  let process_main acc m = acc, map m

end

module CountNoPosition = struct

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
    | Instr.Declare (_, t, e) -> acc + count_type t + count_expr e
    | Instr.Affect (m, e) -> acc + count_expr e + count_mut m
    | Instr.Loop (_, e1, e2, _) -> acc + count_expr e1 + count_expr e2
    | Instr.While (e, _) -> acc + count_expr e
    | Instr.Return e -> acc + count_expr e
    | Instr.AllocArray (_, t, e, _) -> acc + count_type t + count_expr e
    | Instr.AllocRecord (_, t, li) -> acc + count_type t + count_exprs (List.map snd li)
    | Instr.If (e, _, _) -> acc + count_expr e
    | Instr.Call (_, li) ->acc + count_exprs li
    | Instr.Print (t, e) -> acc + count_type t + count_expr e
    | Instr.Read (t, e) -> acc + count_type t + count_mut e
    | Instr.DeclRead (t, _) -> acc + count_type t
    | Instr.StdinSep -> acc
    | Instr.Unquote e -> acc + count_expr e

  let count (li: 'a Ast.Expr.t Ast.Instr.t list) =
    List.fold_left
      (fun acc i ->
	finstr (Instr.Writer.Deep.fold finstr acc i) i
      ) 0 li

  let process acc p =
    match p with
    | Prog.DeclarFun (funname, t, params, instrs) ->
      (acc + count instrs +
				 count_type t +
				 count_tys (List.map snd params)
			), Prog.DeclarFun (funname, t, params, instrs)
    | _ -> acc, p

  let process_main acc m = acc + count m, m

end

module CollectCalls = struct
  type acc0 = unit
  type 'a acc = BindingSet.t

  let init_acc () = BindingSet.empty

  let process_expr acc e =
    let f acc e = match Expr.Fixed.unfix e with
      | Expr.Call (funname, _) -> BindingSet.add funname acc
      | e -> acc
    in Expr.Writer.Deep.fold f acc e

  let collect_instr acc i =
    let f acc i =
      match Instr.unfix i with
        | Instr.Call (name, li) ->
          BindingSet.add name acc
        | _ -> acc
    in
    let acc = Instr.Writer.Deep.fold f acc i
    in Instr.fold_expr process_expr acc i

  let process_main acc m = (List.fold_left collect_instr acc m), m

  let process acc p =
    let acc = match p with
      | Prog.DeclarFun (_funname, _t, _params, instrs) ->
        List.fold_left collect_instr (BindingSet.add _funname acc) instrs
      | _ -> acc
    in acc, p
end

module CollectTypes : SigPassTop
  with type acc0 = Typer.env
  and type 'a acc = Typer.env * TypeSet.t
  = struct
  type acc0 = Typer.env
  type 'a acc = Typer.env * TypeSet.t

  let init_acc tyenv = tyenv, TypeSet.empty

  let rec collect_type acc t =
    let loc = Ast.PosMap.get (Type.Fixed.annot t) in
    let f (tyenv, acc) t =
      if TypeSet.mem t acc then (tyenv, acc) else
      match Type.Fixed.unfix t with
      | Type.Named n ->
	let acc = TypeSet.add t acc in
	collect_type (tyenv, acc) (Typer.expand tyenv t loc)
      | x -> tyenv, TypeSet.add t acc
    in Type.Writer.Deep.fold f acc t

  let rec process_mutable acc m =
    let f acc m = match Mutable.Fixed.unfix m with
(*       | Mutable.Dot (m, f) -> *)
      | Mutable.Array (m, li) ->
	List.fold_left process_expr acc li
      | e -> acc
    in Mutable.Writer.Deep.fold f acc m
  and process_expr acc e =
    let f acc e = match Expr.Fixed.unfix e with
(*      | Expr.Access m -> TODO *)
(*      | Expr.Enum s -> TODO *)
      | Expr.Access m -> process_mutable acc m
      | e -> acc
    in Expr.Writer.Deep.fold f acc e

  let collect_instr acc i =
    let f acc i =
      match Instr.unfix i with
        | Instr.Declare (_, ty, _) -> collect_type acc ty
	| Instr.AllocRecord (_, ty, _) -> collect_type acc ty
	| Instr.AllocArray (_, ty, _, _) -> collect_type acc ty
        | _ -> acc
    in
    let acc = Instr.Writer.Deep.fold f acc i
    in Instr.fold_expr process_expr acc i

  let process_main acc m = (List.fold_left collect_instr acc m), m

  let process acc p =
    let acc = match p with
      | Prog.DeclarFun (_funname, t, params, instrs) ->
	let acc = collect_type acc t in
	let acc = List.fold_left (fun acc (_, t) -> collect_type acc t)
	  acc params in
        List.fold_left collect_instr acc instrs
      | _ -> acc
    in acc, p
end

module WalkCountNoPosition = WalkTop(CountNoPosition);;

module WalkRemoveTags = WalkTop(RemoveTags);;
module WalkCollectCalls = WalkTop(CollectCalls);;
module WalkCollectTypes = WalkTop(CollectTypes);;
module WalkNopend = Walk(NoPend);;
module WalkExpandPrint = Walk(ExpandPrint);;
module WalkIfMerge = Walk(IfMerge);;
module WalkAllocArrayExpend = Walk(AllocArrayExpend);;
module WalkExpandReadDecl = Walk(ExpandReadDecl);;
module WalkCheckNaming = WalkTop(CheckingPasses.CheckNaming);;
module WalkRename = WalkTop(Rename);;

module RemoveUselessFunctions = struct
  let apply prog funs =
    let go f (li, used_functions) = match f with
      | Prog.DeclarFun (v, _,_, _)
      | Prog.Macro (v, _, _, _) ->
        if BindingSet.mem v used_functions
        then (f::li, (WalkCollectCalls.fold_fun used_functions f) )
        else (li, used_functions)
      | Prog.Comment _ -> (f::li, used_functions)
      | Prog.DeclareType _ -> (f::li, used_functions)
    in

    let used_functions = WalkCollectCalls.fold ()
      {prog with Prog.funs = funs } in (* fonctions utilisées dans le
                                          programme (stdlib non comprise) *)
    let funs, _ = List.fold_right go prog.Prog.funs ([], used_functions) in
    let prog = { prog with Prog.funs = funs} in
    prog
end

module RemoveUselessTypes = struct
  let apply prog funs tyenv =
    let go f (li, used) = match f with
      | Prog.DeclarFun (_, _,_, _)
      | Prog.Macro (_, _, _, _)
      | Prog.Comment _ -> (f::li, used)
      | Prog.DeclareType (name, ty) ->
	if TypeSet.mem ty used
	then (f::li, used)
	else (li, used)
    in let _, used = WalkCollectTypes.fold tyenv {prog with Prog.funs = funs } in
    let funs, _ = List.fold_right go prog.Prog.funs ([], used) in
    let prog = { prog with Prog.funs = funs} in
    prog
end

module ReadAnalysis = struct
  let hasSkip li =
    let f acc i =
      match Instr.unfix i with
        | Instr.StdinSep -> true
        | _ -> acc
    in
    List.fold_left
      (fun acc i ->
        Instr.Writer.Deep.fold
          f
          (f acc i) i)
      false li

  let hasSkip_progitem li =
    List.fold_right
      (fun f b -> match f with
        | Prog.DeclarFun (_, _, _, li) ->
          b || (hasSkip li)
        | _ -> b
      ) li false

  let collectReads acc li =
    let f acc i =
      match Instr.unfix i with
        | Instr.DeclRead (ty, _)
        | Instr.Read(ty, _) ->
          TypeMap.add ty
	    (Ast.PosMap.get (Instr.Fixed.annot i))
	    acc
        | _ -> acc in
    List.fold_left
      (fun acc i ->
        Instr.Writer.Deep.fold f
          (f acc i) i)
      acc li

  let collectReads_progitem li =
    List.fold_right
      (fun f acc -> match f with
        | Prog.DeclarFun (_, _, _, li) -> collectReads acc li
        | _ -> acc
      ) li TypeMap.empty

  let apply prog =
    let reads_types_map =
      let acc = collectReads_progitem prog.Prog.funs
      in Option.map_default acc (collectReads acc) prog.Prog.main
    in
    let () = TypeMap.iter
      (fun ty loc ->
	match Type.unfix ty with
	| Type.Char | Type.Integer -> ()
	| _ -> raise (Warner.Error (fun f ->
	  Format.fprintf f "Cannot read %s %a@\n"
	    (Type.type_t_to_string ty) Warner.ploc loc
	))
      )
      reads_types_map in
    let reads_types = TypeMap.fold (fun a b c -> TypeSet.add a c)
      reads_types_map TypeSet.empty in
    { prog with
      Prog.hasSkip =
        begin
          let acc = hasSkip_progitem prog.Prog.funs
          in acc || (Option.map_default false hasSkip prog.Prog.main )
        end;
      Prog.reads = reads_types
    }
end

let no_macro = function
  | Prog.DeclarFun (_, ty, li, instrs) ->
    begin match Type.unfix ty with
      | Type.Lexems -> false
      | _ -> true
    end
  | _ -> true

module CheckUseVoid = struct
	let rec check ty loc =
		if Type.unfix ty = Type.Void then
			raise (Warner.Error (fun f ->
				Format.fprintf f "Forbiden use of void type in %a@\n"
Warner.ploc loc
			) )
		else Type.Writer.Surface.iter (fun ty -> check ty loc) ty

  let collectDefReturn env li =
    let f () i =
      match Instr.unfix i with
				| Instr.AllocArray (_, ty, _, _)
        | Instr.Declare (_, ty, _) ->
					check ty (Ast.PosMap.get (Instr.Fixed.annot i))
        | Instr.Return e ->
					check (Typer.get_type env e) (Ast.PosMap.get (Instr.Fixed.annot i))
        | _ -> () in
    List.iter
      (fun i ->
        Instr.Writer.Deep.fold f
          (f () i) i)
       li

	let collectDefReturn_fun env = function
		| Prog.DeclarFun (_, _, params, li) ->
			collectDefReturn env li;
			List.iter (fun (_, ty) ->
				check ty (Ast.PosMap.get (Type.Fixed.annot ty))
			) params
    | _ -> ()

	let apply (env, prog) =
		List.iter (fun t -> collectDefReturn_fun env t) prog.Prog.funs;
		Option.map_default () (collectDefReturn env) prog.Prog.main;
		env, prog
end

(* TODO checker les mauvais returns *)
module CheckReturn = struct
  let find_return li =
		let f tra acc i = match Instr.unfix i with
			| Instr.Return _ ->
				let loc = Ast.PosMap.get (Instr.Fixed.annot i) in
				Some loc
			| Instr.AllocArray _ -> acc
			| _ -> tra acc i 
		in
    let li = List.map
			(fun i ->
				f (Instr.Writer.Traverse.fold f) None i)
			li
    in try
	 List.find (function | Some _ -> true | _ -> false) li
      with Not_found -> None

  let check_noreturn li =
    match find_return li with
    | None -> ()
    | Some loc ->
      raise ( Warner.Error (fun f ->
	Format.fprintf f "return not expected at %a" Warner.ploc loc
      ))

  let check_fun = function
    | Prog.DeclarFun (varname, ty, li, instrs) -> begin match Type.unfix ty with
      | Type.Void -> check_noreturn instrs
      | _ -> ()
    end
    | _ -> ()

  let apply () prog =
    begin match prog.Prog.main with
    | Some li -> check_noreturn li
    | None -> ()
    end;
    List.iter check_fun prog.Prog.funs;
    prog
end
