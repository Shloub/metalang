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

(** LUA Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Helper
open Ast
open Printer

let print_expr macros e f p =
  let open Format in
  let open Ast.Expr in
  let print_lief prio f = function
    | Char c -> fprintf f "%d" (int_of_char c)
    | x -> print_lief prio f x in
  let print_expr0 config e f prio_parent = match e with
  | BinOp (a, (Div as op), b) ->
      let _, priol, prior = prio_binop op in
      fprintf f "trunc(%a %a %a)" a priol print_op op b prior
  | BinOp (a, Mod, b) -> fprintf f "math.mod(%a, %a)" a nop b nop
  | UnOp (a, Not) -> fprintf f "not(%a)" a nop
  | Tuple li -> fprintf f "{%a}" (print_list (fun f x -> x f nop) sep_c) li
  | Record li -> fprintf f "{%a}" (print_list (fun f (name, x) ->
      fprintf f "%s=%a" name x nop) sep_c) li
  | _ -> print_expr0 config e f prio_parent
  in
  let print_op f op = fprintf f (match op with
  | Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"
  | Mod -> "%%"
  | Or -> "or"
  | And -> "and"
  | Lower -> "<"
  | LowerEq -> "<="
  | Higher -> ">"
  | HigherEq -> ">="
  | Eq -> "=="
  | Diff -> "~=") in
  let print_mut conf prio f m = Ast.Mutable.Fixed.Deep.fold
      (print_mut0 "%a%a" "[%a]" "%a.%s" conf) m f prio in
  let config = {
    prio_binop;
    prio_unop;
    print_varname;
    print_lief;
    print_op;
    print_unop;
    print_mut;
    macros
  } in Ast.Expr.Fixed.Deep.fold (print_expr0 config) e f p

class luaPrinter = object(self)
  inherit printer as super

  method combine_formats () = true
  method limit_nprint () = 255

  method expr f e = print_expr
      (StringMap.map (fun (ty, params, li) ->
        ty, params,
        try List.assoc (self#lang ()) li
        with Not_found -> List.assoc "" li) macros) e f nop

  method lang () = "lua"
  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "%a%a%a%a%a%a%a%a@\n%a"
  (fun f () -> if Tags.is_taged "use_readintline" then
Format.fprintf f "
function readintline()
  local tab = {}
  for a in string.gmatch(io.read(\"*l\"), \"-?%%d+\") do
    table.insert(tab, tonumber(a))
  end
  return tab
end@\n") ()
  (fun f () -> if Tags.is_taged "use_readcharline" then
Format.fprintf f "
function readcharline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read(\"*l\"), \".\") do
    table.insert(tab, string.byte(a))
  end
  return tab
end@\n") ()
  (fun f () -> if Tags.is_taged "__internal__div" then Format.fprintf f "
function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end@\n") ()
(fun f () -> if need then Format.fprintf f "buffer =  \"\"@\n") ()
(fun f () -> if need_readint then Format.fprintf f "function readint()
    if buffer == \"\" then buffer = io.read(\"*line\") end
    local num, buffer0 = string.match(buffer, '^([\\-0-9]*)(.*)')
    buffer = buffer0
    return tonumber(num)
end@\n") ()
(fun f () -> if need_readchar then Format.fprintf f "function readchar()
    if buffer == \"\" then buffer = io.read(\"*line\") end
    local c = string.byte(buffer)
    buffer = string.sub(buffer, 2, -1)
    return c
end@\n") ()
(fun f () -> if need_stdinsep then Format.fprintf f "
function stdinsep()
    if buffer == \"\" then buffer = io.read(\"*line\") end
    if buffer ~= nil then buffer = string.gsub(buffer, '^%%s*', \"\") end
end@\n") ()

      self#proglist prog.Prog.funs
      (print_option self#main) prog.Prog.main

  method hasSelfAffect _ = false

  method char f c = Format.fprintf f "%d" (int_of_char c)

  method comment f str = Format.fprintf f "--[[%s--]]" str

  method stdin_sep f =
    Format.fprintf f "@[stdinsep()@]"

  method read f t mutable_ =
    Format.fprintf f "@[%a = read%a()@]" self#mutable_set mutable_
      self#ptype t

  method read_decl f t v =
    Format.fprintf f "@[local %a = read%a()@]"
      self#binding v
      self#ptype t

  method decl_type f name t = ()

  method record f li =
    Format.fprintf f "@[<h>{%a}@]"
      (self#def_fields (InternalName 0)) li

  method tuple f li =
    Format.fprintf f "@[<h>{%a}@]"
      (print_list self#expr sep_c) li

  method untuple f li e =
    Format.fprintf f "@[<h>%a = unpack(%a)@]"
      (print_list self#binding sep_c) (List.map snd li)
      self#expr e

  method if_ f e ifcase elsecase =
    match elsecase with
    | [] ->
      Format.fprintf f "@[<hov>if@ %a@]@\nthen@\n@[<v2>  %a@]@\nend"
        self#expr e
        self#instructions ifcase
    | [Instr.Fixed.F (_, Instr.If (condition, instrs1, instrs2) ) as instr] ->
      Format.fprintf f "@[<hov>if@ %a@] then@\n@[<v 2>  %a@]@\nelse%a"
        self#expr e
        self#instructions ifcase
        self#instr instr
    | _ ->
      Format.fprintf f "@[<hov>if@ %a@]@\nthen@\n@[<v 2>  %a@]@\nelse@\n@[<v 2>  %a@]@\nend"
        self#expr e
        self#instructions ifcase
        self#instructions elsecase

  method multi_print f format exprs =
    match exprs with
    | [] -> Format.fprintf f "@[<h>io.write(\"%s\")@]" format
    | _ ->
        Format.fprintf f "@[<h>io.write(string.format(\"%s\", %a))@]" format
          (print_list
             (fun f (t, e) -> self#expr f e) sep_c) exprs

  method print f t expr =
    match Type.unfix t with
    | Type.Char ->Format.fprintf f "@[<h>io.write(string.format(\"%%c\", %a))@]" self#expr expr
    | _ -> Format.fprintf f "@[<h>io.write(%a)@]" self#expr expr

  method allocrecord f name t el =
    Format.fprintf f "@[<h>@[<v2>local %a = {@\n%a@]@\n}@]"
      self#binding name
      (self#def_fields name) el

  method def_fields name f li =
    Format.fprintf f "@[<hov>%a@]"
      (print_list
         (fun f (fieldname, expr) ->
           Format.fprintf f "%a=%a"
             self#field fieldname
             self#expr expr
         )
         (sep "%a,@\n%a"))
      li

  method allocarray f binding type_ len _ =
    Format.fprintf f "@[<h>local %a@ =@ {}@]"
      self#binding binding

  method declaration f var t e =
    Format.fprintf f "@[<h>local %a@ =@ %a@]"
      self#binding var
      self#expr e

  method forloop f varname expr1 expr2 li =
    Format.fprintf f "@[<v2>@[<h>for@ %a@ =@ %a,%a do@]@\n%a@]@\nend"
      self#binding varname
      self#expr expr1
      self#expr expr2
      self#instructions li

  method main f main = self#instructions f main

  method print_proto f (funname, t, li) =
    Format.fprintf f "function %a( %a )"
      self#funname funname
      (print_list (fun t (a, type_) -> self#binding t a) sep_c) li

end

