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

(** scala Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast

let buffer = "
var buffer = \"\";
"
let readchar = "def read_char() : Char = {
  if (buffer != null && buffer == \"\") buffer = readLine();
  var c = buffer.charAt(0);
  buffer = buffer.substring(1);
  return c;
}
"
let readint = "def read_int() : Int = {
  if (buffer != null && buffer == \"\") buffer = readLine();
  var sign = 1;
  if (buffer != null && buffer.charAt(0) == '-'){
    sign = -1;
    buffer = buffer.substring(1);
  }
  var c = 0;
  while (buffer != null && buffer != \"\" && buffer.charAt(0).isDigit){
    c = c * 10 + buffer.charAt(0).asDigit;
    buffer = buffer.substring(1);
  }
  return c * sign;
}
"
let skip = "def skip() {
  if (buffer != null && buffer == \"\") buffer = readLine();
  while (buffer != null && buffer != \"\" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\\t' || buffer.charAt(0) == '\\n' || buffer.charAt(0) == '\\r'))
    buffer = buffer.substring(1);
}
"

let print_expr tyenv macros e f p =
  let open Format in
  let open Expr in
  let print_expr0 config e f prio_parent = match e with
  | Record li -> begin match li with
    | (field, _)::_ ->
        let t = Typer.typename_for_field field tyenv in
        fprintf f "new %s(%a)"
          (String.capitalize t)
          (print_list
             (fun f (_fieldname, expr) -> expr f nop) sep_c
          )
          li
    | _ -> assert false
  end
  | _ -> print_expr0 config e f prio_parent in
  let print_mut conf prio f m = Mutable.Fixed.Deep.fold
      (print_mut0 "%a%a" "(%a)" "%a.%s" conf) m f prio in
  let print_lief prio f l = match l with
  | Char c -> unicode f c
  | String s -> fprintf f "%S" s
  | Integer i ->
      if i < 0 then parens prio (-1) f "%i" i
      else Format.fprintf f "%i" i
  | Bool true -> fprintf f "true"
  | Bool false -> fprintf f "false"
  | Enum s -> fprintf f "%s" s
  in
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

class scalaPrinter = object(self)
  inherit CPrinter.cPrinter as printer

  method expr f e = print_expr (self#getTyperEnv ()) 
      (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) e f nop

  method lang () = "scala"

  method multi_read f li = self#base_multi_read f li

  method hasSelfAffect op = false

  method header f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "%s%s%s%s@\n"
      (if need then buffer else "")
      (if need_readint then readint else "")
      (if need_readchar then readchar else "")
      (if need_stdinsep then skip else "")
     
  method stdin_sep f = Format.fprintf f "@[skip();@]"

  method untuple f li e =
    Format.fprintf f "var (%a) = %a"
      (print_list self#binding sep_c) (List.map snd li)
      self#expr e

  method read_decl f t v =
    Format.fprintf f "var %a"
      (fun f () -> self#read f t (Mutable.var v)) ()

  method read f t m =
    match Type.unfix t with
    | Type.Char -> Format.fprintf f "%a = read_char()" self#mutable_set m
    | Type.Integer -> Format.fprintf f "%a = read_int()" self#mutable_set m
    | _ -> assert false

  method prog f prog =
    Format.fprintf f
      "object %s@\n@[<v 2>{@\n%a%a@\n%a@]@\n}@\n"
      prog.Prog.progname
      self#header prog
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  (** bindings by reference *)
  val mutable refbindings = BindingSet.empty

  method ref_alias f li = match li with
  | [] -> ()
  | (name, _) :: tl ->
    let b = BindingSet.mem name refbindings in
    if b then
      Format.fprintf f "var %a = _%a;@\n%a"
        self#binding name
        self#binding name
        self#ref_alias tl
    else
      self#ref_alias f tl

 method print_fun f funname (t : unit Type.Fixed.t) li instrs =
   self#calc_refs instrs;
   let li_fori, li_forc = self#collect_for instrs in
   Format.fprintf f "@[<h>%a@]{@\n@[<v 2>  %a%a%a%a@]@\n}@\n"
     self#print_proto (funname, t, li)
     self#ref_alias li
     (self#declare_for "int") li_fori
     (self#declare_for "char") li_forc
     self#instructions instrs
     
  (** find references variables from a list of instructions *)
  method calc_refs instrs =
    let g acc i =
      match Instr.unfix i with
      | Instr.Read li ->
          List.fold_left (fun acc -> function
            | Instr.ReadExpr (_, Mutable.Fixed.F (_, Mutable.Var varname)) -> BindingSet.add varname acc
            | _ -> acc) acc li
      | Instr.Affect (Mutable.Fixed.F (_, Mutable.Var varname), _)
      | Instr.SelfAffect (Mutable.Fixed.F (_, Mutable.Var varname), _, _) ->
          BindingSet.add varname acc
      | _ -> acc
    in let g acc i = Instr.Writer.Deep.fold g (g acc i) i
    in refbindings <- List.fold_left g BindingSet.empty instrs

  method print_proto f (funname, t, li) =
    Format.fprintf f "def %a(%a)%a"
      self#funname funname
      (print_list
         (fun t (binding, type_) ->
           if BindingSet.mem binding refbindings then
             Format.fprintf t "_%a :@ %a" self#binding binding self#ptype type_
           else
             Format.fprintf t "%a :@ %a" self#binding binding self#ptype type_
         ) sep_c
      ) li
      (fun f t ->
        match Type.unfix t with
        | Type.Void -> ()
        | _ -> Format.fprintf f ": %a = " self#ptype t
      ) t

  method main f main =
    Format.fprintf f "def main(args : Array[String])@\n@[<v 2>{@\n%a@]@\n}@\n"
      self#instructions main

  method declaration f var t e =
    Format.fprintf f "@[<h>var@ %a: %a@ =@ %a%a@]"
      self#binding var
      self#ptype t
      self#expr e
      self#separator ()

  method ptype f t =
    let open Type in
    let open Format in
    let ptype ty f () = match ty with
    | Integer -> fprintf f "Int"
    | String -> fprintf f "String"
    | Array a -> fprintf f "Array[%a]" a ()
    | Void ->  fprintf f "Unit"
    | Bool -> fprintf f "Boolean"
    | Char -> fprintf f "Char"
    | Named n -> self#typename f n
    | Enum _ -> fprintf f "an enum"
    | Struct _ -> fprintf f "a struct"
    | Tuple li -> fprintf f "(%a)" (print_list (fun f x -> x f ()) sep_c) li
    | Auto | Lexems -> assert false
in Fixed.Deep.fold ptype t f ()

  method typename f n = Format.fprintf f "%s" (String.capitalize n)

  method decl_type f name t =
    match (Type.unfix t) with
      Type.Struct li ->
        (* TODO trier les champs *)
        Format.fprintf f "class %a(%a){@\n@[<v 2>  %a@]@\n}@\n"
          self#typename name
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "_%a: %a" self#field name self#ptype type_
             ) sep_c
          ) li
          (print_list
             (fun t (name, type_) ->
               Format.fprintf t "var %a: %a=_%a%a" self#field name self#ptype type_ self#field name self#separator ()
             ) sep_nl
          ) li
    | Type.Enum li ->
      Format.fprintf f "object %a extends Enumeration {@\n  type %a = Value;@\n  val %a = Value@\n}@\nimport %a._"
        self#typename name
        self#typename name
        (print_list (fun f s -> Format.fprintf f "%s" s) sep_c) li
          self#typename name
    | _ -> assert false

  method record f li =
    match li with
    | (field, _)::_ ->
        let t = Typer.typename_for_field field (self#getTyperEnv ()) in
        Format.fprintf f "new %a(%a)"
          self#typename t
          (print_list
             (fun f (fieldname, expr) -> self#expr f expr) sep_c
          )
          li
    | _ -> assert false

  method allocrecord f name t el = (* TODO trier les champs *)
    Format.fprintf f "var %a = %a%a"
      self#binding name
      self#record el
      self#separator ()

  method m_field f m field = Format.fprintf f "%a.%a" self#mutable_get m self#field field

  method m_array f m indexes =
      Format.fprintf f "%a(%a)"
        self#mutable_get m
        (print_list
           self#expr
           (fun f f1 e1 f2 e2 ->
             Format.fprintf f "%a)(%a" f1 e1 f2 e2
           ))
        indexes

  method collect_for instrs =
    let collect acc i =
      Instr.Writer.Deep.fold (fun (acci, accc) i -> match Instr.unfix i with
      | Instr.Loop (i, _, _, _) -> let acci = if List.mem i acci then acci else i::acci in acci, accc
      | _ -> (acci, accc)
      ) acc i
    in
    List.fold_left collect ([], []) instrs

  method declare_for s f li =
    if li <> [] then
      Format.fprintf f "%a@\n"
        (print_list (fun f b -> Format.fprintf f "var %a: Int=0;" self#binding b)
           sep_nl ) li

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for (%a <- %a to %a)@\n%a@]"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#bloc li

  method allocarray f binding type_ len _ =
    Format.fprintf f "@[<h>var %a@ :Array[%a]@ =@ new Array[%a](%a)%a@]"
      self#binding binding
      self#ptype type_
      self#ptype type_
      self#expr len
      self#separator ()

end
