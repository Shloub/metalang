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

(** {2 Types} *)
type functionType = Type.t list * Type.t
(* Changer ça pour inferer les definitions de fonctions *)

type typeContrainte =
  | Unknown
  | PreTyped of typeContrainte ref Type.tofix
  | Typed of Type.t

type varType = typeContrainte ref

let rec is_typed (t : typeContrainte ref) : bool =
  match !t with
    | Unknown -> false
    | PreTyped t ->
      let out = ref true in
      Type.map (fun t -> if not (is_typed t) then out := false) t;
      !out
    | Typed t -> true


let rec extract_typed (t : typeContrainte ref) : Type.t =
  match !t with
    | Unknown -> assert false
    | PreTyped t ->
      Type.map extract_typed t |> Type.fix
    | Typed t -> t



type env =
    {
      automap : typeContrainte ref IntMap.t;
      contrainteMap : typeContrainte ref IntMap.t;
      fields : (Type.t * Type.t) StringMap.t;
      gamma : Type.t StringMap.t;
      functions : functionType StringMap.t;
      locales : varType StringMap.t;
      contraintes : (typeContrainte ref * typeContrainte ref) list;
    }

let ty2typeContrainte (env : env) (t : Type.t)
    : (env * typeContrainte ref) =
  let refenv = ref env in
  let rec f t = match Type.unfix t with
    | Type.Auto ->
      let out = ref Unknown in
      let e = !refenv in
      let () = refenv := { e with automap =
          IntMap.add (Type.annot t) out e.automap }
      in out
    | t -> ref ( PreTyped ( Type.map f t ) )
  in let t = f t in !refenv, t

(** {2 Printers} *)
let rec contr2str t =
  match t with
    | Unknown -> "*"
    | PreTyped ty -> "P_"^
      (Type.type2String (Type.map (fun t -> contr2str !t) ty))
    | Typed ty -> "T_" ^ (Type.type_t_to_string ty)

(** {2 Error reporters} *)
let error_ty t1 t2 =
  let () = Printf.printf "Cannot unify %s and %s\n%!"
    (Type.type_t_to_string t1)
    (Type.type_t_to_string t2)
  in assert false

let not_found name =
  let () = Printf.printf "Cannot find variable %s\n%!" name
  in assert false

let error_cty t1 t2 =
  let () = Printf.printf "Cannot unify %s and %s\n%!"
    (contr2str t1)
    (contr2str t2)
  in assert false

(** {2 Types anti alias-ing}*)
let expand env ty =
  let rec f ty =
    match Type.unfix ty with
      | Type.Named name ->
        StringMap.find name env.gamma
      | x -> Type.F (Type.annot ty, (Type.map f x))
  in f ty

(** {2 Unify} *)
let rec check_types env (t1:Type.t) (t2:Type.t) =
  match (Type.unfix t1), (Type.unfix t2) with
    | Type.Integer, Type.Integer -> ()
    | Type.Integer, _ -> error_ty t1 t2
    | Type.Bool, Type.Bool -> ()
    | Type.Bool, _ -> error_ty t1 t2
    | Type.String, Type.String -> ()
    | Type.String, _ -> error_ty t1 t2
    | Type.Float, Type.Float -> ()
    | Type.Float, _ -> error_ty t1 t2
    | Type.Char, Type.Char -> ()
    | Type.Char, _ -> error_ty t1 t2
    | Type.Void, Type.Void -> ()
    | Type.Void, _ -> error_ty t1 t2
    | Type.Named n, Type.Named n2 ->
      if String.equals n n2 then () else error_ty t1 t2
    | _, Type.Named n ->
      check_types env t1 (expand env t2)
    | Type.Named n, _ ->
      check_types env (expand env t1) t2
    | Type.Array t, Type.Array t2 ->
      check_types env t t2
    | Type.Struct (li, _), Type.Struct (li2, _) ->
      List.iter
        (fun (name, ty) ->
          let (_, ty2) = List.find ((String.equals name) @* fst) li2 in
          check_types env ty ty2
        ) li
    | _ -> error_ty t1 t2

