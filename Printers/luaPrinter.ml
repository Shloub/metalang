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

class luaPrinter = object(self)
  inherit printer as super

  method combine_formats () = true

  method lang () = "lua"
  method prog f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "%a%a%a%a%a%a%a%a@\n%a"
  (fun f () -> if Tags.is_taged "use_readintline" then
if Tags.is_taged "use_readtuple" then
Format.fprintf f "
function readintline()
  local tab = {}
  for a in string.gmatch(io.read(\"*l\"), \"-?%%d+\") do
    table.insert(tab, tonumber(a))
  end
  return tab
end@\n"
else
Format.fprintf f "
function readintline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read(\"*l\"), \"-?%%d+\") do
    tab[i] = tonumber(a)
    i = i + 1
  end
  return tab
end@\n"
) ()
  (fun f () -> if Tags.is_taged "use_readcharline" then
if Tags.is_taged "use_readtuple" then
Format.fprintf f "
function readcharline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read(\"*l\"), \".\") do
    table.insert(tab, string.byte(a))
  end
  return tab
end@\n"
else
Format.fprintf f "function readcharline()
   local tab = {}
   local i = 0
   for a in string.gmatch(io.read(\"*l\"), \".\") do
    tab[i] = string.byte(a)
    i = i + 1
   end
   return tab
end@\n"
) ()
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
    Format.fprintf f "@[%a = read%a()@]" self#mutable_ mutable_
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

  method mutable_ f m0 =
    match Mutable.unfix m0 with
    | Mutable.Array (m, indexes) ->
        if Tags.is_taged "use_readtuple" then
          Format.fprintf f "%a[%a]"
            self#mutable_ m
            (print_list
               (fun f e -> Format.fprintf f "%a+1" self#expr e)
               (sep "%a][%a"))
            indexes
        else super#mutable_ f m0
    | _ -> super#mutable_ f m0

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
    | _ ->
        Format.fprintf f "@[<h>io.write(%a)@]" self#expr expr

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

  method print_op f op =
    Format.fprintf f
      "%s"
      (match op with
      | Expr.Add -> "+"
      | Expr.Sub -> "-"
      | Expr.Mul -> "*"
      | Expr.Div -> "/"
      | Expr.Mod -> "%"
      | Expr.Or -> "or"
      | Expr.And -> "and"
      | Expr.Lower -> "<"
      | Expr.LowerEq -> "<="
      | Expr.Higher -> ">"
      | Expr.HigherEq -> ">="
      | Expr.Eq -> "=="
      | Expr.Diff -> "~="
      )

  method unop f op a = match op with
  | Expr.Neg -> Format.fprintf f "-%a" (fun f a ->
      if self#nop (Expr.unfix a) then self#expr f a
      else Format.fprintf f "(%a)" self#expr a) a
  | Expr.Not -> Format.fprintf f "not(%a)" self#expr a

  method main f main = self#instructions f main

  method print_proto f (funname, t, li) =
    Format.fprintf f "function %a( %a )"
      self#funname funname
      (print_list (fun t (a, type_) -> self#binding t a) sep_c) li


  method binop f op a b =
    match op with
    | Expr.Div ->
      if Typer.is_int (super#getTyperEnv ()) a
      then Format.fprintf f "trunc(%a / %a)"
        (self#chf op Left) a
        (self#chf op Right) b
      else super#binop f op a b
    | Expr.Mod ->
      Format.fprintf f "math.mod(%a, %a)"
        self#expr a
        self#expr b
    | _ -> super#binop f op a b

end

