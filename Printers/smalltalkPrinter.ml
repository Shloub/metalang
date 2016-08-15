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

(** Smalltalk Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Helper
open Stdlib

let prio_object = 1
let prio_message = 3
let prio_result = 9

let print_lief prio f l =
  let open Format in
  let open Expr in 
  match l with
  | Char c -> fprintf f "$%c" c
  | String s -> fprintf f "'%s'" (String.replace "'" "''" s)
  | Integer i -> fprintf f "%i" i
  | Bool true -> fprintf f "true"
  | Bool false -> fprintf f "false"
  | Enum s -> fprintf f "#%s" s
let print_op f op =
  let open Format in
  let open Expr in 
  fprintf f "%s" (match op with
      | Add -> "+"
      | Sub -> "-"
      | Mul -> "*"
      | Div -> "quo:"
      | Mod -> "rem:"
      | Or -> "|"
      | And -> "&"
      | Lower -> "<"
      | LowerEq -> "<="
      | Higher -> ">"
      | HigherEq -> ">="
      | Eq -> "="
      | Diff -> "~=" )
let prio_binop = 
  let open Expr in 
  function
  | Div | Mod -> prio_result, prio_object, prio_message
  | _ -> 7, 7, 6
let print_mut c m f prio_parent =
  let open Format in
  let open Mutable in match m with
  | Var v -> c.print_varname f v
  | Array (m, fi) -> parens prio_parent prio_result f "%a at: %a" m prio_object
                       (print_list (fun f a -> a f prio_message) (sep "%a at: %a")) fi
  | Dot (m, field) -> fprintf f "%a %s" m prio_object field

let print_mut_set c m f prio_parent =
  let open Format in
  let open Mutable in match m with
  | Var v -> fprintf f "%a :=" c.print_varname v
  | Array (m, fi) -> fprintf f "%a at: %a put:"
                       m prio_object
                       (print_list
                          (fun f e -> e f prio_message)
                          (sep "%a at: %a"))
                       fi
  | Dot (m, field) -> fprintf f "%a %s:" m prio_object field

let prio_mut_set m =
  let open Mutable in match unfix m with
  | Var v -> nop
  | Array (m, fi) -> prio_message
  | Dot (m, field) -> prio_message

let print_mut conf prio f m = Mutable.Fixed.Deep.fold (print_mut conf) m f prio
let print_mut_set conf prio f m =
  let m = Mutable.Fixed.Surface.map (fun m f prio -> print_mut conf prio f m) (Mutable.unfix m)
  in print_mut_set conf m f prio

let config macros ={
  prio_binop;
  prio_unop;
  print_varname;
  print_lief;
  print_op;
  print_unop;
  print_mut;
  macros
} 

let print_expr prototypes config e f p =
  let open Format in
  let open Expr in 
  let print_expr0 config e f prio_parent = match e with
    | BinOp(a, Or, b)  -> parens prio_parent prio_result f "%a or: [%a]" a prio_object b nop
    | UnOp (a, Not)    -> parens prio_parent prio_result f "%a not" a prio_object
    | UnOp (a, Neg)    -> parens prio_parent prio_result f "0 - %a" a 6
    | BinOp(a, And, b) -> parens prio_parent prio_result f "%a and: [%a]" a prio_object b nop
    | Call(funname, li) ->
      begin match StringMap.find_opt funname prototypes with
        | None -> print_expr0 config e f prio_parent (* une macro ? *)
        | Some proto -> begin match li with
            | [] -> fprintf f "(self %s)" funname
            | _ -> fprintf f "(self %a)"
                     (print_list
                        (fun f (a,b) ->
                           fprintf f "%a: %a"
                             a ()
                             b prio_message)
                        sep_space
                     ) (List.zip proto li)
          end
      end
    | _ -> print_expr0 config e f prio_parent in Fixed.Deep.fold (print_expr0 config) e f p

let print_instr prototypes c i =
  let open Ast.Instr in
  let open Format in
  let ptype f (t:Type.t) =
    match Type.unfix t with
    | Type.Named n -> fprintf f "%s" n
    | _ -> assert false in
  let block f = function
    | [] -> Format.fprintf f "[]@]"
    | [i] -> Format.fprintf f "[%a]@]" i.p i.default
    | li -> Format.fprintf f "[@\n%a@]@\n]"
              (print_list (fun f i -> i.p f i.default) sep_nl) li in
  let block_var var f = function
    | [] -> Format.fprintf f "[:%a |]@]" c.print_varname var
    | [i] -> Format.fprintf f "[:%a| %a]@]"  c.print_varname var i.p i.default
    | li -> Format.fprintf f "[:%a|@\n%a@]@\n]" c.print_varname var
              (print_list (fun f i -> i.p f i.default) sep_nl) li in
  let read t pp f =
    match Type.unfix t with
    | Type.Integer -> fprintf f "@[<h>%a self read_int.@]" pp ()
    | Type.Char -> fprintf f "@[<h>%a self read_char.@]" pp ()
    | _ -> assert false (* type non géré*) in
  let p f () = match i with
    | Declare (var, ty, e, _) -> fprintf f "%a := %a." c.print_varname var e nop
    | SelfAffect (mut, op, e) -> assert false
    | Affect (mut, e) -> fprintf f "%a %a." (print_mut_set c nop) mut e (prio_mut_set mut)
    | ClikeLoop (init, cond, incr, li) -> assert false
    | Loop (var, e1, e2, li) -> fprintf f "@[<v 2>@[<h>(%a to: %a) do: @]%a."
                                  e1 prio_object e2 prio_message
                                  (block_var var) li
    | While (e, li) -> fprintf f "@[<v 2>@[<h>[%a] whileTrue:@]%a." e nop block li
    | Comment s -> fprintf f "\"%s\"" (String.replace "\"" "\"\"" s)
    | Tag s -> fprintf f "/*%S*/" s
    | Return e -> fprintf f "@[<hov>^@ %a@]" e nop
    | AllocArray (name, t, e, None, opt) ->
      fprintf f "@[<h>%a := Array new: %a.@]"
        c.print_varname name
        e prio_message
    | AllocArray (name, t, e, Some _, opt) -> assert false
    | AllocArrayConst (name, ty, len, lief, opt) -> assert false
    | AllocRecord (name, ty, list, opt) ->
      fprintf f "%a := %a new.@\n%a"
        c.print_varname name
        ptype ty
        (print_list (fun f (field, x) -> fprintf f "%a %s: %a."
                        c.print_varname name
                        field x prio_message) sep_nl) list
    | If (e, listif, []) ->
      fprintf f "@[<hov>%a@]@\n@[<v 2>ifTrue:%a." e prio_object block listif     
    | If (e, listif, listelse) ->
      fprintf f "@[<hov>%a@]@\n@[<v 2>ifTrue:%a@\n@[<v 2>ifFalse:%a."
        e prio_object block listif block listelse
    | Call (func, li) ->  begin match StringMap.find_opt func c.macros with
        | Some ( (t, params, code) ) -> pmacros f "%s" t params code li nop
        | None ->
          begin match li with
            | [] -> fprintf f "(self %s)." func
            | _ -> fprintf f "(self %a)." (print_list (fun f (name, x) ->
                fprintf f "%a:%a" name () x prio_message) sep_space)
                (List.zip (StringMap.find func prototypes) li)
          end
      end
    | Print li -> print_list
                    (fun f e -> match e with
                       | PrintExpr (_, e) -> fprintf f "@[%a display.@]" e prio_object
                       | StringConst s -> fprintf f "@[%a display.@]" (c.print_lief prio_object) (Expr.String s) )
                    sep_nl
                    f li
    | Read li ->
      let li = List.map (function
          | Separation -> fun f -> fprintf f "@[<hov>self skip.@]"
          | DeclRead (t, var, _option) -> read t (fun f () -> fprintf f "%a :=" print_varname var)
          | ReadExpr (t, m) -> read t (fun f () -> print_mut_set c nop f m)) li
      in print_list (fun f e -> e f) sep_nl f li
    | Untuple (li, expr, opt) -> fprintf f "(%a) = %a" (print_list c.print_varname sep_c) (List.map snd li) expr nop
    | Unquote e -> assert false in
  let is_multi_instr = match i with
    | Read (hd::tl) -> true
    | _ -> false in
  {
    is_multi_instr = is_multi_instr;
    is_if=is_if i;
    is_if_noelse=is_if_noelse i;
    is_comment=is_comment i;
    p=p;
    default = ();
    print_lief = c.print_lief;
  }





class smalltalkPrinter = object(self)
  inherit Printer.printer as base

  val mutable prototypes = StringMap.empty

  method lang () = "st"

  method instructions f li =
    let open Ast.Instr.Fixed.Deep in
    let macros = StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc "st" li
        with Not_found -> List.assoc "" li) macros in
    let c = config macros in
    let li = List.map (fun i -> (fold (print_instr prototypes c) (mapg (print_expr prototypes c) i))) li in
    print_list (fun f i -> i.p f i.default) sep_nl f li

  method declaredvars bindings instrs =
    List.fold_left
      (Instr.Writer.Deep.fold
         (fun bindings i ->
            match Instr.Fixed.unfix i with
            | Instr.Read li -> List.fold_left (fun bindings -> function
                | Instr.DeclRead (t, b, _) -> BindingMap.add b t bindings
                | _ -> bindings ) bindings li
            | Instr.Declare (b, t, _, _) ->
              BindingMap.add b t bindings
            | Instr.AllocArray (b, t, _, _, _) ->
              BindingMap.add b (Type.array t) bindings
            | Instr.AllocRecord (b, t, _, _) ->
              BindingMap.add b t bindings
            | _ -> bindings
         )
      )
      bindings
      instrs

  method comment f str =
    Format.fprintf f "\"%s\"" (String.replace "\"" "\"\"" str)

  (** bindings by reference *)
  val mutable refbindings = BindingSet.empty

  method declarevars li f instrs =
    let bindings = self#declaredvars BindingMap.empty instrs in
    let bindings = List.fold_left (fun acc (n, t) ->
        if BindingSet.mem n refbindings
        then BindingMap.add n t acc
        else acc ) bindings li in
    if bindings = BindingMap.empty then ()
    else
      let li = BindingMap.fold
          (fun key value acc ->
             key::acc
          )
          bindings  []
      in Format.fprintf f "@[|%a|@]"
        (print_list self#binding sep_space) li

  method main f (main : Utils.instr list) =
    Format.fprintf f "@[<v 2>main [@\n%a%a@\n@]]"
      (self#declarevars []) main
      self#instructions main

  method print_proto f (funname, t, li) =
    prototypes <- StringMap.add funname (match li with
        | [] -> []
        | (hd, _)::tl -> (fun f () -> self#funname f funname) :: (List.map (fun (n, _) f () -> self#binding f n) tl)) prototypes;
    match li with
    | [] -> begin
        prototypes <- StringMap.add funname [] prototypes;
        Format.fprintf f "%a" self#funname funname
      end
    | (hd, _)::tl -> begin
        prototypes <- StringMap.add funname ((fun f () -> self#funname f funname) :: (List.map (fun (n, _) f () -> self#binding f n) tl)) prototypes;
        Format.fprintf f " %a: %a %a"
          self#funname funname
          (fun f () -> if BindingSet.mem hd refbindings
            then Format.fprintf f "_%a" self#binding hd
            else self#binding f hd
          ) ()
          (print_list
             (fun f (n, t) -> if BindingSet.mem n refbindings
               then Format.fprintf f "%a: _%a" self#binding n self#binding n
               else Format.fprintf f "%a: %a" self#binding n self#binding n
             ) sep_space ) tl
      end

  (** find references variables from a list of instructions *)
  method calc_refs instrs =
    let g acc i =
      match Instr.unfix i with
      | Instr.Read li ->
        List.fold_left (fun acc -> function
            | Instr.ReadExpr (_, Mutable.Fixed.F (_, Mutable.Var varname)) -> BindingSet.add varname acc
            | _ -> acc ) acc li
      | Instr.Affect (Mutable.Fixed.F (_, Mutable.Var varname), _) ->
        BindingSet.add varname acc
      | _ -> acc
    in let g acc i = Instr.Writer.Deep.fold g (g acc i) i
    in refbindings <- List.fold_left g BindingSet.empty instrs

  method ref_alias f li =
    print_list (fun f (a, b) ->
        Format.fprintf f "%a := %a.@\n"
          self#binding a
          self#binding b)
      nosep f li

  method print_fun f funname t li instrs =
    self#calc_refs instrs;
    let li2, liproto = List.map (fun (n, t) ->
        if BindingSet.mem n refbindings then
          let f = UserName ( Fresh.fresh_user () ) in
          Some (n, f), (f, t)
        else None, (n, t)) li |> List.unzip in
    let li2 = List.filter_map id li2 in
    Format.fprintf f "@[<v 2>@[<h>%a [%a@]@\n%a%a@]@\n]@\n"
      self#print_proto (funname, t, liproto)
      (self#declarevars li) instrs
      self#ref_alias li2
      self#instructions instrs

  method header f prog =
    let p f li = print_list (fun f s -> Format.fprintf f "%s" s) sep_nl f li
    in
    let pf bool name tmp f li =
      if bool then Format.fprintf f "@[<v 2>%s [%a@\n%a@]@\n]@\n"
          name
          (fun f -> function
             | [] -> ()
             | li -> Format.fprintf f "|%a|"
                       (print_list (fun f n -> Format.fprintf f "%s" n)
                          sep_space) li) tmp
          p li
    in
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "%a%a%a%a"
      (fun f () -> if need then
          Format.fprintf f "|buffer|@\n"
      ) ()
      (pf need_readint "read_int" [ "o" ] ) [ 
      "((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].";
      " o := 0.";
      "(buffer isNil) ifFalse:[";
      "(buffer =~ '^(-?\\d+)' asRegex) ifMatched: [:match |";
      "o := match at: 1.";
      "buffer := buffer allButFirst:(o size).";
      "].";
      "^o asInteger. ]" ]
      (pf need_stdinsep "skip" [] ) [
      " ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].";
      "(buffer isNil) ifFalse:[";
      "(buffer =~ '^(\\s+)') ifMatched: [:match | buffer := buffer allButFirst:((match at: 1) size).].";
      "]"]
      (pf need_readchar "read_char" [ "o" ] )  [
      " ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].";
      "(buffer isNil) ifFalse:[";
      "o := buffer at: 1.";
      "buffer := buffer allButFirst:1.";
      "^o.";
      "]"]

  method decl_type f name t = ()
  method ptype f (t:Type.t) =
    match Type.unfix t with
    | Type.Named n -> Format.fprintf f "%s" n
    | _ -> assert false

  method structDeclarations f li =
    print_list
      (fun f t -> match t with
         | Prog.DeclareType (name, t) -> begin match Type.unfix t with
             | Type.Struct li ->
               let n = Fresh.fresh_user() in
               Format.fprintf f "@[<v2>Object subclass: %s [@\n| %a |@\n%a@\n%a@]@\n]@\n"
                 name
                 (print_list
                    (fun f (name, t) -> Format.fprintf f "%s" name)
                    sep_space
                 ) li
                 (print_list
                    (fun f (name, t) -> Format.fprintf f "%s [ ^%s ]" name name)
                    sep_nl
                 ) li
                 (print_list
                    (fun f (name, t) -> Format.fprintf f "%s: %s [ %s := %s. ] " name n name n)
                    sep_nl
                 ) li
             | _ -> ()
           end
         | _ -> ())
      nosep f li

  method prog f (prog: Utils.prog) =
    Format.fprintf f "%a@[<v2>Object subclass: %s [@\n%a%a%a@]@\n]@\nEval [ (%s new) main. ]@\n"
      self#structDeclarations prog.Prog.funs
      prog.Prog.progname
      self#header prog
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main
      prog.Prog.progname
end
