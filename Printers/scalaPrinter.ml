(*
 * Copyright (c) 2012 - 2016, Prologin
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


let print_mut conf prio f m = Mutable.Fixed.Deep.fold
    (print_mut0 "%a%a" "(%a)" "%a.%s" conf) m f prio

let print_lief prio f l = 
  let open Format in
  let open Expr in match l with
  | Char c -> unicode f c
  | String s -> fprintf f "%S" s
  | Integer i ->
    if i < 0 then parens prio (-1) f "%i" i
    else Format.fprintf f "%i" i
  | Bool true -> fprintf f "true"
  | Bool false -> fprintf f "false"
  | Enum s -> fprintf f "%s" s

let config macros = {
  prio_binop;
  prio_unop;
  print_varname;
  print_lief;
  print_op;
  print_unop;
  print_mut;
  macros
} 

let print_expr tyenv config e f p =
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
  Fixed.Deep.fold (print_expr0 config) e f p

let ptype f ty =
  let open Type in
  let open Format in
  let ptype ty f () = match ty with
    | Integer -> fprintf f "Int"
    | String -> fprintf f "String"
    | Array a -> fprintf f "Array[%a]" a ()
    | Void ->  fprintf f "Unit"
    | Bool -> fprintf f "Boolean"
    | Char -> fprintf f "Char"
    | Named n -> fprintf f "%s" (String.capitalize n)
    | Enum _ -> fprintf f "an enum"
    | Struct _ -> fprintf f "a struct"
    | Tuple li -> fprintf f "(%a)" (print_list (fun f x -> x f ()) sep_c) li
    | Auto | Lexems -> assert false
  in Fixed.Deep.fold ptype ty f ()

let print_instr c i =
  let open Ast.Instr in
  let open Format in
  let p f pend = match i with
    | Declare (var, ty, e, _) -> fprintf f "var %a: %a = %a%a" c.print_varname var
                                   ptype ty e nop pend ()
    | SelfAffect (mut, op, e) -> fprintf f "%a %a= %a%a" (c.print_mut c nop) mut c.print_op op e nop pend ()
    | Affect (mut, e) -> fprintf f "%a = %a%a" (c.print_mut c nop) mut e nop pend ()
    | Loop (var, e1, e2, li) -> fprintf f "for (%a <- %a to %a)%a"
                                  c.print_varname var e1 nop e2 nop
                                  block li
    | ClikeLoop (init, cond, incr, li) -> assert false
    | While (e, li) -> fprintf f "while (@[<h>%a@])%a" e nop block li
    | Comment s -> fprintf f "/*%s*/" s
    | Tag s -> fprintf f "/*%S*/" s
    | Return e -> fprintf f "return %a%a" e nop pend ()
    | AllocArray (name, t, e, None, opt) -> fprintf f "@[<h>var %a@ :Array[%a]@ =@ new Array[%a](%a)%a@]"
                                              c.print_varname name
                                              ptype t ptype t
                                              e nop
                                              pend ()
    | AllocArray (name, t, e, Some (var, lambda), opt) -> assert false
    | AllocArrayConst (name, ty, len, lief, opt) ->
      fprintf f "@[<h>%a = array_fill(0, %a, %a)%a@]" c.print_varname name
        len nop (c.print_lief nop) lief pend ()
    | AllocRecord (name, ty, list, opt) ->
      fprintf f "@[<v 4>var %a = {@\n%a}%a@]" c.print_varname name
        (print_list (fun f (field, x) -> fprintf f "%S:%a" field x nop) (sep "%a,@\n%a")) list
        pend ()
    | If (e, listif, []) ->
      fprintf f "if (%a)%a" e nop block listif
    | If (e, listif, [elsecase]) when elsecase.is_if ->
      fprintf f "if (%a)%a@\n@[<v 4>else@\n%a@]" e nop block_ifcase listif elsecase.p seppt
    | If (e, listif, listelse) ->
      fprintf f "if (%a)%a@\nelse%a" e nop block_ifcase listif block listelse
    | Call (func, li) ->  begin match StringMap.find_opt func c.macros with
        | Some ( (t, params, code) ) -> pmacros f "%s;" t params code li nop
        | None -> fprintf f "%s(%a)%a" func (print_list (fun f x -> x f nop) sep_c) li pend ()
      end
    | Print li->
      let format, exprs = extract_multi_print clike_noformat format_type li in
      begin match exprs with
        | [] -> fprintf f "printf(\"%s\")%a" format pend ()
        | _ -> fprintf f "printf(\"%s\", %a)%a" format
                 (print_list (fun f (t, e) -> e f nop) sep_c) exprs pend ()
      end
    | Read li ->
      print_list
        (fun f -> function
           | Separation -> Format.fprintf f "@[skip()%a@]" pend ()
           | DeclRead (ty, v, opt) ->
             begin match Ast.Type.unfix ty with
               | Ast.Type.Char -> fprintf f "@[var %a = read_char()%a@]" c.print_varname v pend ()
               | Ast.Type.Integer -> fprintf f "@[var %a = read_int()%a@]" c.print_varname v pend ()
               | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot read type %s"
                                              (Type.type_t_to_string ty)))
             end
           | ReadExpr (ty, mut) ->
             begin match Ast.Type.unfix ty with
               | Ast.Type.Char -> fprintf f "@[%a = read_char()%a@]" (c.print_mut c nop) mut pend ()
               | Ast.Type.Integer -> fprintf f "@[%a = read_int()%a@]" (c.print_mut c nop) mut pend ()
               | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot read type %s"
                                              (Type.type_t_to_string ty)))
             end
        ) sep_nl f li
    | Untuple (li, expr, opt) -> fprintf f "var (%a) = %a%a" (print_list c.print_varname sep_c) (List.map snd li) expr nop pend ()
    | Incr _ | Decr _ | Unquote _ -> assert false in
  let is_multi_instr = match i with
    | Read (hd::tl) -> true
    | Declare _ -> true
    | _ -> false in
  {
    is_multi_instr = is_multi_instr;
    is_if=is_if i;
    is_if_noelse=is_if_noelse i;
    is_comment=is_comment i;
    p=p;
    default = seppt;
    print_lief = c.print_lief;
  }

