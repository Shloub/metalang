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

(** Main printer
    This printer write metalang code.
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Stdlib

type oppart =
| Left | Right

let print_option (f : Format.formatter -> 'a -> unit) t obj =
  match obj with
  | None -> ()
  | Some s -> f t s

let print_list
    (func : Format.formatter -> 'a -> unit)
    (sep :
       Format.formatter ->
     (Format.formatter -> 'a -> unit) -> 'a ->
     (Format.formatter -> 'a list -> unit) -> 'a list ->
     unit
    )
    (f : Format.formatter)
    (li : 'a list)
    : unit
    =
  let rec p t = function
    | [] -> ()
    | [hd] -> func t hd
    | hd::tl ->
      sep
        t
        func hd
        p tl
  in p f li

let print_list_indexed print sep f li =
  print_list
    (fun f (toprint, index) ->
      print f toprint index
    )
    sep
    f
    (snd (List.fold_left_map
            (fun i m -> (i+1), (m, i))
            0
            li
     ))

let format_type t = match Type.unfix t with
  | Type.Integer -> "%d"
  | Type.Char -> "%c"
  | Type.String ->  "%s"
  | Type.Bool -> "%b"
  | _ -> raise (Warner.Error (fun f -> Format.fprintf f "invalid type %s for format\n" (Type.type_t_to_string t)))

class printer = object(self)

  (** used variables *)
  val mutable used_variables = BindingSet.empty

  method used_affect () = false
  method calc_used_variables (instrs : Utils.instr list ) =
    let rec fold_expr acc e =
      match Expr.unfix e with
      | Expr.Access m -> Mutable.Writer.Deep.fold fold_mut acc m
      | _ -> acc
    and fold_mut acc m = match Mutable.unfix m with
      | Mutable.Var varname -> BindingSet.add varname acc
      | Mutable.Array (_, lie) -> List.fold_left
        dfold_expr acc lie
      | _ -> acc
    and dfold_expr acc e =
      Expr.Writer.Deep.fold fold_expr
        (fold_expr acc e) e
    in
    let fold_instr acc i =
      let acc = Instr.fold_expr dfold_expr acc i in
      Instr.Writer.Deep.fold (fun acc i -> match Instr.unfix i with
      | Instr.Affect (m, e) ->
        begin match Mutable.unfix m with
        | Mutable.Var var ->
          if self#used_affect () then BindingSet.add var acc
          else acc
        | _ -> Mutable.Writer.Deep.fold fold_mut acc m
        end
      | _ -> acc) acc i
    in
    used_variables <-
      List.fold_left fold_instr BindingSet.empty
      instrs


  val mutable typerEnv : Typer.env = Typer.empty

  method typename_of_field field = Typer.typename_for_field field typerEnv

  method getTyperEnv () = typerEnv

  method setTyperEnv t = typerEnv <- t

  val mutable macros = BindingMap.empty

  method binding f i = Format.fprintf f "%s" i
  method funname f i = Format.fprintf f "%s" i
  method string f i = Format.fprintf f "%S" i (* TODO faire mieux *)

  method declaration f var t e =
    Format.fprintf f "@[<h>def %a@ %a@ =@ %a@]"
      self#ptype t
      self#binding var
      self#expr e

  method affect f mutable_ (expr : 'lex Expr.t) =
    Format.fprintf f "@[<h>%a@ =@ %a;@]" self#mutable_ mutable_ self#expr expr

  method bloc f li = Format.fprintf f "@[<v 2>do@\n%a@]@\nend"
    (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
      "%a@\n%a" f1 e1 f2 e2)) li

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ %a=%a@ to@ %a@\n@]%a"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#bloc li

  method whileloop f expr li =
    Format.fprintf f "@[<h>while %a@]@\n%a"
      self#expr expr
      self#bloc li


  method comment f str =
    Format.fprintf f "/*%s*/" str

  method return f e =
    Format.fprintf f "@[<h>return@ %a@]" self#expr e

  method ptype f (t:Type.t) =
    match Type.unfix t with
    | Type.Tuple li ->
      Format.fprintf f "@[<h>(%a)@]"
        (print_list self#ptype
           (fun t fa a fb b -> Format.fprintf t "%a, %a" fa a fb b)
        ) li
    | Type.Auto -> ()
    | Type.Integer -> Format.fprintf f "int"
    | Type.String -> Format.fprintf f "string"
    | Type.Array a -> Format.fprintf f "array<%a>" self#ptype a
    | Type.Void ->  Format.fprintf f "void"
    | Type.Bool -> Format.fprintf f "bool"
    | Type.Char -> Format.fprintf f "char"
    | Type.Named n -> Format.fprintf f "@@%s" n
    | Type.Lexems -> Format.fprintf f "lexems"
    | Type.Struct li ->
      Format.fprintf f "record@\n @[<v>%a@]@\nend"
        (print_list
           (fun t (name, type_) ->
             Format.fprintf t "%a : %a;" self#binding name self#ptype type_
           )
           (fun t fa a fb b -> Format.fprintf t "%a%a" fa a fb b)
        ) li
    | Type.Enum li ->
      Format.fprintf f "enum{%a}"
        (print_list
           (fun t name ->
             Format.fprintf t "%a " self#binding name
           )
           (fun t fa a fb b -> Format.fprintf t "%a%a" fa a fb b)
        ) li

  method allocarray f binding type_ len =
    Format.fprintf f "@[<h>def array<%a> %a[%a]"
      self#ptype type_
      self#binding binding
      self#expr len


  method allocarray_lambda f binding type_ len binding2 lambda =
    Format.fprintf f "@[<h>def array<%a>%a[%a] with %a do@\n@[<v 2>  %a@]@\nend@]"
      self#ptype type_
      self#binding binding
      self#expr len
      self#binding binding2
      self#instructions lambda

  method field f field =
    Format.fprintf f "%s" field

  method mutable_ f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) ->
      Format.fprintf f "%a.%a"
        self#mutable_ m
        self#field field
    | Mutable.Var binding -> self#binding f binding
    | Mutable.Array (m, indexes) ->
      Format.fprintf f "%a[%a]"
        self#mutable_ m
        (print_list
           self#expr
           (fun f f1 e1 f2 e2 ->
             Format.fprintf f "%a][%a" f1 e1 f2 e2
           ))
        indexes

  method expand_macro_apply f name t params code li =
    self#expand_macro_call f name t params code li

  method lang () = "abstract"

  method expand_macro_call f name t params code li =
    let lang = self#lang () in
    let code_to_expand = List.fold_left
      (fun acc (clang, expantion) ->
        match acc with
        | Some _ -> acc
        | None ->
          if clang = "" or clang = lang then
            Some expantion
          else None
      ) None
      code
    in match code_to_expand with
    | None -> failwith ("no definition for macro "^name^" in language "^lang)
    | Some s ->
      let listr = List.map
        (fun e ->
          let b = Buffer.create 1 in
          let fb = Format.formatter_of_buffer b in
          Format.fprintf fb "@[<h>%a@]%!" self#expr e;
          Buffer.contents b
        ) li in
      let expanded = List.fold_left
        (fun s ((param, _type), string) ->
          String.replace ("$"^param) string s
        )
        s
        (List.combine params listr)
      in Format.fprintf f "%s" expanded

  method call f var li =
    match BindingMap.find_opt var macros with
    | Some ( (t, params, code) ) ->
      self#expand_macro_call f var t params code li
    | None ->
      Format.fprintf
        f
        "@[<h>%a(%a);@]"
        self#funname var
        (print_list
           self#expr
           (fun t f1 e1 f2 e2 ->
             Format.fprintf t "%a,@ %a" f1 e1 f2 e2
           )
        ) li

  method apply f var li =
    match BindingMap.find_opt var macros with
    | Some ( (t, params, code) ) ->
      self#expand_macro_apply f var t params code li
    | None ->
      Format.fprintf
        f
        "%a(%a)"
        self#funname var
        (print_list
           self#expr
           (fun t f1 e1 f2 e2 ->
             Format.fprintf t "%a,@ %a" f1 e1 f2 e2
           )
        ) li

  method stdin_sep f =
    Format.fprintf f "@[skip@]"

  method def_fields name f li =
    Format.fprintf f "@[<h>%a@]"
      (print_list
         (fun f (fieldname, expr) ->
           Format.fprintf f "%a = %a"
             self#field fieldname
             self#expr expr
         )
         (fun t f1 e1 f2 e2 ->
           Format.fprintf t
             "%a@\n%a" f1 e1 f2 e2))
      li

  method allocrecord f name t el =
    Format.fprintf f "def %a %a = with %a end"
      self#ptype t
      self#binding name
      (self#def_fields name) el

  method selfAssoc f m e2 = function
  | Expr.Add -> begin match Expr.unfix e2 with
    | Expr.Integer 1 ->
      Format.fprintf f "@[<h>%a ++;@]" self#mutable_ m
    | _ ->
      Format.fprintf f "@[<h>%a += %a;@]" self#mutable_ m
        self#expr e2
  end
  | Expr.Sub ->
    begin match Expr.unfix e2 with
    | Expr.Integer 1 ->
      Format.fprintf f "@[<h>%a --;@]" self#mutable_ m
    | _ ->
      Format.fprintf f "@[<h>%a -= %a;@]" self#mutable_ m
        self#expr e2
    end
  | Expr.Mul ->
    Format.fprintf f "@[<h>%a *= %a;@]" self#mutable_ m self#expr e2
  | Expr.Div ->
    Format.fprintf f "@[<h>%a /= %a;@]" self#mutable_ m self#expr e2
  | Expr.Mod ->
    Format.fprintf f "@[<h>%a %%= %a;@]" self#mutable_ m self#expr e2
  | _ -> assert false

  method hasSelfAffect op = true

  method instr f t =
    match Instr.unfix t with
    | Instr.Tag s ->  Format.fprintf f "tag %s@\n" s
    | Instr.Unquote li -> Format.fprintf f "${%a}" self#expr li
    | Instr.StdinSep -> self#stdin_sep f
    | Instr.Declare (varname, type_, expr, _option) -> self#declaration f varname type_ expr
    | Instr.Affect (mutable_, expr) ->
      begin match Expr.unfix expr with
      | Expr.BinOp (e1, op, e2) ->
        let fallback () =
          if op = Expr.Add || op = Expr.Mul then
            begin match Expr.unfix e2 with
            | Expr.Access m ->
              if Mutable.equals (=) m mutable_ then
                self#selfAssoc f m e1 op
              else self#affect f mutable_ expr
            | _ -> self#affect f mutable_ expr
            end
          else self#affect f mutable_ expr
        in
        if self#hasSelfAffect op then
          begin match Expr.unfix e1 with
          | Expr.Access m ->
            if Mutable.equals (=) m mutable_ then
              self#selfAssoc f m e2 op
            else fallback ()
          | _ -> fallback ()
          end
        else self#affect f mutable_ expr
      | _ -> self#affect f mutable_ expr
      end
    | Instr.Loop (varname, expr1, expr2, li) ->
      self#forloop f varname expr1 expr2 li
    | Instr.While (expr, li) ->
      self#whileloop f expr li
    | Instr.Comment str -> self#comment f str
    | Instr.Return e -> self#return f e
    | Instr.AllocRecord (name, t, el) ->
      self#allocrecord f name t el
    | Instr.AllocArray (binding, type_, len, None) ->
      self#allocarray f binding type_ len
    | Instr.AllocArray (binding, type_, len, Some ( (b, l) )) ->
      self#allocarray_lambda f binding type_ len b l
    | Instr.If (e, ifcase, elsecase) ->
      self#if_ f e ifcase elsecase
    | Instr.Call (var, li) -> self#call f var li

    | Instr.Read (t, mutable_) -> self#read f t mutable_
    | Instr.DeclRead (t, var, _option) -> self#read_decl f t var
    | Instr.Print (t, expr) -> self#print f t expr
    | Instr.Untuple (li, e) -> self#untuple f li e

  method untuple f li e =
    Format.fprintf f "(%a) = %a"
      (print_list self#binding
         (fun t fa a fb b -> Format.fprintf t "%a, %a" fa a fb b)
      ) (List.map snd li)
      self#expr e


  method noformat s = let s = Format.sprintf "%S" s
                      in String.replace "%" "%%" s

  method format_type f (t:Type.t) = Format.fprintf f "%s" (format_type t)

  method read f t mutable_ =
    Format.fprintf f "@[read %a %a@]" self#ptype t self#mutable_ mutable_

  method read_decl f t v =
    Format.fprintf f "@[def read %a %a@]"
      self#ptype t
      self#binding v

  method print f t expr =
    Format.fprintf f "@[print %a %a@]" self#ptype t self#expr expr

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<h>if@ %a@]@\nthen@\n@[<v2>  %a@]@\nend"
        self#expr e
        self#instructions ifcase
    | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a@] then@\n@[<v 2>  %a@]@\nels%a"
        self#expr e
        self#instructions ifcase
        self#instr instr
    | _ ->
      Format.fprintf f "@[<h>if@ %a@]@\nthen@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]@\nend"
        self#expr e
        self#instructions ifcase
        self#instructions elsecase

  method bool f = function
  | true -> Format.fprintf f "true"
  | false -> Format.fprintf f "false"

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "/"
      | Expr.Mod -> "%"
      | Expr.Or -> "||"
      | Expr.And -> "&&"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | Expr.Eq -> "=="
      | Expr.Diff -> "!="
      )

  method unop f op a =
    let pop f () = match op with
      | Expr.Neg -> Format.fprintf f "-"
      | Expr.Not -> Format.fprintf f "!"
    in if self#nop (Expr.unfix a) then
        Format.fprintf f "%a%a" pop () self#expr a
      else
        Format.fprintf f "%a(%a)" pop () self#expr a

  method nop = function
  | Expr.Integer _ -> true
  | Expr.String _ -> true
  | Expr.Char _ -> true
  | Expr.Bool _ -> true
  | Expr.Access _ -> true
  | Expr.Call (_, _) -> true
  | Expr.Enum _ -> true
  | _ -> false

  method printp f e =
    Format.fprintf f "@[<h 2>(%a)@]" self#expr e

  method chf op side f x = match (Expr.unfix x) with
  | Expr.BinOp (_, op2, _) ->
    begin match (op, side, op2) with
    | ((Expr.Eq | Expr.Diff | Expr.Lower |
        Expr.LowerEq | Expr.Higher | Expr.HigherEq
    ), _, (Expr.Add | Expr.Mul | Expr.Sub | Expr.Div)) ->
      self#expr f x

    | ((Expr.And | Expr.Or), _, (Expr.Eq | Expr.Diff | Expr.Lower |
        Expr.LowerEq | Expr.Higher | Expr.HigherEq
    )) ->
      self#expr f x
    | ((Expr.Add | Expr.Sub), _, (Expr.Mul | Expr.Div | Expr.Mod))
      ->
      self#expr f x
    | (Expr.Sub, Left, (Expr.Sub | Expr.Add))
      ->
      self#expr f x
    | (Expr.Add, _, Expr.Add)
      ->
      self#expr f x
    | (Expr.Mul, _, Expr.Mul)
      ->
      self#expr f x
    | (Expr.And, _, Expr.And)
      ->
      self#expr f x
    | (Expr.Or, _, Expr.Or)
      ->
      self#expr f x
    | _ ->
      self#printp f x
    end
  | _ -> self#expr f x

  method binop f op a b =
    Format.fprintf f "%a@ %a@ %a"
      (self#chf op Left) a
      self#print_op op
      (self#chf op Right) b



  method enum f e =
    Format.fprintf f "%s" e

  method integer f i =
    Format.fprintf f "%i" i

  method lexems f (li : (Parser.token, Utils.expr) Lexems.t list )  =
    Utils.lexems f li

  method expr f t =
    let t = Expr.unfix t in
    match t with
    | Expr.Enum e -> self#enum f e
    | Expr.Lexems li -> self#lexems f li
    | Expr.Bool b -> self#bool f b
    | Expr.UnOp (a, op) -> self#unop f op a
    | Expr.BinOp (a, op, b) -> self#binop f op a b
    | Expr.Integer i -> self#integer f i
    | Expr.String i -> self#string f i
    | Expr.Access m ->
      self#access f m
    | Expr.Call (funname, li) -> self#apply f funname li
    | Expr.Char (c) -> self#char f c
    | Expr.Tuple li -> self#tuple f li
    | Expr.Record li -> self#record f li

  method tuple f li =
    Format.fprintf f "(%a)"
      (print_list self#expr
         (fun t fa a fb b -> Format.fprintf t "%a, %a" fa a fb b)
      ) li

  method record f li =
    Format.fprintf f "record %a end"
      (self#def_fields "") li

  method char f c = Format.fprintf f "%C" c

  method access f m =
    self#mutable_ f m

  method print_proto f (funname, t, li) =
    Format.fprintf f "def@ %a %a(%a)"
      self#ptype t
      self#funname funname
      (print_list
         (fun f (n, t) ->
           Format.fprintf f "%a@ %a"
             self#ptype t
             self#binding n)
         (fun t f1 e1 f2 e2 -> Format.fprintf t
           "%a,@ %a" f1 e1 f2 e2)) li


  method print_fun f funname t li instrs =
    Format.fprintf f "@[<h>%a@]@\n@[<v 2>  %a@]@\nend@\n"
      self#print_proto (funname, t, li)
      self#instructions instrs

  method prog_item f t =
    match t with
    | Prog.Comment s -> self#comment f s;
      Format.fprintf f "@\n"
    | Prog.DeclarFun (var, t, li, instrs) ->
      self#print_fun f var t li instrs;
      Format.fprintf f "@\n"
    | Prog.Macro (name, t, params, code) ->
      macros <- BindingMap.add
        name (t, params, code)
        macros;
      ()
    | Prog.Unquote _ -> assert false
    | Prog.DeclareType (name, t) ->
      self#decl_type f name t;
      Format.fprintf f "@\n"

  method decl_type f name t =
    match (Type.unfix t) with
    | Type.Struct li ->
      Format.fprintf f "record %a %a@\nend@\n"
        self#binding name
        (print_list
           (fun t (name, type_) ->
             Format.fprintf t "%a %a;@\n" self#ptype type_ self#binding name
           )
           (fun t fa a fb b -> Format.fprintf t "%a%a" fa a fb b)
        ) li
    | Type.Enum li ->
      Format.fprintf f "enum %a @\n@[<v2>  %a@]@\nend@\n"
        self#binding name
        (print_list
           (fun t name ->
             self#binding t name
           )
           (fun t fa a fb b -> Format.fprintf t "%a@\n %a" fa a fb b)
        ) li
    | _ ->
      Format.fprintf f "type %a = %a;" self#binding name self#ptype t

  method prog f (prog: Utils.prog) =
    Format.fprintf f "%a%a@\n"
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method multi_print f format exprs =
    Format.fprintf f "@[<v>%a@]"
      (print_list
         (fun f (t, e) -> self#print f t e)
         (fun t f1 e1 f2 e2 -> Format.fprintf t "%a@\n%a" f1 e1 f2 e2)) exprs

  method combine_formats () = false

  method multiread f instrs =
    (print_list
       self#instr
       (fun t print1 item1 print2 item2 ->
         Format.fprintf t "%a@\n%a" print1 item1 print2 item2
       )
    ) f instrs

  method is_print i = match Instr.unfix i with
  | Instr.Print _ -> true
  | _ -> false

  method is_stdin i = match Instr.unfix i with
  | Instr.Read _ -> true
  | Instr.DeclRead _ -> true
  | Instr.StdinSep -> true
  | _ -> false

  method instructions0 f instrs =
    if List.for_all self#is_stdin instrs then
      self#multiread f instrs
    else if (match instrs with [_] -> false | _ -> true)
      && List.for_all self#is_print instrs then
      let li = List.map (fun i -> match Instr.unfix i with
        | Instr.Print (t, i) -> format_type t, (t, i)
        | _ -> assert false
      ) instrs in
      let li =
        if self#combine_formats () then
          List.map ( fun (format, (ty, e)) -> match Expr.unfix e with
          | Expr.String s ->
            let s = self#noformat s in
            (String.sub s 1 ((String.length s) - 2)  , (ty, e))
          | _ -> (format, (ty, e))
          ) li else li in
      let formats, exprs = List.unzip li in
      let rec g acc = function
        | [] -> acc
        | hd::tl -> g (acc ^ hd) tl
      in
      let format = g "" formats in
      let exprs =
        if self#combine_formats () then
          List.filter (fun (ty, e) -> match Expr.unfix e with
          | Expr.String _ -> false
          | _ -> true
          ) exprs
        else exprs
      in
      self#multi_print f format exprs
    else
      (print_list
         self#instr
         (fun t print1 item1 print2 item2 ->
           Format.fprintf t "%a@\n%a" print1 item1 print2 item2
         )
      ) f instrs

  method instructions f instrs =
    let rec g kind acc1 acc2 = function
      | hd::tl ->
        let kind2 = (self#is_print hd, self#is_stdin hd) in
        if kind2 = kind
        then g kind acc1 (hd::acc2) tl
        else g kind2 ((List.rev acc2)::acc1) [hd] tl
      | [] -> List.rev ( (List.rev acc2) :: acc1 )
    in
    let lili = g (false, false) [] [] instrs in
    let lili = List.filter ( (<>) [] ) lili in
    (print_list
       self#instructions0
       (fun t print1 item1 print2 item2 ->
         Format.fprintf t "%a@\n%a" print1 item1 print2 item2
       )
    ) f lili

  method proglist f funs =
    Format.fprintf f "%a"
      (print_list
         self#prog_item
         (fun t print1 item1 print2 item2 ->
           Format.fprintf t "%a%a" print1 item1 print2 item2
         )
      ) funs

  method main f (main : Utils.instr list) =
    Format.fprintf f "main@\n@[<v 2>  %a@]@\nend"
      self#instructions main
end
