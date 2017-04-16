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


(** java Printer
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Helper

let print_lief tyenv prio f = function
  | Expr.Char c -> unicode f c
  | Expr.Enum e ->
    let t = Typer.typename_for_enum e tyenv in
    Format.fprintf f "%s.%s" t e
  | x -> print_lief prio f x

let print_mut conf prio f m = Ast.Mutable.Fixed.Deep.fold (print_mut0 "%a%a" "[%a]" "%a.%s" conf) m f prio

let config tyenv macros = {
  prio_binop;
  prio_unop;
  print_varname;
  print_lief = print_lief tyenv;
  print_op;
  print_unop;
  print_mut;
  macros
}

let print_expr config e f p = Expr.Fixed.Deep.fold (print_expr0 config) e f p

let ptype f t =
  let open Type in
  let open Format in
  let ptype ty f option = match ty with
    | Integer -> fprintf f (if option then "Integer" else "int")
    | String -> fprintf f "String"
    | Array a -> fprintf f "%a[]" a false
    | Option a -> a f true
    | Void ->  fprintf f "void"
    | Bool -> fprintf f (if option then "Boolean" else "boolean")
    | Char -> fprintf f (if option then "Char" else "char")
    | Named n -> fprintf f "%s" n
    | Enum _ -> fprintf f "an enum"
    | Struct li -> fprintf f "a struct"
    | Auto | Tuple _ | Lexems -> assert false
  in Fixed.Deep.fold ptype t f false

let print_instr c i =
  let open Ast.Instr in
  let open Format in
  let p f pend = match i with
    | Declare (var, ty, e, _) -> fprintf f "%a %a = %a%a" ptype ty c.print_varname var e nop pend ()
    | AllocArrayConst (name, ty, len, lief, opt) -> assert false
    | AllocArray (name, t, e, Some (var, lambda), opt) -> assert false
    | AllocArray (name, t, e, None, opt) ->    
      begin match Type.unfix t with
        | Type.Array t2 ->
          fprintf f "@[<h>%a[] %a = new %a[%a]%a%a@]"
            ptype t
            c.print_varname name
            (jlike_prefix_type ptype) t2
            e nop
            jlike_suffix_type t pend ()
        | _ ->
          fprintf f "@[<h>%a[] %a = new %a[%a]%a@]"
            ptype t
            c.print_varname name
            ptype t
            e nop pend ()
      end
    | AllocRecord (name, ty, list, opt) ->
      fprintf f "%a %a = new %a()%a@\n%a"
        ptype ty c.print_varname name ptype ty pend ()
        (print_list (fun f (field, x) -> fprintf f "%a.%s = %a%a" 
                        c.print_varname name field x nop pend ()) sep_nl) list
    | Print [StringConst s] -> fprintf f "System.out.print(%a);" (c.print_lief jlike_prio_operator) (Expr.String s)
    | Print [PrintExpr (_, e)] -> fprintf f "System.out.print(%a);" e nop
    | Print li-> 
      let format, exprs = extract_multi_print clike_noformat format_type li in
      fprintf f "System.out.printf(\"%s\", %a);"
        format (print_list (fun f (_, e) -> e f nop) sep_c) exprs
    | Read li ->
      print_list
        (fun f -> function
           | Separation -> Format.fprintf f "@[<v>scanner.findWithinHorizon(\"[\\n\\r ]*\", 1)%a@]" pend ()
           | DeclRead (ty, v, opt) ->
             begin match Ast.Type.unfix ty with
               | Ast.Type.Char ->  fprintf f "@[<h>char %a = scanner.findWithinHorizon(\".\", 1).charAt(0);@]" c.print_varname v
               | Ast.Type.Integer -> fprintf f "@[<h>%a %a;@\nif (scanner.hasNext(\"^-\")) {@\n  scanner.next(\"^-\");@\n  %a = scanner.nextInt();@\n} else {@\n  %a = scanner.nextInt();@\n}@]"
                                       ptype ty c.print_varname v c.print_varname v c.print_varname v
               | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot read type %s"
                                              (Type.type_t_to_string ty)))
             end
           | ReadExpr (ty, mut) ->
             begin match Ast.Type.unfix ty with
               | Ast.Type.Char ->fprintf f "@[<h>%a = scanner.findWithinHorizon(\".\", 1).charAt(0);@]" (c.print_mut c nop) mut
               | Ast.Type.Integer -> fprintf f "@[<h>if (scanner.hasNext(\"^-\")) {@\n  scanner.next(\"^-\");@\n  %a = -scanner.nextInt();@\n}else{@\n  %a = scanner.nextInt();@\n}@]"
                                       (c.print_mut c nop) mut (c.print_mut c nop) mut
               | _ -> raise (Warner.Error (fun f -> Format.fprintf f "Error : cannot read type %s"
                                              (Type.type_t_to_string ty)))
             end
        ) sep_nl f li
    | Untuple (li, expr, opt) -> assert false
    | Unquote e -> assert false
    | _ -> clike_print_instr c i f pend
  in
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
  let c = config tyenv macros in
  let i = (fold (print_instr c) (mapg (print_expr c) i))
  in fun f -> i.p f i.default


