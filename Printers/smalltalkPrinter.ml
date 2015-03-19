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
open Stdlib
open Printer

class smalltalkPrinter = object(self)
  inherit printer as baseprinter

  val mutable prototypes = StringMap.empty

  method lang () = "st"

  method separator f () = Format.fprintf f "."

  method operator_affect f mutable_ =
    match Mutable.unfix mutable_ with
    | Mutable.Var v -> Format.fprintf f " :="
    | Mutable.Array _ -> Format.fprintf f " put:"
    | Mutable.Dot (_, _) -> Format.fprintf f ":"


  method affect f mutable_ (expr : 'lex Expr.t) =
    Format.fprintf f "@[<hov>%a%a @ %a%a@]"
      (self#mutable0 false) mutable_
      self#operator_affect mutable_
      self#expr expr self#separator ()

  method declaration f var t e =
    Format.fprintf f "@[<hov>%a@ :=@ %a%a@]" self#binding var self#expr e self#separator ()

  method char f c = Format.fprintf f "$%c" c

  method string f i = Format.fprintf f "'%s'" (String.replace "'" "''" i)

  method unop f op a = match op with
      | Expr.Neg -> Format.fprintf f "(0-(%a))" self#expr a
      | Expr.Not -> Format.fprintf f "((%a) not)" self#expr a

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "quo:"
      | Expr.Mod -> "rem:"
      | Expr.Or -> "|"
      | Expr.And -> "&"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | Expr.Eq -> "="
      | Expr.Diff -> "~="
      )

  method binop f op a b =
    match op with
    | Expr.Or -> Format.fprintf f "((%a) ifTrue:[true] ifFalse: [%a])" self#expr a self#expr b
    | Expr.And -> Format.fprintf f "((%a) ifTrue:[%a] ifFalse: [false])" self#expr a self#expr b
    | _ -> Format.fprintf f "(%a %a %a)" self#expr a self#print_op op self#expr b
          
  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<hov>%a@]@\n@[<v 2>  ifTrue:%a@]."
        self#expr e
        self#bloc ifcase
    | _ ->
      Format.fprintf f "@[<hov>%a@]@\n@[<v 2>  ifTrue:%a@\nifFalse:%a@]."
        self#expr e
        self#bloc ifcase
        self#bloc elsecase

  method mutable_ f m = self#mutable0 true f m 

  method mutable0 p f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) ->
      Format.fprintf f (if p then "(%a %a)" else "%a %a")
        self#mutable_ m
        self#field field
    | Mutable.Var binding -> self#binding f binding
    | Mutable.Array (m, indexes) ->
      Format.fprintf f (if p then "(%a at: %a)" else "%a at: %a")
        self#mutable_ m
        (print_list
           (fun f e -> self#expr f (Expr.binop Expr.Add e (Expr.integer 1) ))
           (fun f f1 e1 f2 e2 ->
             Format.fprintf f "%a at: %a" f1 e1 f2 e2
           ))
        indexes

  method allocarray f binding type_ len useless =
    Format.fprintf f "@[<h>%a := Array new: %a.@]"
      self#binding binding
      self#expr len

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<v 2>@[<h>(%a to: %a) do: [:%a|@]@\n%a@]@\n]%a"
      self#expr expr1
      self#expr expr2
      self#binding varname
      self#instructions li
      self#separator ()

  method return f e =
    Format.fprintf f "@[<hov>^@ %a@]" self#expr e

  method bloc f = function
    | [] -> Format.fprintf f "[]"
    | [i] -> Format.fprintf f "@[<v>[%a]@]" self#instr i
    | li -> Format.fprintf f "@[<v>[@\n%a@]@\n]"
          (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
              "%a@\n%a" f1 e1 f2 e2)) li

  method print f t expr = Format.fprintf f "@[%a display.@]" self#exprp expr

  method exprp f e =
    match Expr.unfix e with
    | Expr.BinOp _
    | Expr.Lief _ -> self#expr f e
    | _ -> Format.fprintf f "(%a)" self#expr e

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
    | Some ( (t, params, code) ) ->
      self#expand_macro_apply f var t params code li
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
                     self#expr b)
                 (fun t f1 e1 f2 e2 ->
                   Format.fprintf t "%a@ %a" f1 e1 f2 e2
                 )
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
        (print_list self#binding
        (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)
        ) li

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
             )
             (fun t f1 e1 f2 e2 -> Format.fprintf t
                 "%a@ %a" f1 e1 f2 e2)) tl
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
      (fun f pa a pb b -> Format.fprintf f "%a%a" pa a pb b) f li

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
    | Type.Char -> Format.fprintf f "%a%a self read_char." (self#mutable0 false) m self#operator_affect m
    | Type.Integer -> Format.fprintf f "%a%a self read_int." (self#mutable0 false) m self#operator_affect m
    | _ -> assert false

  method header f () =
    let p f li =
      print_list (fun f s -> Format.fprintf f "%s" s)
        (fun t f1 e1 f2 e2 -> Format.fprintf t "%a@\n%a" f1 e1 f2 e2)
         f li
    in Format.fprintf f "|buffer|@\n@[<v 2>read_int [|o|@\n%a@]@\n]@\n@[<v 2>skip [@\n%a@]@\n]@\n@[<v 2>read_char [|o|@\n%a@]@\n]@\n"
      p [ 
    "((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].";
    " o := 0.";
    "(buffer isNil) ifFalse:[";
    "(buffer =~ '^(-?\\d+)' asRegex) ifMatched: [:match |";
    "o := match at: 1.";
    "buffer := buffer allButFirst:(o size).";
    "].";
    "^o asInteger. ]" ]
      p [
    " ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].";
    "(buffer isNil) ifFalse:[";
    "(buffer =~ '^(\\s+)') ifMatched: [:match | buffer := buffer allButFirst:((match at: 1) size).].";
    "]"]
      p [
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
             self#expr expr
         )
         (fun t f1 e1 f2 e2 ->
           Format.fprintf t
             "%a@\n%a" f1 e1 f2 e2) f li

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
                 (fun f pa a pb b -> Format.fprintf f "%a %a" pa a pb b)
              ) li
              (print_list
                 (fun f (name, t) -> Format.fprintf f "%s [ ^%s ]" name name)
                 (fun f pa a pb b -> Format.fprintf f "%a@\n%a" pa a pb b)
              ) li
              (print_list
                 (fun f (name, t) -> Format.fprintf f "%s: %s [ %s := %s. ] " name n name n)
                 (fun f pa a pb b -> Format.fprintf f "%a@\n%a" pa a pb b)
              ) li
        | _ -> ()
      end
      | _ -> ())
      (fun t print1 item1 print2 item2 ->
        Format.fprintf t "%a%a" print1 item1 print2 item2
      )
      f li

  method prog f (prog: Utils.prog) =
    Format.fprintf f "%a@[<v2>Object subclass: %s [@\n%a%a%a@]@\n]@\nEval [ (%s new) main. ]@\n"
      self#structDeclarations prog.Prog.funs
      prog.Prog.progname
      self#header ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main
      prog.Prog.progname
end
