(*
 * Copyright (c) 2015, Prologin
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

(** FSharp Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast


let ptype f (t : Ast.Type.t ) = OcamlFunPrinter.ptype f t
       

let print_lief f l =
  let open Ast.Expr in let open Format in match l with
  | Char c -> fprintf f "%C" c
  | String s -> fprintf f "%S" s
  | Integer i -> fprintf f "%i" i
  | Bool true -> fprintf f "true"
  | Bool false -> fprintf f "false"
  | Enum s -> fprintf f "%s" s

let prio_arg = -105
let prio_tuple = -103
let prio_apply = -101

let print_op f op = 
  let open Ast.Expr in Format.fprintf f "%s" (match op with
  | Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"
  | Mod -> "%"
  | Or -> "||"
  | And -> "&&"
  | Lower -> "<"
  | LowerEq -> "<="
  | Higher -> ">"
  | HigherEq -> ">="
  | Eq -> "="
  | Diff -> "<>")

let print_mut0 refbindings m f () =
  let open Format in
  let open Ast.Expr in
  let open Mutable in
  match m with
  | Var v ->
     if BindingSet.mem v refbindings
     then fprintf f "(!%a)" print_varname v
     else print_varname f v
  | Array (m, fi) -> fprintf f "%a%a" m ()
                             (print_list (fun f a -> fprintf f ".[%a]" a nop) (sep "%a%a")) fi
  | Dot (m, field) -> fprintf f "%a.%s" m () field

let print_mut refbindings f m = Mutable.Fixed.Deep.fold (print_mut0 refbindings) m f ()

let pcall macros f prio_parent func li =
  match StringMap.find_opt func macros with
  | Some ( (t, params, code) ) ->
     pmacros f "(%s)" t params code li nop
  | None ->
     if li = [] then parens prio_parent prio_apply f "%s ()" func
     else parens prio_parent prio_apply f "%s %a" func (print_list (fun f x -> x f prio_arg) sep_space) li

let print_expr refbindings macros e f p =
  let open Format in
  let open Ast.Expr in
  let print_expr0 e f prio_parent = match e with
  | BinOp (a, op, b) ->
      let prio, priol, prior = prio_binop op in
      parens prio_parent prio f "%a %a %a" a priol print_op op b prior
  | UnOp (a, op) ->
      parens prio_arg prio_apply f "%s %a" (OcamlFunPrinter.unopstr op) a prio_arg

  | Lief l -> print_lief f l
  | Access m -> print_mut refbindings f m
  | Call (func, li) -> pcall macros f prio_parent func li
  | Lexems li -> assert false
  | Tuple li -> fprintf f "(%a)" (print_list (fun f x -> x f nop) sep_c) li
  | Record li -> fprintf f "{%a}" (print_list (fun f (name, x) ->
      fprintf f "%s=%a" name x nop) (sep "%a;@\n%a")) li
  in Fixed.Deep.fold print_expr0 e f p

type pinstr_acc = { p: Format.formatter -> bool -> Ast.Type.t -> unit;
                    need_unit : bool;
                    is_comment : bool;
                    is_return : bool;
                    is_sad_return : bool;
                  }

let collect_return acc li =
  let f f acc i = match Instr.unfix i with
  | Instr.Return e -> IntSet.add (Expr.Fixed.annot e) acc
  | Instr.AllocArray _ -> acc
  | _ -> f acc i
  in List.fold_left (f (Instr.Writer.Traverse.fold f)) acc li

(** returns true if a list of instructions contains a return *)
let contains_return li =
  let f f acc i = match Instr.unfix i with
  | Instr.Return e -> true
  | Instr.AllocArray _ -> acc
  | _ -> f acc i
  in List.fold_left (f (Instr.Writer.Traverse.fold f)) false li

let nocomment li =
  List.filter (fun i -> match Instr.unfix i with
  | Instr.Comment _ -> false
  | _ -> true ) li

(** returns true if a list of instructions contains a return that
    ocaml cannot execute (it's compiled into an exception) *)
let rec collect_sad_return acc instrs =
  let rec f tra acc i = match Instr.unfix i with
    | Instr.AllocArray _ -> acc (* c'est interdit par d'autres passes *)
    | Instr.Loop(_, _, _, li) -> collect_return acc li
    | Instr.While (_, li) -> collect_return acc li
    | Instr.If (_, li1, li2) ->
        let cli1 = contains_return li1
        and cli2 = contains_return li2 in
        if (cli1 && not cli2 ) || (cli2 && not cli1) then
          collect_return (collect_return acc li2) li1
        else
          let acc = collect_sad_return acc li1 in
          let acc = collect_sad_return acc li2 in
          acc
    | _ -> tra acc i
  in
  match List.rev (nocomment instrs) with
  | hd::tl ->
      let acc = f (Instr.Writer.Traverse.fold f) acc hd in
      collect_return acc tl
  | [] -> acc

let collect_sad_return instrs = collect_sad_return IntSet.empty instrs
let contains_sad_return instrs = IntSet.empty <> collect_sad_return instrs
let collect_sad_returns ty instrs =
  let add acc l type_ =
    if contains_sad_return l then TypeSet.add type_ acc
    else acc
  in
  let rec f tra acc i = match Instr.unfix i with
    | Instr.AllocArray (_binding, type_, _len, Some (_b, l), _) ->
      add (tra acc i) l type_
    | _ -> tra acc i
  in List.fold_left (f (Instr.Writer.Traverse.fold f))
  (add TypeSet.empty instrs ty)
  instrs

                  
let instructions sad_returns current_etype f li =
  let li, _, united, _ = List.fold_left (fun (acc, returned, united, askunit) i ->
                  if i.is_comment then
                    (fun f -> i.p f sad_returns current_etype)::acc, returned, united, askunit
                  else (fun f -> i.p f returned current_etype)::acc,
                       true, (if askunit then not i.need_unit else united), false
                ) ([], sad_returns, false, true) (List.rev li) in
  Format.fprintf f (if united then "%a" else "%a@\n()") (print_list (fun f i -> i f) sep_nl) li

let print_instr printed_exn refbindings macros i =
  let open Ast.Instr in
  let open Format in
  let print_exnName f (t : unit Type.Fixed.t) =
    try
      Format.fprintf f "%s" (TypeMap.find t printed_exn)
    with Not_found ->
      Format.fprintf f "NOT_FOUND_%a" ptype t
  in
  let print_mut f m = print_mut refbindings f m in
  let print_mut_set f m = match Mutable.Fixed.unfix m with
       | Mutable.Var var ->
          if BindingSet.mem var refbindings
          then fprintf f "@[<h>%a@ :=@]" print_varname var
          else fprintf f "@[<h>let %a@ =@]" print_varname var
      | _ ->
         Format.fprintf f "@[<h>%a@ <-@]"
                        print_mut m
  in
  let read_ty f t =
    match Type.unfix t with
    | Type.Integer -> Format.fprintf f "readInt()"
    | Type.Char -> Format.fprintf f "readChar()"
    | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Type.type_t_to_string t))) in

  let is_list_return li =
    match List.filter (fun i -> not i.is_comment) li |> List.rev with
    | i::_ -> i.is_return
    | [] -> false in
  let sad_returns_list li =
    match List.filter (fun i -> not i.is_comment) li |> List.rev with
    | i::tl -> i.is_return && not i.is_sad_return && List.for_all (fun e -> not i.is_return && not i.is_sad_return) tl
    | [] -> false in
    
  let p f sad_returns current_etype =
    match i with
    | Declare (var, ty, e, _) ->
       fprintf f (if BindingSet.mem var refbindings then "@[<h>let %a@ =@ ref(@ %a )@]"
                  else "@[<h>let %a@ =@ %a@]")
               print_varname var e nop
               
    | AllocArray (name, t, e, None, opt) -> assert false
    | AllocArray (name, t, len, Some (var, lambda), opt) ->
       let b = BindingSet.mem name refbindings in
       Format.fprintf f "@[<h>let %a@ =@ %aArray.init@ %a@ (fun@ %a@ ->%a@\n@[<v 2>  %a%a@])%a@]"
                      print_varname name
                      (fun t () ->
                        if b then
                          Format.fprintf t "ref(@ "
                      ) ()
                      len prio_arg
                      print_varname var
                      (fun f () ->
                        if sad_returns_list lambda then Format.fprintf f "@ try@\n"
                      ) ()
                      (instructions false t) lambda
                      (fun f () ->
                        if sad_returns_list lambda then Format.fprintf f "@\nwith %a@ out -> out@\n"
                                                                           print_exnName t
                      ) ()
                      (fun t () ->
                        if b then
                          Format.fprintf t ")"
                      ) ()
       | AllocArrayConst (name, ty, len, lief, opt) -> assert false (*TODO *)
       | AllocRecord (name, ty, list, opt) ->
          let b = BindingSet.mem name refbindings in
          Format.fprintf f (if b then "let %a = ref {@\n@[<v 2>  %a@]@\n}"
                            else "let %a = {@\n@[<v 2>  %a@]@\n}")
      print_varname name
      (print_list
      (fun f (fieldname, expr) -> fprintf f "@[<h>%s=%a;@]" fieldname expr nop) sep_nl) list
       | Print li->
          let lili = List.pack 50 li |>
                       List.map (fun li f ->
                           let format, exprs = extract_multi_print clike_noformat format_type li in
                            match exprs with
                           | [] -> fprintf f "Printf.printf \"%s\"" format
                           | _ -> fprintf f "Printf.printf \"%s\" %a" format
                                          (print_list (fun f (t, e) -> e f prio_arg) sep_space) exprs
                         )
          in print_list (fun f i -> i f) sep_nl f lili
    | Return e -> if sad_returns then
                    fprintf f "@[<h>raise (%a(%a))@]" print_exnName current_etype e nop
                  else e f nop
    | Read li ->
       print_list
          (fun f -> function
            | Separation -> fprintf f "@[stdin_sep()@]"
            | DeclRead (ty, v, opt) ->
               if BindingSet.mem v refbindings
               then fprintf f "@[let %a = ref (%a)@]" print_varname v read_ty ty
               else fprintf f "@[let %a = %a@]" print_varname v read_ty ty
            | ReadExpr (ty, m) -> fprintf f "@[%a %a@]" print_mut_set m read_ty ty
          ) sep_nl f li
    | Affect (m, e) ->fprintf f "@[<h>%a@ %a@]" print_mut_set m e nop
      | Untuple (li, expr, opt) -> fprintf f "@[<h>let (%a) = %a@]"
                                           (print_list print_varname sep_c) (List.map snd li)
                                           expr nop
      | If (e, iftrue, []) ->
         fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]" e nop (instructions true current_etype) iftrue
      | If (e, iftrue, iffalse) ->
         let sad_returns = sad_returns || xor (is_list_return iftrue) (is_list_return iffalse) in
         fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]"
                 e nop (instructions sad_returns current_etype) iftrue (instructions sad_returns current_etype) iffalse
      | Loop (var, begin_, end_, li) ->
         fprintf f "@[<v 2>@[<h>for@ %a@ =@ %a@ to@ %a@ do@]@\n%a@]"
                 print_varname var
                 begin_ nop end_ nop
                 (instructions true current_etype) li
      | Comment str -> fprintf f "(*%s*)" str
      | While (e, li) -> fprintf f "@[<v 2>@[<h>while %a do@]@\n%a@]@\n" e nop (instructions true current_etype) li
      | Call (func, li) -> pcall macros f nop func li
      | ClikeLoop _ | Unquote _ | SelfAffect _ | Decr _ | Tag _
        | Incr _ -> assert false in
  let is_return = match i with
    | Return _ -> false
    | If (_, iftrue, iffalse) -> List.for_all is_list_return [iftrue; iffalse]
    | _ -> false in
  let is_sad_return = match i with
    | ClikeLoop (_, _, _, li) | While (_, li) ->
       List.for_all (fun i -> not i.is_return && not i.is_sad_return) li
    | If (_, iftrue, iffalse) -> xor (is_list_return iftrue) (is_list_return iffalse)
    | _ -> false              
  in
  {
    is_comment=is_comment i;
    is_return = is_return;
    p=p;
    is_sad_return = is_sad_return;
    need_unit = match i with
                | Untuple  _ -> true
                | Declare _ -> true
                | Affect (m, _) -> begin match Mutable.Fixed.unfix m with
                                     | Mutable.Var var -> not (BindingSet.mem var refbindings) (* c'est compilé comme un let *)
                                     | _ -> false end
                | _ -> false;
 }

let print_instr printed_exn refbindings macros i =
  let open Ast.Instr.Fixed.Deep in
  fold (print_instr printed_exn refbindings macros)
       (mapg (print_expr refbindings macros) i)

                 
(** the main class : the ocaml printer *)
class fsharpPrinter = object(self)

  method setTyperEnv (t:Typer.env) = ()
  val mutable macros = StringMap.empty
  (** used variables *)
  val mutable used_variables = BindingSet.empty
  method calc_used_variables (instrs : Utils.instr list ) =
    used_variables <- calc_used_variables false instrs
  val mutable recursives_definitions = StringSet.empty
  method setRecursive b = recursives_definitions <- b
  method is_rec funname = StringSet.mem funname recursives_definitions
                                        
  (** bindings by reference *)
  val mutable refbindings = BindingSet.empty
  (** sad return in the current function *)
  val mutable sad_returns = IntSet.empty
  val mutable printed_exn = TypeMap.empty
  (** true if we are processing an expression *)
  val mutable current_etype = Ast.Type.void
  val mutable exn_count = 0

  (** show the main *)
  method main f main =
    current_etype <- Ast.Type.void;
    sad_returns <- collect_sad_return main;
    self#calc_refs main;
    self#calc_used_variables main;
    Format.fprintf f "@[<v 2>@[<h>let () =@\n@[<v 2>  %a@]@\n"
      self#instructions main

  (** show all the programm *)
  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    let op = need || Tags.is_taged "use_readline" in
    Format.fprintf f "%s%s%s%s%s%a%a"
(if op then "open System
" else "" )
(if need then "
let eof = ref false
let buffer = ref \"\"
let readChar_ () =
  if (!buffer) = \"\" then
    let tmp = Console.ReadLine()
    eof := tmp = null
    buffer := tmp + \"\\n\"
  (!buffer).[0]

let consommeChar () =
  ignore (readChar_ ())
  buffer := (!buffer).[1..]
" else "")

      (if need_readchar then "
let readChar () =
  let out_ = readChar_ ()
  consommeChar ()
  out_
" else "")

      (if need_stdinsep then "
let stdin_sep () =
  let cond () =
    if !eof then
      false
    else
      let c = readChar_()
      c = ' ' || c = '\\n' || c = '\\t' || c = '\\r'
  while cond () do
    consommeChar ()
" else "")
      (if need_readint then "
let readInt () =
  let sign =
    if readChar_ () = '-' then
      consommeChar ()
      -1
    else 1
  let rec loop i =
    let c = readChar_ ()
    if c <= '9' && c >= '0' then
      consommeChar ()
      loop (i * 10 + (int c) - (int '0'))
    else
      i * sign
  loop 0
" else "")


      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  (** print recursive prefix *)
  method rec_ f b =
    if b then Format.fprintf f "rec@ "

  (** util method to print a function prototype*)
  method print_proto_aux f rec_ ((funname:string), (t:Ast.Type.t), li) =
    let otype f ty =
      match Type.unfix ty with
      | Type.Void
      | Type.Integer -> ()
      | _ -> Format.fprintf f ": %a " ptype ty
    in
    match li with
    | [] -> Format.fprintf f "let@ %a%s@ () %a="
      self#rec_ rec_ funname
          otype t
    | _ ->
      Format.fprintf f "let@ %a%s@ %a %a="
        self#rec_ rec_ funname
        (print_list (fun f (name, ty) ->
          match Type.unfix ty with
          | Type.Integer -> self#binding f name
          | _ -> Format.fprintf f "(%a:%a)" self#binding name ptype ty
                    ) sep_space) li
          otype t

  (** show an instruction *)
  method instructions f instrs =
    let macros = StringMap.map (fun (ty, params, li) ->
                     ty, params,
                     try List.assoc "fsharp" li
                     with Not_found -> List.assoc "" li) macros in
    let instrs = List.map (print_instr printed_exn refbindings macros) instrs in
    instructions false current_etype f instrs

  (** show a binding *)
  method binding f i =
    if BindingSet.mem i used_variables then
      Format.fprintf f "%a" print_varname i
    else
      Format.fprintf f "_%a" print_varname i

  (** find references variables from a list of instructions *)
  method calc_refs instrs =
    let g acc i = Instr.Writer.Deep.fold
        (fun acc i ->
          match Instr.unfix i with
          | Instr.Read li ->
              List.fold_left (fun acc -> function
                | Instr.Separation -> acc
                | Instr.DeclRead _ -> acc
                | Instr.ReadExpr (_, Mutable.Fixed.F (_, Mutable.Var varname)) -> BindingSet.add varname acc
                | Instr.ReadExpr _ -> acc) acc li
          | Instr.Affect (Mutable.Fixed.F (_, Mutable.Var varname), _) -> BindingSet.add varname acc
          | _ -> acc
        ) acc i
    in let f tra acc i = match Instr.unfix i with
    | Instr.Read li ->
        List.fold_left (fun acc -> function
          | Instr.ReadExpr (_, Mutable.Fixed.F (_, Mutable.Var varname)) -> BindingSet.add varname acc
          | _ -> acc) acc li
    | Instr.Loop (_, _, _, li)
    | Instr.While (_, li) -> List.fold_left g acc li
    | Instr.AllocArray (_, _, _, Some (_, li), _) -> List.fold_left g acc li
    | Instr.If (_, li1, li2) ->
        let acc = List.fold_left g acc li1 in
        List.fold_left g acc li2
    | _ -> tra acc i
    in refbindings <- List.fold_left (f (Instr.Writer.Traverse.fold f)) BindingSet.empty instrs

  method print_exns f exns =
    TypeMap.iter (fun ty str ->
      Format.fprintf f "exception %s of %a@\n"
        str
        ptype ty
    ) exns

  method print_fun f funname (t : unit Type.Fixed.t) li instrs =
    current_etype <- t;
    self#calc_refs instrs;
    self#calc_used_variables instrs;
    let is_rec = self#is_rec funname in
    let proto f = self#print_proto_aux f is_rec in
    let sad_types = collect_sad_returns t instrs in
    let () = sad_returns <- collect_sad_return instrs in
    match t with
    | Type.Fixed.F (_, Type.Void) ->
      if sad_returns <> IntSet.empty then failwith("return in a void function : "^funname)
      else
        Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a%a@]@\n"
          proto (funname, t, li)
          self#ref_alias li
          self#instructions instrs
    | _ ->
      if sad_returns = IntSet.empty then
        Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a%a@]@\n"
          proto (funname, t, li)
          self#ref_alias li
          self#instructions instrs
      else
        let () =
          Warner.warn funname (fun t () -> Format.fprintf t "The returns will make a dirty ocaml code")
        in (* TODO faire un diff pour ne déclarer que les nouvelles *)
        let () = printed_exn <-
          TypeSet.fold (fun t (acc: string TypeMap.t) ->
            exn_count <- exn_count + 1;
            TypeMap.add t ("Found_"^(string_of_int exn_count)) acc
          ) sad_types
          TypeMap.empty
        in
        Format.fprintf f "%a@\n@[<h>%a@]@\n@[<v 2>  %atry@\n%a@\nwith %a (out) -> out@]@\n"
          self#print_exns printed_exn
          proto (funname, t, li)
          self#ref_alias li
          self#instructions instrs
          self#print_exnName t
  method print_exnName f (t : unit Type.Fixed.t) =
    try
      Format.fprintf f "%s" (TypeMap.find t printed_exn)
    with Not_found ->
      Format.fprintf f "NOT_FOUND_%a" ptype t
  method ref_alias f li = match li with
  | [] -> ()
  | (name, _) :: tl ->
    let b = BindingSet.mem name refbindings in
    if b then
      Format.fprintf f "let %a = ref %a@\n%a"
        self#binding name
        self#binding name
        self#ref_alias tl
    else
      self#ref_alias f tl

  method comment f str =
    Format.fprintf f "(*%s*)" str

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        Format.fprintf f "type %s = {@\n@[<v 2>  %a@]@\n};;@\n"
          name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "@[<h>mutable %s : %a;@]"
                 name
                 ptype type_
             ) sep_nl
          ) li
    | Type.Enum li ->
      Format.fprintf f "type %s = @\n@[<v2>    %a@]@\n"
        name (print_list (fun f s -> Format.fprintf f "%s" s) (sep "%a@\n| %a")) li
    | _ ->
      Format.fprintf f "type %s = %a;;" name ptype t

  method proglist f funs =
    Format.fprintf f "%a" (print_list self#prog_item nosep) funs
  method prog_item (f:Format.formatter) t =
    match t with
    | Prog.Comment s -> self#comment f s;
      Format.fprintf f "@\n"
    | Prog.DeclarFun (var, t, li, instrs, _opt) ->
      self#print_fun f var t li instrs;
      Format.fprintf f "@\n"
    | Prog.Macro (name, t, params, code) ->
      macros <- StringMap.add
        name (t, params, code)
        macros;
      ()
    | Prog.Unquote _ -> assert false
    | Prog.DeclareType (name, t) ->
      self#decl_type f name t;
      Format.fprintf f "@\n"

end