let rec unify env (t1 : typeContrainte ref) (t2 : typeContrainte ref) : bool =
  (* let () =
      Printf.printf "Unify %s and %s\n" (contr2str !t1) (contr2str !t2)
    in *)
  match !t1, !t2 with
    | Typed ((Type.F (_, Type.Named _)) as t), _ ->
      begin
        t1 := Typed (expand env t);
        true
      end
    | _, Typed ((Type.F (_, Type.Named _)) as t) ->
      begin
        t2 := Typed (expand env t);
        true
      end
    | Typed tt1, Typed tt2 ->
      begin
        check_types env tt1 tt2;
        false
      end
    | Unknown, Unknown -> false
    | Unknown, _ ->
      begin
        t1 := !t2;
        true
      end
    | _, Unknown ->
      begin
        t2 := !t1;
        true
      end
    | Typed _, PreTyped _ -> unify env t2 t1
    | PreTyped _, _ when is_typed t1 ->
      begin
        t1 := Typed (extract_typed t1);
        true
      end
    | PreTyped Type.Array a1, PreTyped Type.Array a2 -> unify env a1 a2
    | PreTyped Type.Array _, PreTyped _ -> error_cty !t1 !t2
    | PreTyped (Type.Array r1), Typed (Type.F (_, Type.Array ty)) ->
      begin
        r1 := Typed ty;
        true
      end
    | PreTyped (Type.Array r1), Typed _ -> error_cty !t1 !t2
    | PreTyped (Type.Struct (li, _)), Typed (Type.F (_, Type.Struct (li2, _))) ->
      List.fold_left
        (fun acc (name, t) ->
          let (_, ty) = List.find
            ((String.equals name) @* fst)
            li2
          in acc || unify env t (ref (Typed ty))
        ) false li
    | PreTyped (Type.Struct _), Typed _ -> error_cty !t1 !t2
    | PreTyped (Type.Struct (li, _)), PreTyped (Type.Struct (li2, _)) ->
      List.fold_left
        (fun acc (name, t) ->
          let (_, t2) = List.find
            ((String.equals name) @* fst)
            li2
          in acc || unify env t t2
        ) false li
    |  PreTyped (Type.Struct _), PreTyped _ -> error_cty !t1 !t2



(** {2 Accessors}*)
let is_int env expr =
  match !(IntMap.find (Expr.annot expr) env.contrainteMap) with
    | Typed (Type.F (_, Type.Integer)) -> true
    | _ -> false

let is_float env expr =
  match !(IntMap.find (Expr.annot expr) env.contrainteMap) with
    | Typed (Type.F (_, Type.Float)) -> true
    | _ -> false



