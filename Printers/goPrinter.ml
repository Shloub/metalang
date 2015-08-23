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


(** GO Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Ast
open Helper
open Stdlib

let print_expr macros e f p =
  let print_mut conf prio f m = Mutable.Fixed.Deep.fold
      (print_mut0 "%a%a" "[%a]" "(*%a).%s" conf) m f prio in
  let print_lief prio f l =
    let open Format in
    let open Expr in match l with
    | Char c -> clike_char f c
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
  } in Expr.Fixed.Deep.fold (print_expr0 config) e f p

class goPrinter = object(self)
  inherit CPrinter.cPrinter as super

  method expr f e = print_expr
      (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) e f nop

  method lang () = "go"

  method print_fun f funname t li instrs =
    self#calc_used_variables instrs;
    Format.fprintf f "@[<h>%a@]{@\n@[<v 2>  %a@]@\n}@\n"
      self#print_proto (funname, t, li)
      self#instructions instrs

  val mutable reader = false
  method prog f prog =
    let need li = List.exists (Instr.Writer.Deep.fold (fun acc i -> match Instr.unfix i with
      | Instr.Print _ -> true
      | _ -> acc) false) li in
    let need_prog_item = function
      | Prog.DeclarFun (var, t, li, instrs, _) ->
        need instrs
      | _ -> false
    in
    let need_print = (match prog.Prog.main with
      | Some s -> need s
      | None -> false) || List.exists need_prog_item prog.Prog.funs
    in
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    reader <- need;
    Format.fprintf f
      "package main@\n%a%a%a%a%a%a"
      (fun f () -> if need || need_print then Format.fprintf f "import \"fmt\"@\n") ()
      (fun f () ->
        if Tags.is_taged "use_math"
        then Format.fprintf f "import \"math\"@\n"
      ) ()
      (fun f () -> if need then Format.fprintf f "import \"os\"@\nimport \"bufio\"@\nvar reader *bufio.Reader@\n") ()
(fun f () -> if need_stdinsep then Format.fprintf f "
func skip() {
  var c byte
  fmt.Fscanf(reader, \"%%c\", &c)
  if c == '\\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}
") ()
      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method return f e =
    Format.fprintf f "@[<h>return@ %a@]" self#expr e

  method main f main =
    self#calc_used_variables main;
    (if reader then
        Format.fprintf f "func main() {@\n  reader = bufio.NewReader(os.Stdin)@\n  @[<v>%a@]@\n}@\n"
     else
        Format.fprintf f "func main() {@\n  @[<v>%a@]@\n}@\n")
      self#instructions main

  method declaration f var t e =
    Format.fprintf f "@[<h>var %a %a = %a@]%a"
      self#binding var self#ptype t self#expr e
      self#test_unused var

  method printf f () = Format.fprintf f "fmt.Printf"

  method test_unused f var =
    if not (BindingSet.mem var used_variables) then
      Format.fprintf f "@\n@[<h>_ = %a@]"
        self#binding var

  method print_proto f (funname, t, li) =
    Format.fprintf f "func %a(%a) %a"
      self#funname funname
      (print_list
         (fun t (binding, type_) ->
           Format.fprintf t "%a@ %a"
             self#binding binding
             self#prototype type_
         ) sep_c
      ) li
      self#ptype t

  method allocrecord f name t el =
    Format.fprintf f "var %a %a = new (%a)@\n%a"
      self#binding name
      self#ptype t
      self#ptypename t
      (self#def_fields name) el

  method def_fields name f li =
    print_list
      (fun f (fieldname, expr) ->
        Format.fprintf f "@[<h>(*%a).%a=%a@]"
          self#binding name
          self#field fieldname
          self#expr expr
      ) sep_nl
      f
      li

 method m_field f m field =
   Format.fprintf f "(*%a).%a"
     self#mutable_get m
     self#field field

  method ptype f t = match Type.unfix t with
  | Type.Array a -> Format.fprintf f "[]%a" self#ptype a
  | Type.String -> Format.fprintf f "string"
  | Type.Char -> Format.fprintf f "byte"
  | Type.Bool -> Format.fprintf f "bool"
  | Type.Void -> Format.fprintf f ""
  | Type.Named n ->
    begin match Typer.expand (super#getTyperEnv ()) t
        default_location |> Type.unfix with
        | Type.Struct _ -> Format.fprintf f "* %s" n
        | Type.Enum _ -> Format.fprintf f "%s" n
        | _ -> assert false
    end
  | _ -> super#ptype f t

  method ptypename f t = match Type.unfix t with
  | Type.Named n -> Format.fprintf f "%s" n
  | _ -> assert false

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<h>for@ %a@ :=@ %a@ ;@ %a@ <=@ %a;@ %a++@] {@\n  @[<v 2>%a@]@\n}"
      self#binding varname
      self#expr expr1
      self#binding varname
      self#expr expr2
      self#binding varname
      self#instructions li

  method bloc f li = Format.fprintf f "@[<v 2>{@\n%a@]@\n}" self#instructions li

  method allocarray f binding type_ len _ =
    Format.fprintf f "@[<h>var %a@ []%a@ = make([]%a, %a)@]"
      self#binding binding
      self#ptype type_
      self#ptype type_
      self#expr len

  method stdin_sep f = Format.fprintf f "@[skip()@]"

  method multi_read f li = self#base_multi_read f li

  method read_decl f t v =
    Format.fprintf f "@[var %a %a@\nfmt.Fscanf(reader, \"%a\", &%a)@]"
      self#binding v
      self#ptype t
      self#format_type t
      self#binding v

  method read f t m =
    Format.fprintf f "@[fmt.Fscanf(reader, \"%a\", &%a)@]" self#format_type t self#mutable_get m

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<h>if@ %a@ @]{@\n  @[<v 2>%a@]@\n}"
        self#expr e
        self#instructions ifcase
    | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<h>if@ %a@ @]{@\n  @[<v 2>%a@]@\n} else %a "
        self#expr e
        self#instructions ifcase
        self#instr instr
    | _ ->
      Format.fprintf f "@[<h>if@ %a@ @]{@\n  @[<v 2>%a@]@\n} else {@\n@[<v 2>  %a@]@\n}"
        self#expr e
        self#instructions ifcase
        self#instructions elsecase

  method whileloop f expr li =
    Format.fprintf f "@[<h>for %a@]{@\n  @[<v>%a@]@\n}" self#expr expr self#instructions li

  method decl_type f name t =
    match (Type.unfix t) with
    | Type.Struct li ->
      Format.fprintf f "@\ntype %a struct {@\n@[<v 2>  %a@]@\n}@\n"
        self#typename name
        (print_list
           (fun t (name, type_) ->
             Format.fprintf t "%a %a;" self#field name self#ptype type_
           ) sep_nl
        ) li
    | Type.Enum li ->
      Format.fprintf f "type %a int@\nconst (@\n@[<v2>  %a@]@\n);"
        self#typename name
        (print_list
           (fun t fname ->
             Format.fprintf t "%s %s = iota" fname name
           ) sep_nl
        ) li
    | _ -> Format.fprintf f "type %a %a;" self#typename name self#ptype t

end

