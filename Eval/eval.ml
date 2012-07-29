open Ast
open Stdlib
open Warner

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
  functions : (string list * Parser.token Instr.t list) StringMap.t;
}

let empty_env =
  {
    vars = StringMap.empty;
    functions = StringMap.empty;
  }

let tyerr loc =
  let () = Printf.printf "Type error %a\n%!"
    ploc loc
  in assert false

let num_op loc ( + ) ( +. ) a b = match a, b with
  | Float i, Float j -> Float (i +. j)
  | Integer i, Integer j -> Integer (i + j)
  | Integer i, Float j -> Float (float_of_int i +. j)
  | Float i, Integer j -> Float (i +. float_of_int j)
  | _ -> tyerr loc
let int_op loc f = num_op loc f (fun _ _ -> tyerr loc)
let num_cmp loc ( < ) a b = match a, b with
  | Float i, Float j -> Bool (i < j)
  | Integer i, Integer j -> Bool (float_of_int i < float_of_int j)
  | Integer i, Float j -> Bool (float_of_int i < j)
  | Float i, Integer j -> Bool (i < float_of_int j)
  | Bool i, Bool j -> Bool (float_of_bool i < float_of_bool j)
  | Char i, Char j -> Bool (float_of_char i < float_of_char j)
  | _ -> tyerr loc
let bool_op loc ( = ) a b = match a, b with
  | Bool i, Bool j -> Bool (i = j)
  | _ -> tyerr loc

let binop loc = function
  | Expr.Add -> num_op loc ( + ) ( +. )
  | Expr.Sub -> num_op loc ( - ) ( -. )
  | Expr.Mul -> num_op loc ( * ) ( *. )
  | Expr.Div -> num_op loc ( / ) ( /. )
  | Expr.Mod -> int_op loc ( mod )

  | Expr.LowerEq -> num_cmp loc ( <= )
  | Expr.Lower -> num_cmp loc ( < )
  | Expr.HigherEq -> num_cmp loc ( >= )
  | Expr.Higher -> num_cmp loc ( > )
  | Expr.Eq -> num_cmp loc ( = )
  | Expr.Diff -> num_cmp loc ( <> )

  | Expr.BinOr -> int_op loc ( lor )
  | Expr.BinAnd -> int_op loc ( land )
  | Expr.RShift -> int_op loc ( lsr )
  | Expr.LShift -> int_op loc ( lsl )

  | Expr.Or -> bool_op loc ( || )
  | Expr.And -> bool_op loc ( && )

let find_in_env (env:env) v : result =
  StringMap.find v env.vars
let add_in_env (env:env) v (r : result) =
  {env with vars = StringMap.add v r env.vars}


let rec mut_refval (env:env) (mut : result Mutable.t)
    : result ref option =
  match Mutable.unfix mut with
    | Mutable.Var v ->
      None
    | Mutable.Array (m, li) ->
      let m = eval_mut env m in
      Some (List.fold_left
              (fun m index ->
                (get_array (!m)).(get_integer index)
              )
              (ref m)
              li)
    | Mutable.Dot (m, field) ->
      begin match eval_mut env m with
        | Record map ->
          Some (StringMap.find field map)
        | _ -> assert false
      end
and eval_mut (env:env) (mut : result Mutable.t) : result =
  match Mutable.unfix mut with
    | Mutable.Var v ->
      find_in_env env v
    | _ -> !(mut_refval env mut |> Option.extract)
and exprmut_to_resmut env mut =
  Mutable.map_expr (eval_expr env) mut
and eval_expr (env:env) (t:Parser.token Expr.t) =
  let loc = PosMap.get (Expr.annot t) in
  match Expr.map (eval_expr env) (Expr.unfix t) with
    | Expr.Char c -> Char c
    | Expr.String s -> String s
    | Expr.Integer i -> Integer i
    | Expr.Float f -> Float f
    | Expr.Bool b -> Bool b
    | Expr.Access mut -> eval_mut env mut
    | Expr.Length arr ->
      let a = eval_mut env arr |> get_array in
      Integer (Array.length a)
    | Expr.Call (name, params) ->
      eval_call env name params |> Option.extract
    | Expr.BinOp (a, op, b) -> binop loc op a b
    | Expr.UnOp (Integer i, Expr.Neg) -> Integer (-i)
    | Expr.UnOp (Bool i, Expr.Not) -> Bool (not i)
    | Expr.UnOp (Integer i, Expr.BNot) -> Integer (lnot i)
    | Expr.UnOp (Float i, Expr.Neg) -> Float (-. i)
    | Expr.UnOp (_, _) -> assert false
and eval_call env name paramsv =
  try
    let (params, instrs) = StringMap.find name env.functions in
    let env = List.fold_left
      (fun env (name, value) ->
        add_in_env env name value
      )
      env
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
and eval_instr env instr = match Instr.unfix instr with
  | Instr.Declare (varname, _, e) ->
    let e = eval_expr env e in
    let env = add_in_env env varname e in
    env, None
  | Instr.Affect (mutable_, e) ->
    let e () = eval_expr env e in
    let env = match Mutable.unfix mutable_ with
      | Mutable.Var v -> add_in_env env v (e ())
      | _ -> match mut_refval env
          (exprmut_to_resmut env mutable_) with
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
    let v = StringMap.empty in
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
          | _ -> match mut_refval env (exprmut_to_resmut env mut) with
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

let eval_prog (p:Parser.token Prog.t) =
  let f env p = match p with
    | Prog.DeclarFun (var, t, li, instrs) ->
      {env with functions =
          StringMap.add var
            (List.map fst li, instrs)
            env.functions
      }
    | Prog.DeclareType _ -> env
    | Prog.Macro (varname, t, li, impls) -> env
    | Prog.Comment s -> env
    | Prog.Global (var, ty, e) -> env (* TODO *)
  in let env = List.fold_left f empty_env p.Prog.funs
  in match p.Prog.main with
    | Some instrs -> eval_instrs env instrs
    | None -> env, None