(** {2 Collect contraintes functions} *)
let rec collect_contraintes_expr env e =
  (*  let () = Format.printf "collecting expr contraintes@\n" in
      let () =
      Format.fprintf
      Format.std_formatter
      "collecting contraintes in %a@\n"
      Printer.printer#expr  e
      in*)
  let add_contrainte env c1 c2 =
    { env with
      contraintes = (c1, c2) :: env.contraintes
    } in
  let env, contrainte = match Expr.unfix e with
    | Expr.BinOp (a, (Expr.Mod
                         | Expr.BinOr
                         | Expr.BinAnd
                         | Expr.RShift
                         | Expr.LShift), b) ->
      let env, acontrainte = collect_contraintes_expr env a in
      let env, bcontrainte = collect_contraintes_expr env b in
      let env = add_contrainte env acontrainte (ref (Typed Type.integer)) in
      let env = add_contrainte env bcontrainte (ref (Typed Type.integer)) in
      env, ref (Typed Type.integer)
    | Expr.BinOp (a, (Expr.Or | Expr.And), b) ->
      let env, acontrainte = collect_contraintes_expr env a in
      let env, bcontrainte = collect_contraintes_expr env b in
      let env = add_contrainte env acontrainte (ref (Typed Type.bool)) in
      let env = add_contrainte env bcontrainte (ref (Typed Type.bool)) in
      env, ref (Typed Type.bool)
    | Expr.BinOp (a, (Expr.Lower | Expr.LowerEq | Expr.Higher | Expr.HigherEq
                         | Expr.Eq | Expr.Diff), b) ->
      let contrainte = ref (Typed Type.bool) in
      let env, acontrainte = collect_contraintes_expr env a in
      let env, bcontrainte = collect_contraintes_expr env b in
      let env = add_contrainte env acontrainte bcontrainte in
      env, contrainte

    (* Pour les autres cas, on suppose 'a -> 'a -> 'a*)
    | Expr.BinOp (a,_, b) ->
      let contrainte = ref Unknown in
      let env, acontrainte = collect_contraintes_expr env a in
      let env, bcontrainte = collect_contraintes_expr env b in
      let env = add_contrainte env acontrainte contrainte in
      let env = add_contrainte env bcontrainte contrainte in
      env, contrainte

    | Expr.UnOp (a, (Expr.Neg | Expr.BNot)) ->
      let env, acontrainte = collect_contraintes_expr env a in
      let env = add_contrainte env acontrainte (ref (Typed Type.integer)) in
      env, ref (Typed Type.integer)
    | Expr.UnOp (a, Expr.Not) ->
      let env, acontrainte = collect_contraintes_expr env a in
      let env = add_contrainte env acontrainte (ref (Typed Type.bool)) in
      env, ref (Typed Type.bool)
    | Expr.Char _ ->
      env, ref (Typed Type.char)
    | Expr.String _ ->
      env, ref (Typed Type.string)
    | Expr.Float _ ->
      env, ref (Typed Type.float)
    | Expr.Integer _ ->
      env, ref (Typed Type.integer)
    | Expr.Bool _ ->
      env, ref (Typed Type.bool)
    | Expr.Access mut ->
      collect_contraintes_mutable env mut
    | Expr.Length var ->
      (* TODO ajouter var comme étant un tableau *)
      env, ref (Typed Type.integer)
    | Expr.Call (name, li) ->
      let (args_ty, out_ty) = StringMap.find name env.functions in
      let env = List.fold_left
        (fun env (ty1, arg) ->
          let env, contrainte = collect_contraintes_expr env arg in
          let env, contrainte2 = ty2typeContrainte env ty1 in
          let env = {env with contraintes = (contrainte, contrainte2) ::
              env.contraintes} in env
        ) env (List.zip args_ty li) in
      let env, contrainte = ty2typeContrainte env out_ty in
      env, contrainte
  in
  let env = { env with
    contrainteMap = IntMap.add (Expr.annot e) contrainte env.contrainteMap }
  in
  env, contrainte

and collect_contraintes_mutable env mut =
  (*  let () = Format.printf "collecting mutable contraintes@\n" in *)
  match Mutable.unfix mut with
    | Mutable.Var name ->
      let ty =
        try
          StringMap.find name env.locales
        with Not_found ->
          not_found name
      in
      env, ty
    | Mutable.Array (mut, eli) ->
      let contrainte = ref Unknown in
      let env, contrainte_mut = collect_contraintes_mutable env mut in
      let contrainte_mut2 = ref (PreTyped (Type.Array contrainte) ) in
      let env = { env with contraintes =
          (contrainte_mut, contrainte_mut2) :: env.contraintes
                } in
      env, contrainte
    | Mutable.Dot (mut, name) ->
      let (ty_dot, ty_mut) = StringMap.find name env.fields in
      let env, contrainte = collect_contraintes_mutable env mut in
      let env, contrainte2 = ty2typeContrainte env ty_mut in
      let env, ty_dot = ty2typeContrainte env ty_dot in
      let env = {env with
        contraintes = (contrainte, contrainte2) :: env.contraintes} in
      env, ty_dot

let rec collect_contraintes_instructions env instructions ty_ret=
  (*  let () = Format.printf "collecting instructions contraintes\n" in *)
  List.fold_left
    (fun env instruction ->
      match Instr.unfix instruction with
        | Instr.Declare (var, ty, e) ->
          let ty = expand env ty in
          let env, contrainte_expr = collect_contraintes_expr env e in
          let env, contrainte_ty = ty2typeContrainte env ty in
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
          let contrainte_integer = ref (Typed Type.integer ) in
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
          let env, contrainte_out = ty2typeContrainte env ty_ret in
          let env, contrainte_expr = collect_contraintes_expr env e in
          {env with
            contraintes = (contrainte_out, contrainte_expr) ::
              env.contraintes}
        | Instr.AllocArray (var, ty, e, instrsopt) ->
          let ty = expand env ty in
          let contrainte_integer = ref (Typed Type.integer ) in
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
          let env, ty = ty2typeContrainte env ty in
          let env = {env with
            locales = StringMap.add var
              (ref (PreTyped (Type.Array ty)))
                      env.locales}
          in env
        | Instr.AllocRecord (var, ty, li) ->
          let ty = expand env ty in
          let li_type = match Type.unfix ty with
            | Type.Struct (li, _) -> li
            | _ -> assert false
          in
          let env = List.fold_left
            (fun env (name, expr) ->
              let env, c2 = collect_contraintes_expr env expr in
              let c1 = ref ( Typed( snd (List.find
                                           ((String.equals name) @* fst) li_type
              ))) in
              {env with contraintes = (c1, c2) :: env.contraintes }
            ) env li
          in
          let env, ty = ty2typeContrainte env ty in
          let env = {env with
            locales = StringMap.add var
              ty env.locales}
          in env
        | Instr.If (e, instrs1, instrs2) ->
          let contrainte_ty = ref (Typed Type.bool) in
          let env, contrainte_expr = collect_contraintes_expr env e in
          let env = {env with
            contraintes = (contrainte_ty, contrainte_expr) ::
              env.contraintes} in
          let env = collect_contraintes_instructions env instrs1 ty_ret in
          let env = collect_contraintes_instructions env instrs2 ty_ret in
          env
        | Instr.Call (f, eli) ->
          let (args, ty) = StringMap.find f env.functions in (*TODO option*)
          let void_contraint = ref (Typed Type.void) in
          let env, out_contraint = ty2typeContrainte env ty in
          let env = List.fold_left
            (fun (env:env) (arg_ty, arg_e) ->
              let env, contrainte_ty = ty2typeContrainte env arg_ty in
              let env, contrainte_e = collect_contraintes_expr env arg_e in
              {env with
                contraintes = (contrainte_e, contrainte_ty) ::
                  env.contraintes}
            ) env (List.zip args eli) in
          {env with
            contraintes = (void_contraint, out_contraint) ::
              env.contraintes}
        | Instr.Print (ty, e) ->
          let ty = expand env ty in
          let env, contrainte_ty = ty2typeContrainte env ty in
          let env, contrainte_expr = collect_contraintes_expr env e in
          {env with
            contraintes = (contrainte_ty, contrainte_expr) ::
              env.contraintes}
        | Instr.Read (ty, mut) ->
          let ty = expand env ty in
          let env, contrainte_mut = collect_contraintes_mutable env mut in
          let env, contrainte_expr = ty2typeContrainte env ty in
          {env with
            contraintes = (contrainte_mut, contrainte_expr) ::
              env.contraintes}
        | Instr.DeclRead (ty, var) ->
          let ty = expand env ty in
          let env, ty = ty2typeContrainte env ty in
          let env =
            { env with locales =
                StringMap.add var ty env.locales }
          in env
        | Instr.StdinSep -> env
    ) env instructions

let collect_contraintes e
    (funname, ty, params, instructions ) =
  let ty = expand e ty in
  let function_type = (List.map ((expand e) @*snd) params), ty in
  let e = { e with
    functions = StringMap.add funname function_type e.functions;
    locales = StringMap.empty
  } in
  let e = List.fold_left (fun env (name, ty) ->
    let ty = expand e ty in
    let env, ty = ty2typeContrainte env ty in
    {env with locales = StringMap.add name ty env.locales}
  ) e params
  in
  let e = collect_contraintes_instructions e instructions ty in
  e


let map_ty env prog =
  let map_ty ty =
    let f t = match Type.unfix t with
      | Type.Auto ->
        let annot = Type.annot t in
        begin try
                let contrainte = IntMap.find annot env.automap in
                extract_typed contrainte
          with Not_found ->
            Printf.printf "Cannot find type of auto in %s (%d) \n%!"
              (Type.type_t_to_string ty)
              annot;
            t
        end
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

(** {2 Main function} *)
let process (prog: Prog.t) =
  let not_done
      (env:env)
      ((t1 : typeContrainte ref), (t2 : typeContrainte ref)) : bool=
    match !t1, !t2 with
      | Typed t1, Typed t2 ->
        check_types env t1 t2;
        false
      | _ -> true
  in
  let unify_once env =
    let modified = List.fold_left (fun acc (a, b) ->
      unify env a b || acc) false env.contraintes in
    (modified ,
     {env with
       contraintes = List.filter (not_done env) env.contraintes
     }
    )
  in
  let rec unify_contraintes env =
    let modified, env = unify_once env in
    if modified
    then unify_contraintes env
    else
      match env.contraintes with
        | [] -> env
        | li ->
          begin
            List.iter
              (fun (a, b) ->
                Printf.printf "No contrainte to unify %s and %s\n%!"
                  (contr2str !a) (contr2str !b)
              ) li
            ; assert false
          end
  in
  let process e tuple =
    let e = collect_contraintes e tuple in
    unify_contraintes e
  in
  let empty = {
    automap = IntMap.empty;
    gamma = StringMap.empty;
    contrainteMap = IntMap.empty;
    fields = StringMap.empty;
    functions = StringMap.empty;
    locales = StringMap.empty;
    contraintes = [];
  }
  in
  let env = List.fold_left
    (fun env p -> match p with
      | Prog.DeclarFun (varname, ty, li, instrs) ->
        process env (varname, ty, li, instrs)
      | Prog.DeclareType (name, ty) ->
        { env with
          gamma = StringMap.add name ty env.gamma;
          fields = match (Type.unfix ty) with
            | Type.Struct (li, _) ->
              List.fold_left
                (fun acc (name, ty_field) ->
                  StringMap.add name (ty_field, ty) acc
                ) env.fields li
            | _ -> env.fields
        }
      | Prog.Macro (name, ty, params, _) ->
        let ty = expand env ty in
        let function_type = (List.map ((expand env ) @* snd) params), ty in
        { env with functions = StringMap.add name function_type env.functions}
      | Prog.Comment _ -> env
      | Prog.Global (name, ty, e) -> env (* TODO *)
    ) empty prog.Prog.funs
  in
  let env = match prog.Prog.main with
    | Some main -> process env ("main", Type.void, [], main)
    | None -> env
  in
  let prog = map_ty env prog
  in env, prog
