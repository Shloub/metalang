(*
 * Copyright (c) 2012-2016, Prologin
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

(** Ocaml Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast
open Mllike


type pinstr_acc = { p: Format.formatter -> string Ast.TypeMap.t ->  bool -> Ast.Type.t -> unit;
                    need_unit : bool;
                    is_comment : bool;
                    is_return : bool;
                    is_sad_return : bool;
                    sad_returned_types : Ast.TypeSet.t;
                    need_semicolon : bool;
                    is_multi : bool;
                    is_if_with_else : bool;
                    is_if_without_else : bool;
                  }

let print_varname used_variables f i =
    Format.fprintf f (if BindingSet.mem i used_variables then
                        "%a" else "_%a") print_varname i

let print_mut0 used_variables refbindings m f () =
  let open Format in
  let open Mutable in match m with
  | Var v ->
    if BindingSet.mem v refbindings
    then fprintf f "(!%a)" (print_varname used_variables) v
    else (print_varname used_variables) f v
  | Array (m, fi) -> fprintf f "%a%a" m ()
                       (print_list (fun f a -> fprintf f ".(%a)" a nop) (sep "%a%a")) fi
  | Dot (m, field) -> fprintf f "%a.%s" m () field

let print_mut used_variables refbindings f m = Mutable.Fixed.Deep.fold (print_mut0 used_variables refbindings) m f ()

let print_expr used_variables refbindings macros e f p =
  let open Format in
  let open Ast.Expr in
  let print_op f op = fprintf f "%s" (OcamlFunPrinter.binopstr op) in
  let print_expr0 e f prio_parent = match e with
    | Just e -> parens prio_parent prio_apply f "Some %a" e prio_arg
    | BinOp (a, op, b) ->
      let prio, priol, prior = prio_binop op in
      parens prio_parent prio f "%a %a %a" a priol print_op op b prior
    | UnOp (a, op) -> parens prio_parent prio_apply f "%s %a" (OcamlFunPrinter.unopstr op) a prio_arg
    | Lief l -> print_lief f l
    | Access m -> print_mut used_variables refbindings f m
    | Call (func, li) -> pcall macros f prio_parent func li
    | Lexems li -> assert false
    | Tuple li -> fprintf f "(%a)" (print_list (fun f x -> x f nop) sep_c) li
    | Record li -> fprintf f "{%a}" (print_list (fun f (name, x) ->
        fprintf f "%s=%a" name x nop) (sep "%a;@\n%a")) li
  in Fixed.Deep.fold print_expr0 e f p

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

type instructionBlock =
  | BlockBody
  | BlockIfNoElse
  | BlockIf
  | BlockElse
  | BlockLoop

let instructions context printed_exn sad_returns current_etype f li0 =
  let li, _, united, _ = List.fold_left (fun (acc, returned, united, askunit) i ->
      if i.is_comment then
        ((fun f () -> i.p f printed_exn sad_returns current_etype), false)::acc, returned, united, askunit
      else ((fun f () -> i.p f printed_exn returned current_etype), not askunit && i.need_semicolon)::acc,
           true, (if askunit then not i.need_unit else united), false
    ) ([], sad_returns, false, true) (List.rev li0) in
  let psemicol f () =
    print_list (fun f (i, semicol) ->
         Format.fprintf f (if semicol then "%a;" else "%a") i ()) sep_nl f li in
  let p f () = Format.fprintf f (if united then "%a" else "%a@\n()") psemicol () in
  let multi =
    (begin match context with
       | BlockIfNoElse | BlockIf | BlockElse -> true
       | BlockBody | BlockLoop -> false
     end && List.exists (fun i -> i.is_multi) li0) ||
    (begin match context with
       | BlockIf -> true
       | _ -> false
     end && begin match List.rev (List.filter (fun i -> not i.is_comment) li0) with
       | i::_ -> i.is_if_without_else
       | [] -> false
     end) ||
    (begin match context with
       | BlockIfNoElse | BlockIf | BlockElse -> true
       | _ -> false
     end && fst (List.fold_left (fun (result, last_semicol) i ->
        result || (not i.is_comment && last_semicol),
        not i.is_comment && i.need_semicolon) (false, false) li0)) in
  Format.fprintf f (if multi then "@[<v3>begin@\n%a@]@\nend" else "%a") p ()

let print_exnName printed_exn f (t : unit Type.Fixed.t) = Format.fprintf f "%s" (TypeMap.find t printed_exn)

let print_instr used_variables refbindings macros i =
  let open Ast.Instr in
  let open Format in
  let print_mut f m = print_mut used_variables refbindings f m in
  let print_mut_set f m e arge = match Mutable.Fixed.unfix m with
    | Mutable.Var var ->
      if BindingSet.mem var refbindings
      then fprintf f "@[<h>%a@ := %a@]" (print_varname used_variables) var e arge
      else fprintf f "@[<h>let %a@ = %a in@]" (print_varname used_variables) var e arge
    | _ -> Format.fprintf f "@[<h>%a@ <- %a@]" print_mut m e arge
  in
  let is_list_return li =
    match List.filter (fun i -> not i.is_comment) li |> List.rev with
    | i::_ -> i.is_return
    | [] -> false in
  let is_letin_mut_affect m =
    begin match Mutable.Fixed.unfix m with
      | Mutable.Var var -> not (BindingSet.mem var refbindings)
      | _ -> false end
  in
  let sad_returns_list li =
    (* ici on ignore le i.is_return parce-que ça pourrait être du void avec un print par exemple *)
    match List.filter (fun i -> not i.is_comment) li |> List.rev with
    | i::tl -> (*not i.is_return || *) i.is_sad_return || List.exists (fun i -> i.is_return || i.is_sad_return) tl
    | [] -> false in

  let split_read_vars li =
    let li = List.map (function (* on ne met pas de ref si on en a pas besoin *)
        | (Instr.Separation | Instr.DeclRead (_, _, _) ) as r -> r
        | Instr.ReadExpr (t, Mutable.Fixed.F(_, Mutable.Var binding)) as read ->
          if BindingSet.mem binding refbindings then read
          else Instr.DeclRead (t, binding, Instr.default_declaration_option)
        | (Instr.ReadExpr _) as read -> read
      ) li in
    let format, variables =
      List.fold_left (fun (format, variables) i -> match i with
          | Instr.DeclRead (t, v, _opt) ->
            let addons = format_type t in
            (format ^ addons, (true, Mutable.var v)::variables)
          | Instr.ReadExpr (t, mutable_) ->
            let addons = format_type t in
            (format ^ addons, (false, mutable_)::variables)
          | Instr.Separation -> format ^ " ", variables
        ) ("", []) li
    in let variables = List.map (fun (b, m) ->
        let name =
          if b then match Mutable.unfix m with
            | Mutable.Var (UserName v) -> v
            | _ -> assert false
          else  Fresh.fresh_user ()
        in
        (name, b, m) ) (List.rev variables) in
    let declares, affect = List.partition (fun (_, b, _) -> b) variables in
    declares, affect, format, variables in
  let read_need_semi  li =
    let declares, _, _, _ = split_read_vars li in
    match declares with
      | [] -> true
      | li -> false
  in
  let p f printed_exn sad_returns current_etype =
    match i with
    | Declare (var, ty, e, _) ->
      fprintf f (if BindingSet.mem var refbindings then "@[<h>let %a@ =@ ref(@ %a ) in@]"
                 else "@[<h>let %a@ =@ %a in@]")
        (print_varname used_variables) var e nop
    | AllocArray (name, t, e, None, opt) -> assert false
    | AllocArray (name, t, len, Some (var, lambda), opt) ->
      let b = BindingSet.mem name refbindings in
      Format.fprintf f "@[<h>let %a@ =@ %aArray.init@ %a@ (fun@ %a@ ->%a@\n@[<v 2>  %a%a@])%a in@]"
        (print_varname used_variables) name
        (fun t () ->
           if b then
             Format.fprintf t "ref(@ "
        ) ()
        len prio_arg
        (print_varname used_variables) var
        (fun f () ->
           if sad_returns_list lambda then Format.fprintf f "@\n@[<v 2>  try"
        ) ()
        (instructions BlockLoop printed_exn false t) lambda
        (fun f () ->
           if sad_returns_list lambda then Format.fprintf f "@]@\nwith %a out -> out"
               (print_exnName printed_exn) t
        ) ()
        (fun t () ->
           if b then
             Format.fprintf t ")"
        ) ()
    | AllocArrayConst (name, ty, len, lief, opt) -> assert false (*TODO *)
    | AllocRecord (name, ty, list, opt) ->
      let b = BindingSet.mem name refbindings in
      Format.fprintf f (if b then "let %a = ref {@\n@[<v 2>  %a@]@\n} in"
                        else "let %a = {@\n@[<v 2>  %a@]@\n} in")
        (print_varname used_variables) name
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
      in print_list (fun f i -> i f) (sep "%a;@\n%a") f lili
    | Return e -> if sad_returns then
        fprintf f "@[<h>raise (%a(%a))@]" (print_exnName printed_exn) current_etype e nop
      else e f nop
    | Read li ->
      let declares, affect, format, variables = split_read_vars li in
      let print_return : Format.formatter -> unit -> unit = match declares with
        | [] -> (fun _ () ->
            match affect with
            | [] -> Format.fprintf f "()"
            | _ -> ())
        | li -> (fun f () ->
            Format.fprintf f "%a%a"
              (fun f () -> if [] <> affect then Format.fprintf f ";@\n") ()
              (print_list
                 (fun f (name, b, v) ->
                    let v = match Mutable.unfix v with
                      | Mutable.Var v -> v
                      | _ -> assert false
                    in
                    if BindingSet.mem v refbindings then Format.fprintf f "ref %s" name
                    else Format.fprintf f "%s" name) sep_c)
              declares )
      in
      let print_in : Format.formatter -> unit -> unit  = match declares with
        | [] -> fun _ () -> ()
        | li -> fun f () -> Format.fprintf f " in"
      in
      let print_variables : Format.formatter -> unit -> unit =
        match variables with
        | [] -> fun f () -> Format.fprintf f "()"
        | _ ->
          fun f () ->
            print_list (fun f (name, b, m) -> Format.fprintf f "%s" name) sep_space
              f
              variables
      in
      let print_let : Format.formatter -> unit -> unit  = match declares with
        | [] -> (fun _ () -> ())
        | li -> (fun f () ->
            Format.fprintf f "let %a = "
              (print_list
                 (fun f (_, _, v) -> print_mut f v) sep_c)
              declares )
      in begin match variables with
        | [] -> Format.fprintf f "Scanf.scanf \"%s\" ()" format
        | _ -> Format.fprintf f "%aScanf.scanf \"%s\" (fun %a -> @[<v>%a%a@])%a"
                 print_let ()
                 format
                 print_variables ()
                 (print_list (fun f (name, b, m) ->
                      print_mut_set f m (fun f () -> Format.fprintf f "%s" name) () )
                     (sep "%a;@\n%a"))
                 affect
                 print_return ()
                 print_in ()
      end
    | Affect (m, e) -> print_mut_set f m e nop
    | Untuple (li, expr, opt) -> fprintf f "@[<h>let (%a) = %a in@]"
                                   (print_list (print_varname used_variables) sep_c) (List.map snd li)
                                   expr nop
    | If (e, iftrue, []) ->
      fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]" e nop (instructions BlockIfNoElse printed_exn true current_etype) iftrue
    | If (e, iftrue, iffalse) ->
      let sad_returns = sad_returns || xor (is_list_return iftrue) (is_list_return iffalse) in
      fprintf f "@[<h>if@ %a@ then@]@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]"
        e nop (instructions BlockIf printed_exn sad_returns current_etype) iftrue
        (instructions BlockElse printed_exn sad_returns current_etype) iffalse
    | Loop (var, begin_, end_, li) ->
      fprintf f "@[<v 2>@[<h>for@ %a@ =@ %a@ to@ %a@ do@]@\n%a@]@\ndone"
        (print_varname used_variables) var
        begin_ nop end_ nop
        (instructions BlockLoop printed_exn true current_etype) li
    | Comment str -> fprintf f "(*%s*)" str
    | While (e, li) -> fprintf f "@[<v 2>@[<h>while %a do@]@\n%a@]@\ndone" e nop (instructions BlockLoop printed_exn true current_etype) li
    | Call (func, li) -> pcall macros f nop func li
    | ClikeLoop _ | Unquote _ | SelfAffect _ | Decr _ | Tag _
    | Incr _ -> assert false in
  let is_return = match i with
    | Return _ -> true
    | If (_, iftrue, iffalse) -> List.for_all is_list_return [iftrue; iffalse]
    | _ -> false in
  let is_sad_return = match i with
    | AllocArray _ -> false (* on le catche donc c'est plus du sad return, par contre le type catché est collé dans collected_sad_returns_addon*)
    | ClikeLoop (_, _, _, li) | While (_, li) | Loop (_, _, _, li)->
      List.exists (fun i -> i.is_return || i.is_sad_return) li
    | If (_, iftrue, iffalse) -> xor (is_list_return iftrue) (is_list_return iffalse) ||
                                 List.exists (List.exists (fun i -> i.is_sad_return)) [iftrue; iffalse]
    | _ -> false in
  let collected_sad_returns_addon = Fixed.Surface.fold (fun acc i ->
      Ast.TypeSet.union acc i.sad_returned_types
    ) Ast.TypeSet.empty i in
  let collected_sad_returns = match i with
    | AllocArray (_, ty, _, Some (var, lambda), _) when sad_returns_list lambda ->
      Ast.TypeSet.add ty collected_sad_returns_addon
    | _ -> collected_sad_returns_addon in
  {
    is_comment=is_comment i;
    need_semicolon = begin match i with
      | Call _ | Print _ | If _ | Loop _ | While _ -> true
      | Affect (mut, _) -> not (is_letin_mut_affect mut)
      | Read li -> read_need_semi li
      | _ -> false end;
    is_return = is_return;
    p=p;
    sad_returned_types=collected_sad_returns;
    is_sad_return = is_sad_return;
    is_multi = begin match i with
      | Print li -> List.length li > 50
      | _ -> false
    end;
    is_if_with_else = begin match i with
      | If (_, _, _hd::_tl) -> true
      | _ -> false
    end;
    is_if_without_else = begin match i with
      | If (_, _, []) -> true
      | _ -> false
    end;
    need_unit = match i with
      | Untuple  _ -> true
      | Declare _ -> true
      | Affect (mut, _) -> is_letin_mut_affect mut
      | Read li -> not ( read_need_semi li)
      | _ -> false;
  }

let print_instr used_variables refbindings macros i =
  let open Ast.Instr.Fixed.Deep in
  fold (print_instr used_variables refbindings macros)
    (mapg (print_expr used_variables refbindings macros) i)

let print_proto_aux used_variables f rec_ ((funname:string), (t:Ast.Type.t), li) =
  let li = List.map fst li in
    match li with
    | [] -> Format.fprintf f (if rec_ then "let@ rec@ %s@ () =" else "let@ %s@ () =") funname
    | _ ->
      Format.fprintf f
        (if rec_ then "let@ rec@ %s@ %a =" else "let@ %s@ %a =") funname
        (print_list (print_varname used_variables) sep_space) li

let ref_alias0 format refbindings f li =
  let li = List.map fst li in
  let bag = List.fold_left (fun acc item -> BindingSet.add item acc) BindingSet.empty li in
  let li = List.filter (fun name -> BindingSet.mem name refbindings) li in
  match li with
  | [] -> ()
  | _ -> Format.fprintf f "%a@\n"
           (print_list (fun f name ->
                Format.fprintf f format
                  (print_varname bag) name
                  (print_varname bag) name) sep_nl) li

let ref_alias refbindings f li = ref_alias0 "let %a = ref %a in" refbindings f li

let print_exns f exns =
    TypeMap.iter (fun ty str ->
        Format.fprintf f "exception %s of %a@\n"
          str
          Mllike.ptype ty
    ) exns
      
let calc_refs instrs =
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
      | Instr.Loop (_, _, _, li)
      | Instr.While (_, li) -> List.fold_left g acc li
      | Instr.AllocArray (_, _, _, Some (_, li), _) -> List.fold_left g acc li
      | Instr.If (_, li1, li2) ->
        let acc = List.fold_left g acc li1 in
        List.fold_left g acc li2
      | _ -> tra acc i
  in List.fold_left (f (Instr.Writer.Traverse.fold f)) BindingSet.empty instrs
      
let prog recursives_definitions f (prog: Utils.prog) =
    let calc_addons sad_types exn_count printed_exn = TypeSet.fold
        (fun t (acc, exn_count, printed_exn) ->
      if TypeMap.mem t printed_exn then acc, exn_count, printed_exn else
          let exn_count = exn_count + 1 in
          let s = "Found_"^(string_of_int exn_count) in
          TypeMap.add t s acc, exn_count, TypeMap.add t s printed_exn
      ) sad_types (TypeMap.empty, exn_count, printed_exn) in
    let instructions macros current_etype instrs =
      let refbindings = calc_refs instrs in
      let used_variables = calc_used_variables false instrs in
      let macros = StringMap.map (fun (ty, params, li) ->
          ty, params,
          try List.assoc "ml" li
          with Not_found -> List.assoc "" li) macros in
      let instrs = List.map (print_instr used_variables refbindings macros) instrs in
      let sad_returns = List.fold_left (fun acc i -> TypeSet.union acc i.sad_returned_types) TypeSet.empty instrs in
      let sad_return_current = 
        match List.filter (fun i -> not i.is_comment) instrs |> List.rev with
        | i::tl -> i.is_sad_return || List.exists (fun i -> i.is_return || i.is_sad_return) tl
        | [] -> false in
      let sad_returns = if sad_return_current then TypeSet.add current_etype sad_returns
        else sad_returns in
      used_variables, refbindings, sad_return_current, sad_returns, fun f printed_exn -> instructions BlockBody printed_exn false current_etype f instrs in
    let macros, exn_count, printed_exn, items = List.fold_left
        (fun (macros, exn_count, printed_exn, li) item -> match item with
           | Prog.Macro (name, t, params, code) ->
             StringMap.add name (t, params, code) macros, exn_count, printed_exn, li
           | Prog.Comment s -> macros, exn_count, printed_exn, (fun f -> Format.fprintf f "(*%s*)" s)::li
           | Prog.DeclarFun (funname, t, vars, instrs, _opt) ->
             let is_rec = StringSet.mem funname recursives_definitions in
             let used_variables, refbindings, sad_return_current, sad_types, pinstrs = instructions macros t instrs in
             let printed_exns_addon, exn_count, printed_exn = calc_addons sad_types exn_count printed_exn in
             macros, exn_count, printed_exn, (fun f ->
             let proto f = print_proto_aux used_variables f is_rec in
             if not sad_return_current then
               Format.fprintf f "%a@[<h>%a@]@\n@[<v 2>  %a%a@]@\n"
                 print_exns printed_exns_addon
                 proto (funname, t, vars)
                 (ref_alias refbindings) vars
                 pinstrs printed_exn
             else
               Format.fprintf f "%a@\n@[<h>%a@]@\n@[<v 2>  %atry@\n%a@\nwith %a (out) -> out@]@\n"
                 print_exns printed_exns_addon
                 proto (funname, t, vars)
                 (ref_alias refbindings) vars
                 pinstrs printed_exn
                 (print_exnName printed_exn) t)::li
           | Prog.DeclareType (name, t) ->
             macros, exn_count, printed_exn, (fun f -> match (Type.unfix t) with
                 Type.Struct li ->
                 Format.fprintf f "type %s = {@\n@[<v 2>  %a@]@\n};;@\n"
                   name
                   (print_list
                      (fun t (name, type_) ->
                         Format.fprintf t "@[<h>mutable %s : %a;@]"
                           name
                           Mllike.ptype type_
                      ) sep_nl
                   ) li
               | Type.Enum li ->
                 Format.fprintf f "type %s = @\n@[<v2>    %a@]@\n"
                   name (print_list (fun f s -> Format.fprintf f "%s" s) (sep "%a@\n| %a")) li
               | _ ->
                 Format.fprintf f "type %s = %a;;" name ptype t
             )::li
           | _ -> macros, exn_count, printed_exn, li
        ) (StringMap.empty, 0,TypeMap.empty, []) prog.Prog.funs in
    let main f main =
      let _, _, _, sad_types, pinstrs = instructions macros Ast.Type.void main in
      let printed_exns_addon, exn_count, printed_exn = calc_addons sad_types exn_count printed_exn in
      Format.fprintf f "%a@[<v 2>@[<h>let () =@\n@[<v 2> %a@] @\n"
        print_exns printed_exns_addon pinstrs printed_exn in
    Format.fprintf f "%a@\n%a"
      (print_list (fun f g -> g f) sep_nl) (List.rev items)
      (print_option main) prog.Prog.main