let instructions typerEnv macros f li =
  let macros = StringMap.map (fun (ty, params, li) ->
      ty, params,
      try List.assoc "java" li
      with Not_found -> List.assoc "" li) macros
  in print_list (fun f t -> print_instr typerEnv macros t f) sep_nl f li

let main typerEnv macros f main =
  Format.fprintf f "public static void main(String args[])@\n@[<v 2>{@\n%a@]@\n}@\n"
    (instructions typerEnv macros) main

let print_scanner f () = Format.fprintf f "@[<h>static Scanner scanner = new Scanner(System.in);@]"

let print_datareader f () =
    Format.fprintf f "@[<h>
  static int[] read_int_line()
  {
    String[] s = scanner.nextLine().split(\" \");
    int[] out = new int[s.length];
    for (int i = 0; i < s.length; i++)
      out[i] = Integer.parseInt(s[i]);
    return out;
  }
@]"

let prog typerEnv f prog =
    let macros, items = List.fold_left
        (fun (macros, li) item -> match item with
           | Prog.Macro (name, t, params, code) ->
             StringMap.add name (t, params, code) macros, li
           | Prog.Comment str -> macros, (fun f -> clike_comment f str) :: li
           | Prog.DeclarFun (funname, t, vars, liinstrs, _opt) ->
             macros, (fun f -> Format.fprintf f "@[<h>static %a %s(%a)@]@\n@[<v 2>{@\n%a@]@\n}"
                         ptype t funname
                         (print_list
                            (fun t (binding, type_) -> Format.fprintf t "%a@ %a" ptype type_ print_varname binding) sep_c
                         ) vars
                         (instructions typerEnv macros) liinstrs) :: li
           | Prog.DeclareType (name, t) ->
             macros, (fun f -> match (Type.unfix t) with
                 Type.Struct li ->
                 Format.fprintf f "@[<v 2>static class %s {@\n%a@]@\n}" name
                   (print_list (fun f (name, type_) -> Format.fprintf f "public %a %s;" ptype type_ name) sep_nl) li
               | Type.Enum li ->
                 Format.fprintf f "enum %s { @\n@[<v2>  %a@]}@\n" name
                   (print_list (fun f e -> Format.fprintf f "%s" e) (sep "%a,@\n %a")) li
               | _ -> assert false
             ) :: li
           | _ -> macros, li
        ) (StringMap.empty, []) prog.Prog.funs in
    let reader = Tags.is_taged "use_readmacros" || prog.Prog.hasSkip || TypeSet.cardinal prog.Prog.reads <> 0 in
    let datareader = Tags.is_taged "use_java_readline" in
    Format.fprintf f
      "import java.util.*;@\n@\npublic class %s@\n@[<v 2>{@\n%a%a@\n%a@\n%a@]@\n}@\n"
      prog.Prog.progname
      (if reader || datareader then print_scanner else fun f () -> ()) ()
      (if datareader then print_datareader else fun f () -> ()) ()
      (print_list (fun f g -> g f) sep_nl) (List.rev items)
      (print_option (main typerEnv macros)) prog.Prog.main
