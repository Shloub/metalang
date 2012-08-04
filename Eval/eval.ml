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
  | Nil _ -> "Nil"

let get_array = function
  | Array a -> a
  | x ->
    Printf.printf "Got %s expected array" (typeof x); assert false

let get_integer = function
  | Integer a -> a
  | x ->
    Printf.printf "Got %s expected int" (typeof x); assert false

let get_char = function
  | Char a -> a
  | x ->
    Printf.printf "Got %s expected char" (typeof x); assert false

let get_string = function
  | String a -> a
  | x ->
    Printf.printf "Got %s expected string" (typeof x); assert false

let get_bool = function
  | Bool a -> a
  | x ->
    Printf.printf "Got %s expected bool" (typeof x); assert false

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
        let mut = mut_refval env mut in
        WithEnv (fun () -> !( mut () ))
      | Expr.Length arr ->
        let mut = mut_refval env arr in
        WithEnv (fun () ->
          let a = !(mut ()) |> get_array in
          Integer (Array.length a) )
      | Expr.Call (name, params) -> (* TODO *)
        WithEnv (fun () ->
  (* Printf.printf "Call %s\n" name; *)
          let params = List.map eval_expr params in
          eval_call env name params
        )
      (*| Expr.UnOp (Integer i, Expr.BNot) -> Integer (lnot )
        | Expr.UnOp (Float i, Expr.Neg) -> Float (-. i) *)
      | Expr.UnOp (_, _) -> assert false


and  mut_refval (env:env) (mut : precompiledExpr Mutable.t)
    : unit -> result ref =
  match Mutable.unfix mut with
    | Mutable.Var v ->
      let out = StringMap.find v env.vars in fun () -> out
    | Mutable.Array (m, li) ->
      let m = mut_refval env m in
      List.fold_left
        (fun m index () ->
          (get_array (!(m ()))).(get_integer (eval_expr index))
        )
        m
        li
    | Mutable.Dot (m, field) ->
      let m = mut_refval env m in
      (fun () ->
        match !(m ()) with
          | Record map ->
            StringMap.find field map
          | x ->
            Printf.printf "Got %s expected Record" (typeof x);
            assert false
      )
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
         let (_env, f) = eval_instrs env instrs
         in let () = f () in
  (* let () = Printf.printf "nothing to return...\n%!" in *) Nil
      with Return e ->
        (* Printf.printf "Returning ..."; *) e
  with Not_found ->
    match name, paramsv with
      | "int_of_char", [param] ->
        Integer (int_of_char (get_char param))
      | "float_of_int", [param] ->
        Float (float_of_int (get_integer param))
      | _ -> failwith ("The Macro "^name^" cannot be evaluated with
    "^(string_of_int (List.length paramsv))^" arguments")
and eval_instr env (instr: (env -> precompiledExpr) Instr.t) :
    (env * (unit -> unit))
    = match Instr.unfix instr with
  | Instr.Declare (varname, _, e) ->
    let e = e env in
    let r = ref Nil in
    let env = add_in_env env varname r in
    let f () =
  (* Printf.printf "Declare %s\n" varname; *)
      r := eval_expr e
    in env, f
  | Instr.Affect (mutable_, e) ->
    let mutable_ = Mutable.map_expr (fun f -> f env) mutable_ in
    let mut = mut_refval env mutable_ in
    let e = e env in
    env, (fun () -> mut () := eval_expr e)
  | Instr.Loop (varname, e1, e2, instrs) ->
    let e1 = e1 env in
    let e2 = e2 env in
    let mut = ref Nil in
    let env = add_in_env env varname mut in
    let env, instrs = eval_instrs env instrs in
    let f () =
      let e1 = eval_expr e1 in
      let e2 = eval_expr e2 in
      let rec f e =
        let () = mut := e in
        if (get_integer e) > (get_integer e2) then ()
        else
          let () = instrs () in
          f (Integer (1 + (get_integer e)))
      in f e1
    in env, f
  | Instr.While (e, instrs) ->
    let env, instrs = eval_instrs env instrs in
    let e = e env in
    let rec f () =
      let e = eval_expr e in
      if get_bool e then
        let () = instrs ()
        in f ()
      else ()
    in env, f
  | Instr.Comment _ -> env, fun () -> ()
  | Instr.Return e ->
    let e = e env in
    env, fun () -> raise (Return (eval_expr e))
  | Instr.AllocArray (var, t, e, opt) ->
    let e = e env in
    begin match opt with
      | None ->
        let r = ref Nil in
        let env = add_in_env env var r in
        env, (fun () ->
          let len = get_integer (eval_expr e) in
          r := Array (Array.make len (ref Nil))
        )
      | Some ((name, lambda)) ->
        let rname = ref Nil in
        let env, instrs = eval_instrs env lambda in
        let rout = ref Nil in
        let env = add_in_env env var rout in
        let env = add_in_env env name rname in
        let f () =
          let len = get_integer (eval_expr e) in
          rout := Array (Array.init len (fun i ->
            let () = rname := Integer i in
            try
              instrs (); ref Nil
            with Return e -> ref e
          ))
        in env, f
    end
  | Instr.AllocRecord (var, t, fields) ->
    let fields = List.map (fun (name, e) -> name, e env) fields in
    let r = ref Nil in
    let env = add_in_env env var r in
    let f () =
      let v = StringMap.empty () in
      let v = List.fold_left
        (fun v (name, e) ->
          let e = eval_expr e in
          StringMap.add name (ref e) v
        )
        v
      fields
      in r := Record v
    in env, f
  | Instr.If (e, l1, l2) ->
    let e = e env in
    let env, l1 = eval_instrs env l1 in
    let env, l2 = eval_instrs env l2 in
    let f () =
      if get_bool (eval_expr e)
      then l1 ()
      else l2 ()
    in env, f
  | Instr.Call (funname, el) ->
    let el = List.map (fun f -> f env) el in
    let f () =
      let el = List.map eval_expr el in
      let _ = eval_call env funname el in ()
    in env, f
  | Instr.Print (t, e) ->
    let e = e env in
    let f () =
      let e = eval_expr e in
      print t e
    in env, f
  | Instr.Read (t, mut) ->
    let mut = Mutable.map_expr (fun f -> f env) mut in
    let mut = mut_refval env mut
    in env, (fun () ->
      read t (fun value -> mut () := value))
  | Instr.DeclRead (t, var) ->
    let r = ref (Obj.magic 0) in
    let env = add_in_env env var r in
    env, (fun () -> read t (fun v -> r := v))
  | Instr.StdinSep _ ->
    let f () = Scanf.scanf "%[\n \010]" (fun _ -> ()) in
    env, f
and print ty e =
  let () = match Type.unfix ty with
    | Type.Array(ty) ->
      begin
        Array.map (fun e -> print ty !e) (get_array e);
        ()
      end
    | Type.Integer -> Printf.printf "%d%!" (get_integer e)
    | Type.Char -> Printf.printf "%c%!" (get_char e)
    | Type.Bool -> if get_bool e
      then Printf.printf "True"
      else Printf.printf "False"
    | Type.String -> Printf.printf "%s%!" (get_string e)
    | _ -> failwith ("cannot print type "^(Type.type_t_to_string ty))
  in ()
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
and eval_instrs env instrs : env * (unit -> unit) =
  let env, precompiled = List.fold_left_map
    (fun env instr ->
      eval_instr env instr
    )
    env instrs
  in env, fun () -> List.iter (fun f -> f ()) precompiled

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
    | Some instrs ->
      let _, f = eval_instrs env (precompile_instrs instrs)
      in f ()
    | None -> ()
