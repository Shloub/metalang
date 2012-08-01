open Ast
open Stdlib
open Warner

module StringMap = struct
  module H = Hashtbl.Make (struct
    type t = string
    let equal = ( = )
    let hash = Hashtbl.hash
  end)

  type 'a t = 'a H.t
  let empty () = H.create 0
  let add x v h = H.add h x v ; h
  let find x h = H.find h x
end

type result =
  | Integer of int
  | Float of float
  | Bool of bool
  | Char of char
  | String of string
  | Record of result ref StringMap.t
  | Array of result ref array

let typeof = function
  | Integer _ -> "int"
  | Float _ -> "float"
  | Bool _ -> "bool"
  | Char _ -> "char"
  | String _ -> "string"
  | Record _ -> "record"
  | Array _ -> "array"

let get_array = function
  | Array a -> a
  | _ -> assert false

let get_integer = function
  | Integer a -> a
  | _ -> assert false

let get_char = function
  | Char a -> a
  | _ -> assert false

let get_string = function
  | String a -> a
  | _ -> assert false

let get_bool = function
  | Bool a -> a
  | _ -> assert false

type  env = {
  vars : result StringMap.t;
  functions : (string list * precompiledExpr Instr.t list) StringMap.t;
}
and precompiledExpr =
  | Result of result
  | WithEnv of (env -> result)

let empty_env =
  {
    vars = StringMap.empty () ;
    functions = StringMap.empty () ;
  }

let tyerr loc =
  let () = Printf.printf "Type error %a\n%!"
    ploc loc
  in assert false

let num_op loc ( + ) ( +. ) a b = match a, b with
  | Float i, Float j -> Float (i +. j)
  | Integer i, Integer j -> Integer (i + j)
  | _ -> tyerr loc
let int_op loc f a b = num_op loc f (fun _ _ -> tyerr loc) a b
let num_cmp loc f a b =
  let (<) = Obj.magic f in
  match a, b with
    | Float i, Float j -> Bool (i < j)
    | Integer i, Integer j -> Bool (i < j)
    | Bool i, Bool j -> Bool ( i < j)
    | Char i, Char j -> Bool ( i < j)
    | _ -> tyerr loc
let bool_op loc ( = ) a b = match a, b with
  | Bool i, Bool j -> Bool (i = j)
  | _ -> tyerr loc

let binop loc op a b = match op with
  | Expr.Add -> num_op loc ( + ) ( +. ) a b
  | Expr.Sub -> num_op loc ( - ) ( -. ) a b
  | Expr.Mul -> num_op loc ( * ) ( *. ) a b
  | Expr.Div -> num_op loc ( / ) ( /. ) a b
  | Expr.Mod -> int_op loc ( mod ) a b
  | Expr.LowerEq -> num_cmp loc ( <= ) a b
  | Expr.Lower -> num_cmp loc ( < ) a b
  | Expr.HigherEq -> num_cmp loc ( >= ) a b
  | Expr.Higher -> num_cmp loc ( > ) a b
  | Expr.Eq -> num_cmp loc ( = ) a b
  | Expr.Diff -> num_cmp loc ( <> ) a b
  | Expr.BinOr -> int_op loc ( lor ) a b
  | Expr.BinAnd -> int_op loc ( land ) a b
  | Expr.RShift -> int_op loc ( lsr ) a b
  | Expr.LShift -> int_op loc ( lsl ) a b
  | Expr.Or -> bool_op loc ( || ) a b
  | Expr.And -> bool_op loc ( && ) a b

let find_in_env (env:env) v : result =
  StringMap.find v env.vars

let add_in_env (env:env) v (r : result) =
  {env with vars = StringMap.add v r env.vars}



let eval_expr env (e : precompiledExpr) : result = match e with
  | Result r -> r
  | WithEnv f -> f env