let print_instr tyenv macros i =
  let open Ast.Instr.Fixed.Deep in
  let c = config macros in
  let i = (fold (print_instr c) (mapg (print_expr tyenv c) i))
  in fun f -> i.p f i.default

let header f prog =
    let need_stdinsep = prog.Prog.hasSkip in
    let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
    let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
    let need = need_stdinsep || need_readint || need_readchar in
    Format.fprintf f "%s%s%s%s@\n"
      (if need then buffer else "")
      (if need_readint then readint else "")
      (if need_readchar then readchar else "")
      (if need_stdinsep then skip else "")

  let decl_type f name t =
    let nameC = String.capitalize name in
    match (Type.unfix t) with
      Type.Struct li ->
      Format.fprintf f "class %s(%a){@\n@[<v 2>  %a@]@\n}@\n" nameC
        (print_list
           (fun t (name, type_) ->
              Format.fprintf t "_%s: %a" name ptype type_
           ) sep_c
        ) li
        (print_list
           (fun t (name, type_) ->
              Format.fprintf t "var %s: %a=_%s;" name ptype type_ name
           ) sep_nl
        ) li
    | Type.Enum li ->
      Format.fprintf f "object %s extends Enumeration {@\n  type %s = Value;@\n  val %a = Value@\n}@\nimport %s._" nameC nameC (print_list (fun f s -> Format.fprintf f "%s" s) sep_c) li nameC
    | _ -> assert false

let prog typerEnv f (prog: Utils.prog) =
    let instrs macros f t =
      let macros = StringMap.map (fun (ty, params, li) ->
          ty, params,
          try List.assoc "scala" li
        with Not_found -> List.assoc "" li) macros
      in print_list (fun f t -> (print_instr typerEnv macros t) f) sep_nl f t in
    let macros, items = List.fold_left
        (fun (macros, li) item -> match item with
        | Prog.Macro (name, t, params, code) ->
          StringMap.add name (t, params, code) macros, li
        | Prog.DeclareType (name, t) ->
          macros, (fun f -> decl_type f name t )::li
        | Prog.Comment s -> macros, (fun f -> Format.fprintf f "%a@\n" clike_comment s )::li
        | Prog.DeclarFun (funname, t, vars, liinstrs, _opt) ->
          macros, (fun f ->
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
              in let refbindings = List.fold_left g BindingSet.empty liinstrs in
              let linames = List.map fst vars in
              let linames = List.filter (fun name -> BindingSet.mem name refbindings ) linames in
              Format.fprintf f "@[<h>def %s(%a)%a@]{@\n@[<v 2>  %a%a@]@\n}@\n"
                funname
                (print_list
                   (fun t (binding, type_) ->
            if BindingSet.mem binding refbindings then
              Format.fprintf t "_%a :@ %a" print_varname binding ptype type_
            else
              Format.fprintf t "%a :@ %a" print_varname binding ptype type_
                   ) sep_c
                ) vars
                (fun f t ->
                   match Type.unfix t with
                   | Type.Void -> ()
                   | _ -> Format.fprintf f ": %a = " ptype t
                ) t
                
                (print_list (fun f name -> 
                     Format.fprintf f "var %a = _%a;"
                       print_varname name
                       print_varname name) sep_nl) linames
                (instrs macros) liinstrs)::li
        | _ -> macros, li
        ) (StringMap.empty, []) prog.Prog.funs in
    Format.fprintf f
      "object %s@\n@[<v 2>{@\n%a%a@\n%a@]@\n}@\n"
      prog.Prog.progname
      header prog
      (print_list (fun f g -> g f) sep_nl) (List.rev items)
      (print_option (fun f liinstrs ->
           Format.fprintf f "def main(args : Array[String])@\n@[<v 2>{@\n%a@]@\n}@\n"
             (instrs macros) liinstrs
         )) prog.Prog.main
