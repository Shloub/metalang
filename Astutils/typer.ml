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
(* Changer ça pour inferer les definitions de variables *)
type varType = Type.t

type typeContrainte =
  | Unknown
  | PreTyped of typeContrainte ref Type.tofix
  | Typed of Type.t

type env =
    {
      contrainteMap : typeContrainte ref IntMap.t;
      fields : (Type.t * Type.t) StringMap.t;
      gamma : Type.t StringMap.t;
      functions : functionType StringMap.t;
      locales : varType StringMap.t;
      contraintes : (typeContrainte ref * typeContrainte ref) list;
    }

(** {2 Printers} *)
let rec contr2str t =
  match t with
    | Unknown -> "*"
    | PreTyped ty -> Type.type2String (Type.map (fun t -> contr2str !t) ty)
    | Typed ty -> Type.type_t_to_string ty

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

(** {2 Unify} *)
let rec check_types (t1:Type.t) (t2:Type.t) =
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
    | Type.Array t, Type.Array t2 ->
      check_types t t2
    | Type.Struct (li, _), Type.Struct (li2, _) ->
      List.iter
        (fun (name, ty) ->
          let (_, ty2) = List.find ((String.equals name) @* fst) li2 in
          check_types ty ty2
        ) li
    | _ -> error_ty t1 t2

let rec unify (t1 : typeContrainte ref) (t2 : typeContrainte ref) : bool =
(*  let () =
    Printf.printf "Unify %s and %s\n" (contr2str !t1) (contr2str !t2)
      in *)
  match !t1, !t2 with
    | Typed tt1, Typed tt2 ->
      begin
        check_types tt1 tt2;
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
    | Typed _, PreTyped _ -> unify t2 t1
    | PreTyped
        ( (Type.Integer | Type
.Float | Type.String | Type.Char | Type.Void |
            Type.Bool | Type.Named _)
           as tt1
        ), _ ->
      begin
        t1 := Typed (Type.fix tt1);
        unify t1 t2
      end
    | PreTyped Type.Array a1, PreTyped Type.Array a2 -> unify a1 a2
    | PreTyped Type.Array _, PreTyped _ -> error_cty !t1 !t2
    | PreTyped (Type.Array r1), Typed (Type.F (Type.Array ty)) ->
      begin
        r1 := Typed ty;
        true
      end
    | PreTyped (Type.Array r1), Typed _ -> error_cty !t1 !t2
    | PreTyped (Type.Struct (li, _)), Typed (Type.F (Type.Struct (li2, _))) ->
      List.fold_left
        (fun acc (name, t) ->
          let (_, ty) = List.find
            ((String.equals name) @* fst)
            li2
          in acc || unify t (ref (Typed ty))
        ) false li
    | PreTyped (Type.Struct _), Typed _ -> error_cty !t1 !t2
    | PreTyped (Type.Struct (li, _)), PreTyped (Type.Struct (li2, _)) ->
      List.fold_left
        (fun acc (name, t) ->
          let (_, t2) = List.find
            ((String.equals name) @* fst)
            li2
          in acc || unify t t2
        ) false li
    |  PreTyped (Type.Struct _), PreTyped _ -> error_cty !t1 !t2



(** {2 Accessors}*)
let is_int env expr =
  match !(IntMap.find (Expr.annot expr) env.contrainteMap) with
    | Typed (Type.F (Type.Integer)) -> true
    | _ -> false

let is_float env expr =
  match !(IntMap.find (Expr.annot expr) env.contrainteMap) with
    | Typed (Type.F (Type.Float)) -> true
    | _ -> false

(** {2 Types anti alias-ing}*)
let expand env ty =
  let rec f ty =
    match Type.unfix ty with
    | Type.Named name ->
      StringMap.find name env.gamma
    | x -> Type.fix (Type.map f x)
  in f ty


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
          let contrainte2 = ref (Typed ty1) in
          let env = {env with contraintes = (contrainte, contrainte2) ::
              env.contraintes} in env
        ) env (List.zip args_ty li) in
      env, ref (Typed out_ty)
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
      env, ref (Typed ty)
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
      let contrainte2 = ref (Typed ty_mut) in
      let env = {env with
        contraintes = (contrainte, contrainte2) :: env.contraintes} in
      env, ref (Typed ty_dot)

