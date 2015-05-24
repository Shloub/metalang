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
let print_expr prototypes macros e f p =
  let open Format in
  let open Expr in 
  let print_lief prio f l = match l with
  | Char c -> fprintf f "$%c" c
  | String s -> fprintf f "'%s'" (String.replace "'" "''" s)
  | Integer i -> fprintf f "%i" i
  | Bool true -> fprintf f "true"
  | Bool false -> fprintf f "false"
  | Enum s -> fprintf f "#%s" s in
  let print_op f op = fprintf f "%s" (match op with
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
  | Diff -> "~=" ) in
  let prio_binop = function
    | Div | Mod -> prio_result, prio_object, prio_message
    | _ -> 7, 7, 6 in
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
    | _ -> print_expr0 config e f prio_parent in
  let print_mut c m f prio_parent =
    let open Mutable in match m with
    | Var v -> c.print_varname f v
    | Array (m, fi) -> parens prio_parent prio_result f "%a at: %a" m prio_object
          (print_list (fun f a -> a f prio_message) (sep "%a at: %a")) fi
    | Dot (m, field) -> fprintf f "%a %s" m prio_object field in
  let print_mut conf prio f m = Mutable.Fixed.Deep.fold (print_mut conf) m f prio in
  let config = {
    prio_binop;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
  } in Fixed.Deep.fold (print_expr0 config) e f p

class smalltalkPrinter = object(self)
  inherit Printer.printer as base

  val mutable prototypes = StringMap.empty

  method lang () = "st"

  method separator f () = Format.fprintf f "."

  method affect f mutable_ (expr : 'lex Expr.t) =
    Format.fprintf f "@[<hov>%a @ %a%a@]"
      self#mutable_set mutable_
      (self#expr_prio prio_message) expr self#separator ()

  method declaration f var t e =
    Format.fprintf f "@[<hov>%a@ :=@ %a%a@]" self#binding var self#expr e self#separator ()
          
  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<hov>%a@]@\n@[<v 2>  ifTrue:%a@]."
        (self#expr_prio prio_object) e
        self#bloc ifcase
    | _ ->
      Format.fprintf f "@[<hov>%a@]@\n@[<v 2>  ifTrue:%a@\nifFalse:%a@]."
        (self#expr_prio prio_object) e
        self#bloc ifcase
        self#bloc elsecase

  method m_variable_set f b = Format.fprintf f "%a :=" self#binding b
  method m_field_set f m field = Format.fprintf f "%a %a:" self#mutable_get m self#field field
  method m_array_set f m indexes = Format.fprintf f "%a at: %a put:"
        self#mutable_get m
        (print_list
           (fun f e -> (self#expr_prio prio_message) f e)
           (sep "%a at: %a"))
        indexes

  method m_field_get f m field = Format.fprintf f "(%a %a)" self#mutable_get m self#field field

  method m_array_get f m indexes = Format.fprintf f "(%a at: %a)"
        self#mutable_get m
        (print_list
           (fun f e -> (self#expr_prio prio_message) f e)
           (sep "%a at: %a"))
           indexes

  method allocarray f binding type_ len useless =
    Format.fprintf f "@[<h>%a := Array new: %a.@]"
      self#binding binding
      (self#expr_prio prio_message) len

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<v 2>@[<h>(%a to: %a) do: [:%a|@]@\n%a@]@\n]%a"
      (self#expr_prio prio_object) expr1
      (self#expr_prio prio_message) expr2
      self#binding varname
      self#instructions li
      self#separator ()

  method return f e =
    Format.fprintf f "@[<hov>^@ %a@]" self#expr e

  method bloc f = function
    | [] -> Format.fprintf f "[]"
    | [i] -> Format.fprintf f "@[<v>[%a]@]" self#instr i
    | li -> Format.fprintf f "@[<v>[@\n%a@]@\n]"
          (print_list self#instr sep_nl) li

  method print f t expr = Format.fprintf f "@[%a display.@]" (self#expr_prio prio_object) expr

  method expr_prio p f e = print_expr prototypes
      (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) e f p

  method expr f e = self#expr_prio nop f e

  method declaredvars bindings instrs =
    List.fold_left
      (Instr.Writer.Deep.fold
         (fun bindings i ->
           match Instr.Fixed.unfix i with
           | Instr.DeclRead (t, b, _)
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

  method apply f var li =
    match StringMap.find_opt var macros with
    | Some _ -> base#apply f var li
    | None ->
        match li with
        | [] -> Format.fprintf f "(self %a)" self#funname var
        | _ ->
            Format.fprintf f
              "(self %a)"
              (print_list
                 (fun f (a,b) ->
                   Format.fprintf f "%a: %a"
                     a ()
                     (self#expr_prio prio_message) b)
                 sep_space
              ) (List.zip (StringMap.find var prototypes) li)

  method whileloop f expr li =
    Format.fprintf f "@[<h>[%a] whileTrue:@]@\n%a."
      self#expr expr
      self#bloc li

  method hasSelfAffect op = false
  method call f var li = Format.fprintf f "%a%a" (fun f () -> self#apply f var li) () self#separator ()

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
      | Instr.Read (_, Mutable.Fixed.F (_, Mutable.Var varname)) -> BindingSet.add varname acc
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

  method stdin_sep f = Format.fprintf f "@[self skip.@]"

  method read_decl f t v = self#read f t (Mutable.var v)

  method read f t m =
    match Type.unfix t with
    | Type.Char -> Format.fprintf f "%a self read_char." self#mutable_set  m
    | Type.Integer -> Format.fprintf f "%a self read_int." self#mutable_set m
    | _ -> assert false

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

  method def_fields name f li =
      print_list
         (fun f (fieldname, expr) ->
           Format.fprintf f "%a %a: %a."
             self#binding name
             self#field fieldname
             (self#expr_prio prio_message) expr
         ) sep_nl f li

  method ptype f (t:Type.t) =
    match Type.unfix t with
    | Type.Named n -> Format.fprintf f "%s" n
    | _ -> assert false

  method allocrecord f name t el =
    Format.fprintf f "%a := %a new.@\n%a"
      self#binding name
      self#ptype t
      (self#def_fields name) el


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