let rec precompile_expr (t:Parser.token Expr.t) : precompiledExpr =
  let loc = PosMap.get (Expr.Fixed.annot t) in
  let res x = Result x in
  match Expr.Fixed.map (precompile_expr)
    (Expr.Fixed.unfix t) with
      | Expr.Char c -> Char c |> res
      | Expr.String s -> String s |> res
      | Expr.Integer i -> Integer i |> res
      | Expr.Float f -> Float f |> res
      | Expr.Bool b -> Bool b |> res
      | Expr.BinOp (Result a, op, Result b) ->
        binop loc op a b |> res
      | Expr.BinOp (Result a, op, WithEnv b) ->
        WithEnv (fun (env:env) ->
          binop loc op a (b env)
        )
      | Expr.BinOp (WithEnv a, op, Result b) ->
        WithEnv (fun (env:env) ->
          binop loc op (a env) b
        )
      | Expr.BinOp (WithEnv a, op, WithEnv b) ->
        WithEnv (fun (env:env) ->
          binop loc op (a env) (b env)
        )
      | Expr.UnOp (Result r, Expr.Neg) ->
        Integer (- (get_integer r  ) ) |>  res
      | Expr.UnOp (WithEnv f, Expr.Neg) ->
        WithEnv (fun (env:env) ->
          Integer (- (get_integer (f env ) ) )
        )
      | Expr.UnOp (Result r, Expr.Not) ->
        Bool (not (get_bool r ) ) |> res
      | Expr.UnOp (WithEnv f, Expr.Not) ->
        WithEnv (fun (env:env) ->
          Bool (not (get_bool (f env) ) )
        )
      | Expr.Access mut ->
        WithEnv (fun (env:env) -> eval_mut env mut )
      | Expr.Length arr ->
        WithEnv (fun (env:env) ->
          let a = eval_mut env arr |> get_array in
          Integer (Array.length a) )
      | Expr.Call (name, params) ->
        WithEnv (fun (env:env) ->
          let params = List.map (eval_expr env) params in
          eval_call env name params |> Option.extract
        )
      (*| Expr.UnOp (Integer i, Expr.BNot) -> Integer (lnot )
        | Expr.UnOp (Float i, Expr.Neg) -> Float (-. i) *)
      | Expr.UnOp (_, _) -> assert false


and  mut_refval (env:env) (mut : precompiledExpr Mutable.t)
    : result ref option =
  match Mutable.unfix mut with
    | Mutable.Var v ->
      None
    | Mutable.Array (m, li) ->
      let m = eval_mut env m in
      Some (List.fold_left
              (fun m index ->
                (get_array (!m)).(get_integer (eval_expr env index))
              )
              (ref m)
              li)
    | Mutable.Dot (m, field) ->
      begin match eval_mut env m with
        | Record map ->
          Some (StringMap.find field map)
        | _ -> assert false
      end
and eval_mut (env:env) (mut : precompiledExpr Mutable.t) : result =
  match Mutable.unfix mut with
    | Mutable.Var v ->
      find_in_env env v
    | _ -> !(mut_refval env mut |> Option.extract)