let rec collect_contraintes_instructions env instructions ty_ret=
(*  let () = Format.printf "collecting instructions contraintes\n" in *)
  List.fold_left
    (fun env instruction ->
      match Instr.unfix instruction with
        | Instr.Declare (var, ty, e) ->
          let ty = expand env ty in
          let env, contrainte_expr = collect_contraintes_expr env e in
          let env = { env with locales = StringMap.add var ty env.locales } in
          let contrainte_ty = ref (Typed ty) in
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
          let env = {env with locales = StringMap.add var Type.integer
              env.locales } in
          let contrainte_integer = ref (Typed Type.integer ) in
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
          let contrainte_out = ref (Typed ty_ret) in
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
                locales = StringMap.add var Type.integer env.locales}
              in collect_contraintes_instructions env instrs ty
          in
          let env = {env with
            locales = StringMap.add var (Type.array ty) env.locales}
          in env
        | Instr.AllocRecord (var, ty, li) ->
          let ty = expand env ty in
          let li_type = match Type.unfix ty with
            | Type.Struct (li, _) -> li
            | _ -> assert false
          in
          let env = {env with
            locales = StringMap.add var ty env.locales}
          in
          let env = List.fold_left
            (fun env (name, expr) ->
              let env, c2 = collect_contraintes_expr env expr in
              let c1 = ref ( Typed( snd (List.find
                                    ((String.equals name) @* fst) li_type
              ))) in
              {env with contraintes = (c1, c2) :: env.contraintes }
            ) env li
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
           let out_contraint = ref (Typed ty) in
           let env = List.fold_left
             (fun (env:env) (arg_ty, arg_e) ->
               let contrainte_ty = ref (Typed arg_ty) in
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
           let contrainte_ty = ref (Typed ty) in
           let env, contrainte_expr = collect_contraintes_expr env e in
           {env with
             contraintes = (contrainte_ty, contrainte_expr) ::
               env.contraintes}
         | Instr.Read (ty, mut) ->
           let ty = expand env ty in
           let env, contrainte_mut = collect_contraintes_mutable env mut in
           let contrainte_expr = ref (Typed ty) in
           {env with
             contraintes = (contrainte_mut, contrainte_expr) ::
               env.contraintes}
         | Instr.DeclRead (ty, var) ->
           let ty = expand env ty in
           let env = { env with locales = StringMap.add var ty env.locales }
           in env
         | Instr.StdinSep -> env
    ) env instructions

let collect_contraintes e
    (funname, ty, params, instructions ) =
  let ty = expand e ty in
  let function_type = (List.map ((expand e) @*snd) params), ty in
  let e = { e with
    functions = StringMap.add funname function_type e.functions;
    locales = List.fold_left (fun acc (name, ty) ->
      let ty = expand e ty in
      StringMap.add name ty acc
    )
      StringMap.empty params
  } in
  let e = collect_contraintes_instructions e instructions ty in
  e

(** {2 Main function} *)
let process (prog: Prog.t) =
  let not_done ((t1 : typeContrainte ref), (t2 : typeContrainte ref)) : bool=
    let rec not_done_type t = match Type.map
        (fun x -> not_done_contrainte !x) t with
          | Type.Array t -> t
          | Type.Struct (li, _) ->
            List.exists (fun (_name, t) -> t ) li
          | _ -> false
    and not_done_contrainte = function
      | Unknown -> true
      | PreTyped t -> not_done_type t
      | Typed t -> false
    in (not_done_contrainte !t1) || (not_done_contrainte !t2)
  in
  let unify_once env =
    let modified = List.fold_left (fun acc (a, b) ->
      unify a b || acc) false env.contraintes in
    modified , {env with contraintes = List.filter not_done env.contraintes}
  in
  let rec unify_contraintes env =
    let modified, env = unify_once env in
    if modified then unify_contraintes env else env
  in
  let process e tuple =
    let e = collect_contraintes e tuple in
    unify_contraintes e
  in
  let empty = {
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
  in env
