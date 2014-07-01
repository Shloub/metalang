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
 *)

(** Pascal Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Printer

class pasPrinter = object(self)
  inherit printer as super

  method lang () = "pas"


  method hasSelfAffect op = false

  val mutable current_function = ""
  val mutable bindings = BindingSet.empty

  method comment f str =
    Format.fprintf f "{%s}" str

  method binop f op a b =
    let print_op op f a =
      match op with
      | Expr.Div ->
        if Typer.is_int (super#getTyperEnv ()) a
        then Format.fprintf f "Div"
        else self#print_op f op
      | _ -> self#print_op f op
    in
    let chf op side f x = match (Expr.unfix x) with
      | Expr.BinOp (_, op2, _) ->
        begin match (op, side, op2) with
        | ((Expr.Eq | Expr.Diff | Expr.Lower |
            Expr.LowerEq | Expr.Higher | Expr.HigherEq
        ), _, (Expr.And | Expr.Or)) ->
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
    in Format.fprintf f "%a@ %a@ %a"
    (chf op Left) a
    (print_op op) a
    (chf op Right) b

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "/"
      | Expr.Mod -> "Mod"
      | Expr.Or -> "or"
      | Expr.And -> "and"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | Expr.Eq -> "="
      | Expr.Diff -> "<>"
      )

  method unop f op a =
    let pop f () = match op with
      | Expr.Neg -> Format.fprintf f "-"
      | Expr.Not -> Format.fprintf f "not "
    in if self#nop (Expr.unfix a) then
        Format.fprintf f "%a%a" pop () self#expr a
      else
        Format.fprintf f "%a(%a)" pop () self#expr a


  method char f c = Format.fprintf f "#%d" (int_of_char c)

  method string f i =
    Format.fprintf f "'";
    String.fold_left (fun () c ->
      let ns = match c with
        | '\t' | '\r'
        | '\n' -> "'#"^(string_of_int (int_of_char c))^"'"
        | _ -> String.of_char c
      in Format.fprintf f "%s" ns
    ) () i;
    Format.fprintf f "'"

  method whileloop f expr li =
    Format.fprintf f "@[<h>while %a@] do@\n%a;"
      self#expr expr
      self#bloc li

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ %a@ :=@ %a@ to @ %a do@\n@]%a;"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#bloc li


  method declaration f var t e =
    Format.fprintf f "@[<h>%a@ :=@ %a;@]"
      self#binding var
      self#expr e

  val mutable declared_types : string TypeMap.t = TypeMap.empty

  method ptype f t =
    match TypeMap.find_opt t declared_types with
    | Some s -> Format.fprintf f "%s" s
    | None ->
      match Type.unfix t with
      | Type.Integer -> Format.fprintf f "Longint"
      | Type.String -> Format.fprintf f "char*"
      | Type.Array a -> Format.fprintf f "array of %a" self#ptype a
      | Type.Void ->  Format.fprintf f "void"
      | Type.Bool -> Format.fprintf f "boolean"
      | Type.Char -> Format.fprintf f "char"
      | Type.Named n -> Format.fprintf f "%s" n
      | Type.Struct li -> Format.fprintf f "a struct"
      | Type.Enum _ -> Format.fprintf f "an enum"
      | Type.Lexems | Type.Auto -> assert false

  method print_proto f (funname, t, li) =
    match Type.unfix t with
    | Type.Void ->
      Format.fprintf f "@[<h>procedure %a(%a);@]"
        self#funname funname
        (print_list
           (fun t (binding, type_) ->
             Format.fprintf t "%a : %a"
               self#binding binding
               self#ptype type_
           )
           (fun t f1 e1 f2 e2 -> Format.fprintf t
             "%a;@ %a" f1 e1 f2 e2)
        ) li
    | _ ->
      Format.fprintf f "@[<h>function %a(%a) : %a;@]"
        self#funname funname
        (print_list
           (fun t (binding, type_) ->
             Format.fprintf t "%a : %a"
               self#binding binding
               self#ptype type_
           )
           (fun t f1 e1 f2 e2 -> Format.fprintf t
             "%a;@ %a" f1 e1 f2 e2)
        ) li
        self#ptype t

  method print_body f instrs =
    Format.fprintf f "%a@\nbegin@\n@[<v 2>  %a@]@\nend"
      self#declarevars instrs
      self#instructions instrs

  method print_fun f funname t li instrs =
    let () = current_function <- funname in
    self#declare_type f t;
    self#declare_types f instrs;
    List.iter (fun (_, t) -> self#declare_type f t) li;
    Format.fprintf f "%a%a;@\n"
      self#print_proto (funname, t, li)
      self#print_body instrs

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<h>if@ %a@]@\nthen@\n@[<v2>  %a;@]"
        self#expr e
        self#bloc ifcase
    | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a@] then@\n@[<v 2>  %a@]@\nelse %a;"
        self#expr e
        self#bloc ifcase
        self#instr instr
    | _ ->
      Format.fprintf f "@[<h>if@ %a@]@\nthen@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a;@]"
        self#expr e
        self#bloc ifcase
        self#bloc elsecase

  method declare_type f t =
    match Type.unfix t with
    | Type.Array _ ->
      begin
        match TypeMap.find_opt t declared_types with
        | Some _ -> ()
        | None ->
          let name : string = Fresh.fresh () in
          Format.fprintf f "type %s = %a;@\n" name self#ptype t;
          declared_types <- TypeMap.add t name declared_types
      end
    | _ -> ()

  method declare_types f instrs =
    List.fold_left
      (Instr.Writer.Deep.fold
         (fun () i ->
           match Instr.Fixed.unfix i with
           | Instr.Declare (b, t, _, _) ->
             self#declare_type f t
           | Instr.AllocArray (b, t, _, _) ->
             self#declare_type f t
           | Instr.AllocRecord (b, t, _) ->
             self#declare_type f t
           | _ -> ()
         )
      )
      ()
      instrs


  method declarevars f instrs =
    let bindings = self#declaredvars BindingMap.empty instrs
    in
    if bindings = BindingMap.empty then ()
    else
      Format.fprintf f "@\n@[<v 2>var%a@]"
        (BindingMap.fold
           (fun key value next f () ->
             Format.fprintf f "%a@\n%a : %a;"
               next ()
               self#binding key
               self#ptype value
           )
           bindings
           (fun f () -> ())
        )
        ()

  method declaredvars bindings instrs =
    List.fold_left
      (Instr.Writer.Deep.fold
         (fun bindings i ->
           match Instr.Fixed.unfix i with
           | Instr.Loop (b, _, _, _) ->
             BindingMap.add b Type.integer bindings
           | Instr.Declare (b, t, _, _) ->
             BindingMap.add b t bindings
           | Instr.AllocArray (b, t, _, _) ->
             BindingMap.add b (Type.array t) bindings
           | Instr.AllocRecord (b, t, _) ->
             BindingMap.add b t bindings
           | _ -> bindings
         )
      )
      bindings
      instrs


  method allocrecord f name t el =
    Format.fprintf f "new(%a);@\n%a"
      self#binding name
      (self#def_fields name) el


  method mutable_ f m =
    match Mutable.unfix m with
    | Mutable.Dot (m, field) ->
      Format.fprintf f "%a^.%a"
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


  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
        Format.fprintf f "%a^.%a := %a;"
          self#binding name
          self#field fieldname
          self#expr expr
      )
      (fun t f1 e1 f2 e2 ->
        Format.fprintf t
          "%a@\n%a" f1 e1 f2 e2)
      f
      li

  method stdin_sep f =
    Format.fprintf f "@[<h>skip();@]"

  method read f t m = match Type.unfix t with
  | Type.Integer ->
    Format.fprintf f "@[<h>%a := read_int_();@]"
      self#mutable_ m
  | Type.Char ->
    Format.fprintf f "@[<h>%a := read_char_();@]"
      self#mutable_ m
  | _ -> assert false (* type non géré*)

  method print f t expr =
    Format.fprintf f "@[<h>Write(%a);@]" self#expr expr

  method allocarray f binding type_ len =
    Format.fprintf f "@[<h>SetLength(%a, %a);@]"
      self#binding binding
      self#expr len

  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "program %s;@\n%a%s%s%s%s%s@\n%a%a.@\n@\n"
      prog.Prog.progname
      (fun f () ->
        if Tags.is_taged "use_math"
        then Format.fprintf f "Uses math;@\n"
      ) ()
      (if need then "
var global_char : char;
var global_has_char : boolean;

procedure skip_char();
begin
   global_has_char := true;
   read(global_char);
end; " else "")
      ( if need_stdinsep then "
procedure skip();
var
   n : char;
   t : char;
   s : char;
begin
   n := #13;
   t := #10;
   s := #32;
   if not( global_has_char ) then
      skip_char();
   while (global_char = s) or (global_char = n) or (global_char = t) do
   begin
      skip_char();
   end;
end;" else "")
      (if need_readint || need_readchar then "
function read_char_aux() : char;
begin
   if global_has_char then
      read_char_aux := global_char
   else
   begin
      skip_char();
      read_char_aux := global_char;
   end
end;" else "")
      (if need_readchar then "
function read_char_() : char;
var
   c : char;
begin
   c := read_char_aux();
   skip_char();
   read_char_ := c;
end;" else "")
      (if need_readint then "
function read_int_() : Longint;
var
   c    : char;
   i    : Longint;
   sign :  Longint;
begin
   i := 0;
   c := read_char_aux();
   if c = '-' then begin
      skip_char();
      sign := -1;
   end
   else
      sign := 1;

   repeat
      c := read_char_aux();
      if (ord(c) <=57) and (ord(c) >= 48) then
      begin
         i := i * 10 + ord(c) - 48;
         skip_char();
      end
      else
         exit(i * sign);
   until false;
end;
" else "")
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main


  method main f main =
    self#print_body f main

  method affect f mutable_ (expr : Utils.expr) =
    Format.fprintf f "@[<h>%a@ :=@ %a;@]" self#mutable_ mutable_ self#expr expr


  method bloc f li = Format.fprintf f "@[<v 2>begin@\n%a@]@\nend"
    (print_list self#instr (fun t f1 e1 f2 e2 -> Format.fprintf t
      "%a@\n%a" f1 e1 f2 e2)) li

  method return f e =
    (*    Format.fprintf f "@[<h>%a@ :=@ %a;@]"
          self#binding current_function
          self#expr e
    *)
    Format.fprintf f "@[<h>exit(%a);@]"
      self#expr e

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        Format.fprintf f "type@[<v>@\n%a=^%a_r;@\n%a_r = record@\n@[<v 2>  %a@]@\nend;@]@\n"
          self#binding name
          self#binding name
          self#binding name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "%a : %a;" self#binding name self#ptype type_
             )
             (fun t fa a fb b -> Format.fprintf t "%a@\n%a" fa a fb b)
          ) li


    | Type.Enum li ->
      Format.fprintf f "Type %a = (@\n@[<v2>  %a@]);@\n"
        self#binding name
        (print_list
           (fun t name ->
             self#binding t name
           )
           (fun t fa a fb b -> Format.fprintf t "%a,@\n %a" fa a fb b)
        ) li

    | _ ->
      Format.fprintf f "type %a = %a;"
        super#ptype t
        super#binding name


end