and eval_call env name paramsv =
  try
    let (params, instrs) = StringMap.find name env.functions in
    let env = List.fold_left
      (fun env (name, value) ->
        add_in_env env name value
      )
      { env with vars = StringMap.empty () }
      (List.combine params paramsv)
    in let env, val_ = eval_instrs env instrs in val_
  with Not_found ->
    match name, paramsv with
      | "int_of_char", [param] ->
        Some (Integer (int_of_char (get_char param) ))
      | "float_of_int", [param] ->
        Some (Float (float_of_int (get_integer param) ))
      | _ -> failwith ("The Macro "^name^" cannot be evaluated with
    "^(string_of_int (List.length paramsv))^" arguments")
and eval_instr env (instr: precompiledExpr Instr.t)
    = match Instr.unfix instr with
  | Instr.Declare (varname, _, e) ->
    let e = eval_expr env e in
    let env = add_in_env env varname e in
    env, None
  | Instr.Affect (mutable_, e) ->
    let e () = eval_expr env e in
    let env = match Mutable.unfix mutable_ with
      | Mutable.Var v -> add_in_env env v (e ())
      | _ -> match mut_refval env mutable_ with
            | None -> assert false
            | Some x -> let () = x := e () in env
    in env, None
  | Instr.Loop (varname, e1, e2, instrs) ->
    let e1 = eval_expr env e1 in
    let e2 = eval_expr env e2 in
    let rec f env e =
      if (get_integer e) > (get_integer e2) then env, None
      else
        let env = add_in_env env varname e in
        let env, opt = eval_instrs env instrs in
        match opt with
          | Some _ -> env, opt
          | None -> f env (Integer (1 + (get_integer e)))
    in f env e1
  | Instr.While (e, instrs) ->
    let rec f env =
      let e = eval_expr env e in
      if get_bool e then
        match eval_instrs env instrs with
          | (env, None) -> f env
          | (env, Some v) -> env, Some v
      else env, None
    in f env
  | Instr.Comment _ -> env, None
  | Instr.Return e -> env, Some (eval_expr env e)
  | Instr.AllocArray (var, t, e, opt) ->
    let len = get_integer (eval_expr env e) in
    let v = match opt with
      | None -> Array.make len (Obj.magic 0)
      | Some ((name, lambda)) ->
        Array.init len (fun i ->
          let env = add_in_env env name (Integer i) in
          match eval_instrs env lambda with
            | _, None -> assert false
            | _, Some e -> ref e
        )
    in
    let v = Array v
    in (add_in_env env var v), None
  | Instr.AllocRecord (var, t, fields) ->
    let v = StringMap.empty () in
    let v = List.fold_left
      (fun v (name, e) ->
        let e = eval_expr env e in
        StringMap.add name (ref e) v
      )
      v
      fields
    in let v = Record v
    in (add_in_env env var v), None
  | Instr.If (e, l1, l2) ->
    let e = eval_expr env e in
    if get_bool e
    then eval_instrs env l1
    else eval_instrs env l2
  | Instr.Call (funname, el) ->
    let el = List.map (eval_expr env) el in
    let _ = eval_call env funname el in
    env, None
  | Instr.Print (t, e) ->
    let e = eval_expr env e in
    print env t e
  | Instr.Read (t, mut) ->
    let f value =
      let env =
        match Mutable.unfix mut with
          | Mutable.Var v -> add_in_env env v value
          | _ -> match mut_refval env mut with
              | None -> assert false
              | Some x -> let () = x := value in env
      in env, None
    in read t f
  | Instr.DeclRead (t, var) ->
    read t (fun v ->
      add_in_env env var v, None)
  | Instr.StdinSep _ ->
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    env, None
and print env ty e =
  let () = match Type.unfix ty with
    | Type.Array(ty) ->
      begin
        Array.map (fun e -> print env ty !e) (get_array e);
        ()
      end
    | Type.Integer -> Printf.printf "%d%!" (get_integer e)
    | Type.Char -> Printf.printf "%c%!" (get_char e)
    | Type.Bool -> if get_bool e
      then Printf.printf "True"
      else Printf.printf "False"
    | Type.String -> Printf.printf "%s%!" (get_string e)
    | _ -> failwith ("cannot print type "^(Type.type_t_to_string ty))
    in (env , None)
and read ty k = match Type.unfix ty with
  | Type.Integer ->
    Scanf.scanf "%d" (fun x ->
      k (Integer x)
    )
  | Type.Char ->
    Scanf.scanf "%c" (fun x ->
      k (Char x)
    )
  | _ -> failwith ("cannot read type "^(Type.type_t_to_string ty))
and eval_instrs env instrs =
(*  let () = match instrs with
    | hd::tl -> Printf.printf
        "eval %a\n%!" ploc (PosMap.get (Instr.annot hd ))
    | [] -> ()
    in *)
      List.fold_left
        (fun (env, ret) instr ->
          match ret with
            | Some _ -> (env, ret)
            | None -> eval_instr env instr
        )
        (env, None) instrs

let rec precompile_instrs li =
  List.map precompile_instr li
and precompile_instr i =
  let i = match Instr.unfix i with
    | Instr.Declare (v, t, e) -> Instr.Declare (v, t, precompile_expr e)
    | Instr.Affect (mut, e) -> Instr.Affect (Mutable.map_expr precompile_expr
                                               mut, precompile_expr e)
    | Instr.Loop (v, e1, e2, li) ->
      Instr.Loop (v,
                  precompile_expr e1,
                  precompile_expr e2,
                  precompile_instrs li)
    | Instr.While (e, li) ->
      Instr.While (precompile_expr e, precompile_instrs li)
    | Instr.Comment s -> Instr.Comment s
    | Instr.Return e -> Instr.Return (precompile_expr e)
    | Instr.AllocArray (v, t, e, opt) ->
      let opt = match opt with
        | None -> None
        | Some ((v, li)) -> Some (v, precompile_instrs li)
      in Instr.AllocArray(v, t, precompile_expr e, opt)
    | Instr.AllocRecord (v, t, li) ->
      let li = List.map
        (fun (name, e) -> (name, precompile_expr e)) li
      in Instr.AllocRecord (v, t, li)
    | Instr.If (e, l1, l2) ->
      Instr.If (precompile_expr e, precompile_instrs l1, precompile_instrs l2)
    | Instr.Call (name, li) -> Instr.Call (name, List.map precompile_expr li)
    | Instr.Print (t, e) -> Instr.Print (t, precompile_expr e)
    | Instr.Read (t, mut) -> Instr.Read (t, Mutable.map_expr precompile_expr mut)
    | Instr.DeclRead (t, v) -> Instr.DeclRead (t, v)
    | Instr.StdinSep -> Instr.StdinSep
  in Instr.Fixed.fix i

let eval_prog (p:Parser.token Prog.t) =
  let f env p = match p with
    | Prog.DeclarFun (var, t, li, instrs) ->
      {env with functions =
          StringMap.add var
            (List.map fst li, precompile_instrs instrs)
            env.functions
      }
    | Prog.DeclareType _ -> env
    | Prog.Macro (varname, t, li, impls) -> env
    | Prog.Comment s -> env
    | Prog.Global (var, ty, e) -> env (* TODO *)
  in let env = List.fold_left f empty_env p.Prog.funs
  in match p.Prog.main with
    | Some instrs -> eval_instrs env (precompile_instrs instrs)
    | None -> env, None
