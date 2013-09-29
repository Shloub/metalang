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


(** Typer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Warner

(** {2 Types} *)
type typeContrainte =
  | Unknown of Ast.location
  | PreTyped of typeContrainte ref Type.tofix * Ast.location
  | Typed of Type.t * Ast.location

type varType = typeContrainte ref

type functionType = Type.t list * varType

let rec is_typed (t : typeContrainte ref) : bool =
  match !t with
    | Unknown _ -> false
    | PreTyped (t, _) ->
      let out = ref true in
      Type.Fixed.map (fun t -> if not (is_typed t) then out := false) t;
      !out
    | Typed (t, _) -> true


let rec extract_typed (t : typeContrainte ref) : Type.t =
  match !t with
  | Unknown loc -> assert false
  | PreTyped (t, _) ->
    Type.Fixed.map extract_typed t |> Type.Fixed.fix
  | Typed (t, _) -> t

type env =
    {
      automap : typeContrainte ref IntMap.t;
      contrainteMap : typeContrainte ref IntMap.t;
      fields : (Type.t * Type.t * string) StringMap.t;
      enum : (Type.t * string) StringMap.t;
      gamma : Type.t StringMap.t;
      functions : functionType StringMap.t;
      locales : varType StringMap.t;
      contraintes : (typeContrainte ref * typeContrainte ref) list;
    }

let type_of_field env field =
  let (_, t, _) = StringMap.find field env.fields in t

let ty2typeContrainte (env : env) (t : Type.t) (loc : Ast.location)
    : (env * typeContrainte ref) =

  let fold env t = match Type.Fixed.unfix t with
    | Type.Auto ->
      let out = ref (Unknown loc) in
      let env = {env with automap = IntMap.add (Type.Fixed.annot t)
          out env.automap }
      in env
    | _ -> env
  in
  let env = Type.Writer.Deep.fold fold (fold env t) t
  in
  let rec f t = match Type.Fixed.unfix t with
    | Type.Auto -> IntMap.find (Type.Fixed.annot t) env.automap
    | t -> ref ( PreTyped ( (Type.Fixed.map f t ), loc) )
  in let t = f t in env, t

(** {2 Printers} *)
let rec contr2str t =
  match t with
    | Unknown _ -> "*"
    | PreTyped (ty, _) -> "P_"^
      (Type.type2String (Type.Fixed.map (fun t -> contr2str !t) ty))
    | Typed (ty, _) -> "T_" ^ (Type.type_t_to_string ty)

(** {2 Error reporters} *)

let error_no_auto_type map annot ty =
  raise ( Error (fun f ->
    Format.fprintf f
      "Cannot find type of auto in %s (%d)\n%!"
      (Type.type_t_to_string ty) annot;
    IntMap.iter (fun k v ->
      Format.fprintf f "annot %d : %s@\n" k
        (contr2str !v)
    ) map
))

let error_no_contraintes li =
  raise ( Error (fun f ->
    List.iter
      (fun (a, b) ->
        Format.fprintf f "No contrainte to unify %s and %s\n%!"
          (contr2str !a) (contr2str !b)
      ) li
  ))

let error_field_not_found loc name t =
  raise ( Error (fun f ->
    Format.fprintf f "Field %s is not found in %s %a\n%!"
      name
      (Type.type_t_to_string t)
      ploc loc))

let error_function_not_found loc name =
  raise (Error (fun f -> Format.fprintf f "Function %s is not found in %a\n%!"
    name
    ploc loc))

let rec plistring f li =
  match li with
    | hd::tl ->
      Format.fprintf f "  %s\n%a" hd plistring tl
    | [] -> ()

let error_record_types lval lt loc =
  raise (Error (fun f -> Format.fprintf f "Fields does not match in %a\n%aagainst\n%a%!"
    (* TODO show lists & diff *)
    ploc loc
    plistring lval
    plistring lt))

let error_arrity funname l1 l2 loc =
  raise (Error (fun f ->
    Format.fprintf f "The function %s expects %d arguments, %d given %a.\n%!"
      funname l1 l2
      ploc loc))

let error_ty t1 t2 loc1 loc2 =
  raise (Error (fun f  -> Format.fprintf f "Cannot unify %s %a and %s %a\n%!"
    (Type.type_t_to_string t1)
    ploc loc1
    (Type.type_t_to_string t2)
    ploc loc2))

let not_found name loc =
  raise (Error (fun f -> Format.fprintf f "Cannot find variable %s %a \n%!"
    name
    ploc loc))

let not_found_ty name loc =
  raise (Error (fun f -> Format.fprintf f "Cannot find type %s %a \n%!"
    name
    ploc loc))

let error_cty t1 t2 loc1 loc2 =
  raise (Error (fun f -> Format.fprintf f "Cannot unify %s %a and %s %a\n%!"
    (contr2str t1)
    ploc loc1
    (contr2str t2)
    ploc loc2))

(** {2 Types anti alias-ing}*)
(* TODO passer loc en premier ou second parametre*)
let expand env ty loc =
  let rec f ty =
    match Type.Fixed.unfix ty with
      | Type.Named name ->
        (try
          StringMap.find name env.gamma
        with Not_found ->
          not_found_ty name loc)
      | x -> Type.Fixed.F (Type.Fixed.annot ty, (Type.Fixed.map f x))
  in f ty

(** {2 Unify} *)
let rec check_types env (t1:Type.t) (t2:Type.t) loc1 loc2 =
  match (Type.Fixed.unfix t1), (Type.Fixed.unfix t2) with
    | Type.Integer, Type.Integer -> ()
    | Type.Lexems, Type.Lexems -> ()
    | Type.Integer, _ -> error_ty t1 t2 loc1 loc2
    | Type.Bool, Type.Bool -> ()
    | Type.Bool, _ -> error_ty t1 t2 loc1 loc2
    | Type.String, Type.String -> ()
    | Type.String, _ -> error_ty t1 t2 loc1 loc2
    | Type.Float, Type.Float -> ()
    | Type.Float, _ -> error_ty t1 t2 loc1 loc2
    | Type.Char, Type.Char -> ()
    | Type.Char, _ -> error_ty t1 t2 loc1 loc2
    | Type.Void, Type.Void -> ()
    | Type.Void, _ -> error_ty t1 t2 loc1 loc2
    | Type.Named n, Type.Named n2 ->
      if String.equals n n2 then () else error_ty t1 t2 loc1 loc2
    | _, Type.Named n ->
      check_types env t1 (expand env t2 loc2) loc1 loc2
    | Type.Named n, _ ->
      check_types env (expand env t1 loc1) t2 loc1 loc2
    | Type.Array t, Type.Array t2 ->
      check_types env t t2 loc1 loc2
    | Type.Struct (li, _), Type.Struct (li2, _) ->
      List.iter
        (fun (name, ty) ->
          let (_, ty2) =
            try
              List.find ((String.equals name) @* fst) li2
            with Not_found ->
              error_field_not_found loc1 name t2
          in
          check_types env ty ty2 loc1 loc2
        ) li
    | Type.Enum li, Type.Enum li2 ->
      List.iter
        (fun name ->
          (try
            List.find (String.equals name) li2
          with Not_found ->
            error_field_not_found loc1 name t2
          ); ()
        ) li
    | _ -> error_ty t1 t2 loc1 loc2

let rec unify env (t1 : typeContrainte ref) (t2 : typeContrainte ref) : bool =
  match !t1, !t2 with
    | Typed (((Type.Fixed.F (_, Type.Named _)) as t), loc), _ ->
      begin
        t1 := Typed ((expand env t loc), loc);
        true
      end
    | _, Typed (((Type.Fixed.F (_, Type.Named _)) as t), loc) ->
      begin
        t2 := Typed ((expand env t loc), loc);
        true
      end
    | Typed (tt1, loc1), Typed (tt2, loc2) ->
      begin
        check_types env tt1 tt2 loc1 loc2;
        false
      end
    | Unknown _, Unknown _-> false
    | Unknown _, _ ->
      begin
        t1 := !t2;
        true
      end
    | _, Unknown _ ->
      begin
        t2 := !t1;
        true
      end
    | Typed _, PreTyped _ -> unify env t2 t1
    | PreTyped (_, loc), _ when is_typed t1 ->
      begin
        t1 := Typed ((extract_typed t1), loc);
        true
      end
    | PreTyped (Type.Array a1, loc1), PreTyped (Type.Array a2, loc2) ->
      unify env a1 a2
    | PreTyped (Type.Array _, loc1), PreTyped (_, loc2) ->
      error_cty !t1 !t2 loc1 loc2
    | PreTyped (Type.Array r1, loc1), Typed (Type.Fixed.F (_, Type.Array ty), loc2) ->
      begin
        r1 := Typed (ty, loc1);
        true
      end
    | PreTyped ((Type.Array r1), loc1), Typed (_, loc2) ->
      error_cty !t1 !t2 loc1 loc2
    | PreTyped (Type.Struct (li, _), loc1),
      Typed (Type.Fixed.F (_, Type.Struct (li2, _)), loc2) ->
      List.fold_left
        (fun acc (name, t) ->
          let (_, ty) = List.find
            ((String.equals name) @* fst)
            li2
          in acc || unify env t (ref (Typed (ty, loc2)))
        ) false li
    | PreTyped (Type.Struct _, loc1), Typed (_, loc2) ->
      error_cty !t1 !t2 loc1 loc2
    | PreTyped (Type.Struct (li, _), loc1),
      PreTyped (Type.Struct (li2, _), loc2) ->
      List.fold_left
        (fun acc (name, t) ->
          let (_, t2) = List.find
            ((String.equals name) @* fst)
            li2
          in acc || unify env t t2
        ) false li
    |  PreTyped (Type.Struct _, loc1), PreTyped (_, loc2) -> error_cty !t1 !t2
      loc1 loc2



(** {2 Accessors}*)
let is_int env expr =
  match !(IntMap.find (Expr.Fixed.annot expr) env.contrainteMap) with
    | Typed (Type.Fixed.F (_, Type.Integer), _) -> true
    | _ -> false

let is_float env expr =
  match !(IntMap.find (Expr.Fixed.annot expr) env.contrainteMap) with
    | Typed (Type.Fixed.F (_, Type.Float), _) -> true
    | _ -> false

let exprloc e = Ast.PosMap.get (Expr.Fixed.annot e) (* TODO plus
                                                       l'utiliser *)

let add_contrainte env c1 c2 =
  { env with
    contraintes = (c1, c2) :: env.contraintes
  }

(** {2 Collect contraintes functions} *)
let rec collect_contraintes_expr env e =
  (*  let () = Format.printf "collecting expr contraintes@\n" in
      let () =
      Format.fprintf
      Format.std_formatter
      "collecting contraintes in %a@\n"
      Printer.printer#expr  e
      in*)
  let loc e = Ast.PosMap.get (Expr.Fixed.annot e) in
  let env, contrainte = match Expr.Fixed.unfix e with
    | Expr.BinOp (a, Expr.Mod, b) ->
      let env, acontrainte = collect_contraintes_expr env a in
      let env, bcontrainte = collect_contraintes_expr env b in
      let env = add_contrainte env acontrainte
        (ref (Typed (Type.integer, loc a))) in
      let env = add_contrainte env bcontrainte
        (ref (Typed (Type.integer, loc b))) in
      env, ref (Typed (Type.integer, loc e))
    | Expr.BinOp (a, (Expr.Or | Expr.And), b) ->
      let env, acontrainte = collect_contraintes_expr env a in
      let env, bcontrainte = collect_contraintes_expr env b in
      let env = add_contrainte env acontrainte
        (ref (Typed (Type.bool, loc a))) in
      let env = add_contrainte env bcontrainte
        (ref (Typed (Type.bool, loc b))) in
      env, ref (Typed (Type.bool, loc e))
    | Expr.BinOp (a, (Expr.Lower | Expr.LowerEq | Expr.Higher | Expr.HigherEq
                         | Expr.Eq | Expr.Diff), b) ->
      let contrainte = ref (Typed (Type.bool, loc e)) in
      let env, acontrainte = collect_contraintes_expr env a in
      let env, bcontrainte = collect_contraintes_expr env b in
      let env = add_contrainte env acontrainte bcontrainte in
      env, contrainte

    (* Pour les autres cas, on suppose 'a -> 'a -> 'a*)
    | Expr.BinOp (a,_, b) ->
      let contrainte = ref (Unknown (loc e)) in
      let env, acontrainte = collect_contraintes_expr env a in
      let env, bcontrainte = collect_contraintes_expr env b in
      let env = add_contrainte env acontrainte contrainte in
      let env = add_contrainte env bcontrainte contrainte in
      env, contrainte

    | Expr.UnOp (a, Expr.Neg) ->
      let contrainte = (ref (Typed (Type.integer, loc e))) in
      let env, acontrainte = collect_contraintes_expr env a in
      let env = add_contrainte env acontrainte contrainte in
      env, contrainte
    | Expr.UnOp (a, Expr.Not) ->
      let contrainte = (ref (Typed (Type.bool, loc e))) in
      let env, acontrainte = collect_contraintes_expr env a in
      let env = add_contrainte env acontrainte contrainte in
      env, contrainte
    | Expr.Char _ ->
      env, ref (Typed (Type.char, loc e))
    | Expr.String _ ->
      env, ref (Typed (Type.string, loc e))
    | Expr.Float _ ->
      env, ref (Typed (Type.float, loc e))
    | Expr.Integer _ ->
      env, ref (Typed (Type.integer, loc e))
    | Expr.Lexems li -> (* TODO typer les insertions *)
      env, ref (Typed (Type.lexems, loc e))
    | Expr.Bool _ ->
      env, ref (Typed (Type.bool, loc e))
    | Expr.Access mut ->
      collect_contraintes_mutable env mut
    | Expr.Call ("instant", [param]) ->
      collect_contraintes_expr env param
    | Expr.Call (name, li) ->
      let (args_ty, out_ty) =
        try
          StringMap.find name env.functions
        with Not_found ->
          error_function_not_found (loc e) name
      in
      let len1 = List.length args_ty in
      let len2 = List.length li in
      let () = if len1 != len2
        then error_arrity name len1 len2 (loc e)
      in
      let env = List.fold_left
        (fun env (ty1, arg) ->
          let env, contrainte = collect_contraintes_expr env arg in
          let env, contrainte2 = ty2typeContrainte env ty1 (loc arg) in
          let env = {env with contraintes = (contrainte, contrainte2) ::
              env.contraintes} in env
        ) env (List.zip args_ty li) in
      env, out_ty
    | Expr.Enum en ->
      let (t, _) = StringMap.find en env.enum in (* TODO not found*)
      let contrainte = ref (Typed (t, loc e) ) in
      env, contrainte
  in
  let env = { env with
    contrainteMap = IntMap.add (Expr.Fixed.annot e) contrainte env.contrainteMap }
  in
  env, contrainte

and collect_contraintes_mutable env mut =
  let loc m = Ast.PosMap.get (Mutable.Fixed.annot m) in
  let tloc = loc mut in
  (*  let () = Format.printf "collecting mutable contraintes@\n" in *)
  match Mutable.Fixed.unfix mut with
    | Mutable.Var name ->
      let ty =
        try
          StringMap.find name env.locales
        with Not_found ->
          not_found name tloc
      in
      env, ty
    | Mutable.Array (mut, eli) ->
      let env = List.fold_left (fun env e ->
        let integer_contrainte = ref (Typed (Type.integer, exprloc e)) in
        let env, contrainte_expr = collect_contraintes_expr env e in
        add_contrainte env integer_contrainte contrainte_expr
      ) env eli in
      let contrainte = ref (Unknown tloc) in
      let env, contrainte_mut = collect_contraintes_mutable env mut in
      let contrainte_mut2 = ref (PreTyped (Type.Array contrainte, loc mut) ) in
      let env = { env with contraintes =
          (contrainte_mut, contrainte_mut2) :: env.contraintes
                } in
      env, contrainte
    | Mutable.Dot (mut, name) ->
      let (ty_dot, ty_mut, _) = StringMap.find name env.fields in
      let env, contrainte = collect_contraintes_mutable env mut in
      let env, contrainte2 = ty2typeContrainte env ty_mut tloc in
      let env, ty_dot = ty2typeContrainte env ty_dot tloc in
      let env = {env with
        contraintes = (contrainte, contrainte2) :: env.contraintes} in
      env, ty_dot

let rec collect_contraintes_instructions env instructions
    (ty_ret : typeContrainte ref) =
  (*  let () = Format.printf "collecting instructions contraintes\n" in *)
  List.fold_left
    (fun env instruction ->
      let loc = Ast.PosMap.get (Instr.Fixed.annot instruction) in
      match Instr.unfix instruction with
        | Instr.Declare (var, ty, e) ->
          let ty = expand env ty loc in
          let env, contrainte_expr = collect_contraintes_expr env e in
          let env, contrainte_ty = ty2typeContrainte env ty loc in
          let env =
            { env with locales =
                StringMap.add var contrainte_ty env.locales } in
          {env with
            contraintes = (contrainte_ty, contrainte_expr) ::
              env.contraintes}
        | Instr.Affect (mut, e) ->
          let env, contrainte_mut = collect_contraintes_mutable env mut in
          let env, contrainte_expr = collect_contraintes_expr env e in
          {env with
            contraintes = (contrainte_mut, contrainte_expr) ::
              env.contraintes}

        | Instr.Loop (var, e1, e2, li) ->
          let contrainte_integer = ref (Typed (Type.integer, loc) ) in
          let env = {env with locales = StringMap.add var contrainte_integer
              env.locales } in
          let env, contrainte_e1 = collect_contraintes_expr env e1 in
          let env, contrainte_e2 = collect_contraintes_expr env e2 in
          let env = {env with
            contraintes =
              (contrainte_integer, contrainte_e1) ::
                (contrainte_integer, contrainte_e2) ::
                env.contraintes}
          in
          let env = collect_contraintes_instructions env li ty_ret
          in env
        | Instr.While (e, li) ->
          let env, contrainte_e = collect_contraintes_expr env e in
          let env = collect_contraintes_instructions env li ty_ret
          in env
        | Instr.Comment _ -> env
        | Instr.Return e ->
          let env, contrainte_expr = collect_contraintes_expr env e in
          {env with
            contraintes = (ty_ret, contrainte_expr) ::
              env.contraintes}
        | Instr.AllocArray (var, ty, e, instrsopt) ->
          let ty = expand env ty loc in
          let env, ty = ty2typeContrainte env ty loc in
          let contrainte_integer = ref (Typed (Type.integer, loc) ) in
          let env, contrainte_e = collect_contraintes_expr env e in
          let env = {env with
            contraintes =
              (contrainte_integer, contrainte_e) ::
                env.contraintes}
          in
          let env = match instrsopt with
            | None -> env
            | Some (var, instrs) ->
              let env = {env with
                locales = StringMap.add var contrainte_integer env.locales}
              in collect_contraintes_instructions env instrs ty
          in
          let env = {env with
            locales = StringMap.add var
              (ref (PreTyped (Type.Array ty, loc)))
                      env.locales}
          in env
        | Instr.AllocRecord (var, ty, li) ->
          let ty = expand env ty loc in
          let li_type = match li with
            | (name, _) :: _ ->
              begin try match StringMap.find name env.fields with
                | (_, Type.Fixed.F (_, Type.Struct (li, _)), _) -> li
                | _ -> assert false
                with Not_found ->
                  error_field_not_found loc name ty
              end
            | _ -> assert false
          in
          let () =
            let fields1 = List.map fst li |> List.sort String.compare in
            let fields2 = List.map fst li_type |> List.sort String.compare in
            if fields1 <> fields2 then
              error_record_types fields1 fields2 loc
          in
          let env = List.fold_left
            (fun env (name, expr) ->
              let env, c2 = collect_contraintes_expr env expr in
              let c1 = ref ( Typed( snd (List.find
                                           ((String.equals name) @* fst) li_type
              ), loc)) in
              {env with contraintes = (c1, c2) :: env.contraintes }
            ) env li
          in
          let env, ty = ty2typeContrainte env ty loc in
          let env = {env with
            locales = StringMap.add var
              ty env.locales}
          in env
        | Instr.If (e, instrs1, instrs2) ->
          let contrainte_ty = ref (Typed (Type.bool, loc)) in
          let env, contrainte_expr = collect_contraintes_expr env e in
          let env = {env with
            contraintes = (contrainte_ty, contrainte_expr) ::
              env.contraintes} in
          let env = collect_contraintes_instructions env instrs1 ty_ret in
          let env = collect_contraintes_instructions env instrs2 ty_ret in
          env
        | Instr.Call (f, eli) ->
          let (args, out_contraint) =
            try
              StringMap.find f env.functions
          with Not_found ->
            error_function_not_found loc f
          in
          let len1 = List.length args in
          let len2 = List.length eli in
          let () = if len1 != len2
            then error_arrity f len1 len2 loc
          in
          let void_contraint = ref (Typed (Type.void, loc)) in
          let env = List.fold_left
            (fun (env:env) (arg_ty, arg_e) ->
              let env, contrainte_ty = ty2typeContrainte env arg_ty loc in
              let env, contrainte_e = collect_contraintes_expr env arg_e in
              {env with
                contraintes = (contrainte_e, contrainte_ty) ::
                  env.contraintes}
            ) env (List.zip args eli) in
          {env with
            contraintes = (void_contraint, out_contraint) ::
              env.contraintes}
        | Instr.Print (ty, e) ->
          let ty = expand env ty loc in
          let env, contrainte_ty = ty2typeContrainte env ty loc in
          let env, contrainte_expr = collect_contraintes_expr env e in
          {env with
            contraintes = (contrainte_ty, contrainte_expr) ::
              env.contraintes}
        | Instr.Read (ty, mut) ->
          let ty = expand env ty loc in
          let env, contrainte_mut = collect_contraintes_mutable env mut in
          let env, contrainte_expr = ty2typeContrainte env ty loc in
          {env with
            contraintes = (contrainte_mut, contrainte_expr) ::
              env.contraintes}
        | Instr.DeclRead (ty, var) ->
          let ty = expand env ty loc in
          let env, ty = ty2typeContrainte env ty loc in
          let env =
            { env with locales =
                StringMap.add var ty env.locales }
          in env
        | Instr.StdinSep -> env
        | Instr.Unquote li -> assert false
    ) env instructions

let collect_contraintes e
    (funname, ty, params, instructions ) =
  let tyloc = Ast.PosMap.get (Type.Fixed.annot ty) in
  let ty = expand e ty tyloc in
  let e, ty = ty2typeContrainte e ty tyloc in
  let function_type = (List.map ((fun x ->
    let loc = Ast.PosMap.get (Type.Fixed.annot x) in
    expand e x loc) @*snd) params), ty in
  let e = { e with
    functions = StringMap.add funname function_type e.functions;
    locales = StringMap.empty
  } in
  let e = List.fold_left (fun e (name, ty) ->
    let tyloc = Ast.PosMap.get (Type.Fixed.annot ty) in
    let ty = expand e ty tyloc in
    let e, ty = ty2typeContrainte e ty tyloc in
    {e with locales = StringMap.add name ty e.locales}
  ) e params
  in
  let e = collect_contraintes_instructions e instructions ty in
  e

let empty = {
  automap = IntMap.empty;
  gamma = StringMap.empty;
  contrainteMap = IntMap.empty;
  fields = StringMap.empty;
  enum = StringMap.empty;
  functions = StringMap.empty;
  locales = StringMap.empty;
  contraintes = [];
}

let map_ty env prog =
  let map_ty ty =
    let rec f t = match Type.Fixed.unfix t with
      | Type.Auto ->
        let annot = Type.Fixed.annot t in
        let contrainte =
          try IntMap.find annot env.automap
          with Not_found ->
            error_no_auto_type env.automap annot t
        in let ty = extract_typed contrainte in f ty
      | Type.Enum ( name:: _) ->
        let (_, name) = StringMap.find name env.enum in
        Type.named name
      | Type.Struct ( ( (name, _ ):: _), _) ->
        let (_, _, name) =StringMap.find name env.fields in
        Type.named name
      | _ -> t
    in Type.Writer.Deep.map f (f ty)
  in
  let f instr =
    match Instr.unfix instr with
      | Instr.Declare (p1, ty, p2) ->
        let ty = map_ty ty in Instr.fix (Instr.Declare (p1, ty, p2) )
      | Instr.AllocArray (p1, ty, p2, p3) ->
        let ty = map_ty ty in Instr.fix (Instr.AllocArray (p1, ty, p2, p3) )
      | Instr.AllocRecord (p1, ty, p2) ->
        let ty = map_ty ty in Instr.fix (Instr.AllocRecord (p1, ty, p2) )
      | Instr.Print (ty, p1) ->
        let ty = map_ty ty in Instr.fix (Instr.Print (ty, p1) )
      | Instr.Read (ty, p1) ->
        let ty = map_ty ty in Instr.fix (Instr.Read (ty, p1) )
      | Instr.DeclRead (ty, p1) ->
        let ty = map_ty ty in Instr.fix (Instr.DeclRead (ty, p1) )
      | _ -> instr
  in
  let map_instrs instrs =
    List.map (fun i ->
      Instr.Writer.Deep.map f ( f i)
    ) instrs
  in
  let toplvl = function
    | Prog.DeclarFun (var, ty, params, instrs) ->
      let ty = map_ty ty in
      let params = List.map
        (fun (a, b) -> a, map_ty b) params
      in
      let instrs = map_instrs instrs in
      Prog.DeclarFun (var, ty, params, instrs)
    | x -> x
  in
  { prog with
    Prog.funs = List.map toplvl prog.Prog.funs;
    Prog.main = Option.map map_instrs prog.Prog.main;
  }


let not_done
    (env:env)
    ((t1 : typeContrainte ref), (t2 : typeContrainte ref)) : bool=
  match !t1, !t2 with
    | Typed (t1, loc1), Typed (t2, loc2) ->
      check_types env t1 t2 loc1 loc2;
      false
    | _ -> true

let unify_once env =
  let modified = List.fold_left (fun acc (a, b) ->
    unify env a b || acc) false env.contraintes in
  (modified ,
   {env with
     contraintes = List.filter (not_done env) env.contraintes
   }
  )

let rec unify_contraintes env =
  let modified, env = unify_once env in
  if modified
  then unify_contraintes env
  else
    match env.contraintes with
      | [] -> env
      | li ->
        begin
          error_no_contraintes li
        end

let process_fundecl e ((funname, ty, params, instructions) as tuple) =
  let e = collect_contraintes e tuple in
  unify_contraintes e

let process_tfun env p = match p with
  | Prog.DeclarFun (varname, ty, li, instrs) ->
    process_fundecl env (varname, ty, li, instrs)
  | Prog.DeclareType (name, ty) ->
    { env with
      gamma = StringMap.add name ty env.gamma;
      fields = (match (Type.Fixed.unfix ty) with
        | Type.Struct (li, _) ->
          List.fold_left
            (fun acc (fieldname, ty_field) ->
              StringMap.add fieldname (ty_field, ty, name) acc
            ) env.fields li
        | _ -> env.fields);
      enum = (match (Type.Fixed.unfix ty) with
        | Type.Enum li ->
          List.fold_left
            (fun acc fname ->
              StringMap.add fname (ty, name) acc
            ) env.enum li
        | _ -> env.enum
      )
    }
  | Prog.Macro (name, ty, params, _) ->
    let tyloc = Ast.PosMap.get (Type.Fixed.annot ty) in
    let ty = expand env ty tyloc in
    let env, ty = ty2typeContrainte env ty tyloc in
    let function_type = (List.map ((fun x ->
      let tyloc = Ast.PosMap.get (Type.Fixed.annot x) in
      expand env x tyloc) @* snd) params), ty in
    { env with functions = StringMap.add name function_type env.functions}
  | Prog.Comment _ -> env

(** {2 Main function} *)
let process (prog: 'lex Prog.t) =
  let env = List.fold_left process_tfun empty prog.Prog.funs
  in
  let env = match prog.Prog.main with
    | Some main -> process_fundecl env ("main", Type.void, [], main)
    | None -> env
  in
  let prog = map_ty env prog
  in env, prog

let type_for_enum en env =
  let (t, _) = StringMap.find en env.enum in
      t

let typename_for_enum en env =
  let (_, name) = StringMap.find en env.enum in
      name
