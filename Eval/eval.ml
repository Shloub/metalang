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
  | Nil

exception Return of result

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

let get_integer = function
  | Integer a -> a

let get_char = function
  | Char a -> a

let get_string = function
  | String a -> a

let get_bool = function
  | Bool a -> a

type  env = {
  vars : result ref StringMap.t;
  functions : (string list * (env -> precompiledExpr) Instr.t list) StringMap.t;
}

and precompiledExpr =
  | Result of result
  | WithEnv of (unit -> result)

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

let find_in_env (env:env) v : result ref =
  StringMap.find v env.vars

let add_in_env (env:env) v (r : result ref) =
  {env with vars = StringMap.add v r env.vars}

let eval_expr (e : precompiledExpr) : result = match e with
  | Result r -> r
  | WithEnv f -> f ()

let rec precompile_expr (t:Parser.token Expr.t) (env:env): precompiledExpr =
  let loc = PosMap.get (Expr.Fixed.annot t) in
  let res x = Result x in
  match Expr.Fixed.map (fun e -> precompile_expr e env)
    (Expr.Fixed.unfix t) with
      | Expr.Char c -> Char c |> res
      | Expr.String s -> String s |> res
      | Expr.Integer i -> Integer i |> res
      | Expr.Float f -> Float f |> res
      | Expr.Bool b -> Bool b |> res
      | Expr.BinOp (Result a, op, Result b) ->
        binop loc op a b |> res
      | Expr.BinOp (Result a, op, WithEnv b) ->
        WithEnv (fun () ->
          binop loc op a (b ())
        )
      | Expr.BinOp (WithEnv a, op, Result b) ->
        WithEnv (fun () ->
          binop loc op (a ()) b
        )
      | Expr.BinOp (WithEnv a, op, WithEnv b) ->
        WithEnv (fun () ->
          binop loc op (a ()) (b ())
        )
      | Expr.UnOp (Result r, Expr.Neg) ->
        Integer (- (get_integer r  ) ) |>  res
      | Expr.UnOp (WithEnv f, Expr.Neg) ->
        WithEnv (fun () ->
          Integer (- (get_integer (f ())))
        )
      | Expr.UnOp (Result r, Expr.Not) ->
        Bool (not (get_bool r ) ) |> res
      | Expr.UnOp (WithEnv f, Expr.Not) ->
        WithEnv (fun () ->
          Bool (not (get_bool (f ())))
        )
      | Expr.Access mut ->
        WithEnv (fun () -> !(mut_refval env mut))
      | Expr.Length arr ->
        WithEnv (fun () ->
          let a = !(mut_refval env arr) |> get_array in
          Integer (Array.length a) )
      | Expr.Call (name, params) ->
        WithEnv (fun () ->
          let params = List.map eval_expr params in
          eval_call env name params
        )
      (*| Expr.UnOp (Integer i, Expr.BNot) -> Integer (lnot )
        | Expr.UnOp (Float i, Expr.Neg) -> Float (-. i) *)
      | Expr.UnOp (_, _) -> assert false


and  mut_refval (env:env) (mut : precompiledExpr Mutable.t)
    : result ref =
  match Mutable.unfix mut with
    | Mutable.Var v ->
      StringMap.find v env.vars
    | Mutable.Array (m, li) ->
      let m = mut_refval env m in
      List.fold_left
        (fun m index ->
          (get_array (!m)).(get_integer (eval_expr index))
        )
        m
        li
    | Mutable.Dot (m, field) ->
      begin match !(mut_refval env m) with
        | Record map ->
          StringMap.find field map
        | _ -> assert false
      end
and eval_call env name paramsv =
  try
    let (params, instrs) = StringMap.find name env.functions in
    let env = List.fold_left
      (fun env (name, value) ->
        add_in_env env name (ref value)
      )
      { env with vars = StringMap.empty () }
      (List.combine params paramsv)
    in try
         let _ = eval_instrs env instrs in Nil
      with Return e -> e
  with Not_found ->
    match name, paramsv with
      | "int_of_char", [param] ->
        Integer (int_of_char (get_char param))
      | "float_of_int", [param] ->
        Float (float_of_int (get_integer param))
      | _ -> failwith ("The Macro "^name^" cannot be evaluated with
    "^(string_of_int (List.length paramsv))^" arguments")
and eval_instr env (instr: (env -> precompiledExpr) Instr.t) : env
    = match Instr.unfix instr with
  | Instr.Declare (varname, _, e) ->
    let e = e env in
    let e = ref (eval_expr e) in
    let env = add_in_env env varname e in
    env
  | Instr.Affect (mutable_, e) ->
    let e = e env in
    let mutable_ = Mutable.map_expr (fun f -> f env) mutable_ in
    let e () = eval_expr e in
    let mut = mut_refval env mutable_
    in mut := e (); env
  | Instr.Loop (varname, e1, e2, instrs) ->
    let e1 = eval_expr (e1 env) in
    let e2 = eval_expr (e2 env) in
    let mut = ref e1 in
    let env = add_in_env env varname mut in
    let rec f env e =
      let () = mut := e in
      if (get_integer e) > (get_integer e2) then env
      else
        let env = eval_instrs env instrs in
        f env (Integer (1 + (get_integer e)))
    in f env e1
  | Instr.While (e, instrs) ->
    let e = e env in
    let rec f env =
      let e = eval_expr e in
      if get_bool e then
        let env = eval_instrs env instrs
        in f env
      else env
    in f env
  | Instr.Comment _ -> env
  | Instr.Return e ->
    let e = e env in
    raise (Return (eval_expr e))
  | Instr.AllocArray (var, t, e, opt) ->
    let e = e env in
    let len = get_integer (eval_expr e) in
    let v = match opt with
      | None -> Array.make len (ref Nil)
      | Some ((name, lambda)) ->
        let r = ref (Integer 0) in
        let env = add_in_env env name r in
        Array.init len (fun i ->
          let () = r := Integer i in
          try
            eval_instrs env lambda;
            ref Nil
          with Return e -> ref e
        )
    in
    let v = ref (Array v)
    in add_in_env env var v
  | Instr.AllocRecord (var, t, fields) ->
    let fields = List.map (fun (name, e) -> name, e env) fields in
    let v = StringMap.empty () in
    let v = List.fold_left
      (fun v (name, e) ->
        let e = eval_expr e in
        StringMap.add name (ref e) v
      )
      v
      fields
    in let v = ref (Record v)
    in add_in_env env var v
  | Instr.If (e, l1, l2) ->
    let e = e env in
    let e = eval_expr e in
    if get_bool e
    then eval_instrs env l1
    else eval_instrs env l2
  | Instr.Call (funname, el) ->
    let el = List.map (fun f -> f env) el in
    let el = List.map eval_expr el in
    let _ = eval_call env funname el in
    env
  | Instr.Print (t, e) ->
    let e = e env in
    let e = eval_expr e in
    print env t e
  | Instr.Read (t, mut) ->
    let mut = Mutable.map_expr (fun f -> f env) mut in
    let f value =
      let () = (mut_refval env mut) := value
      in env
    in read t f
  | Instr.DeclRead (t, var) ->
    let r = ref (Obj.magic 0) in
    let env = add_in_env env var r in
    read t (fun v ->
      let () = r := v in
      env)
  | Instr.StdinSep _ ->
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    env
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
    in env
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
and eval_instrs env instrs : env =
      List.fold_left
        (fun env instr ->
          eval_instr env instr
        )
        env instrs

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
    | None -> env
