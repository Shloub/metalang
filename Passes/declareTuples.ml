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


(** Passe de suppression des tuples
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib
open Ast
open Warner
open Fresh

type acc = string list TypeMap.t * Type.t TypeMap.t
let acc0 = TypeMap.empty, TypeMap.empty

let freshname = function
  | Type.Integer -> "int"
  | Type.String -> "string"
  | Type.Char -> "char"
  | Type.Array x -> "array_"^x^"_"
  | Type.Void -> "void"
  | Type.Bool -> "bool"
  | Type.Lexems -> "lexems"
  | Type.Struct li ->
    List.fold_left
      (fun acc (name, t) ->
        acc ^ "_"^name^"_"^t
      ) "struct" li
  | Type.Enum li ->
    List.fold_left
      (fun acc name ->
        acc ^ "_"^name
      ) "enum" li
  | Type.Named tyname -> tyname
  | Type.Tuple li ->
    List.fold_left
      (fun acc name ->
        acc ^ "_"^name
      ) "tuple" li
  | Type.Auto -> "auto"

let freshname t = Type.Fixed.Deep.fold freshname t

let fold_ty tyenv torig t ((_, acc_names, _) as acc) =
  let default acc t = Type.Fixed.Surface.fold (fun acc f -> f acc) acc t in
  if TypeMap.mem torig acc_names then acc
  else match t with
  | Type.Tuple l ->
      let (acc_fields, acc_names, li) = default acc t in
    let prefix =  freshname torig in
    let lnames = List.mapi (fun i _ -> prefix^"_field_" ^ (string_of_int i) ) l in
    let acc_fields = TypeMap.add torig lnames acc_fields in
    let lorig = match Type.unfix torig with
    | Type.Tuple l -> l
    | _ -> assert false
    in
    let ty = Type.struct_ (List.combine lnames lorig) in
    let tynamed = Type.named prefix in
    let acc_names = TypeMap.add torig tynamed acc_names in
    let declaration = Prog.DeclareType ( prefix, ty ) in
    acc_fields, acc_names, declaration :: li
  | _ ->
      let (acc_fields, acc_names, li) = default acc t in
      acc_fields, (TypeMap.add torig torig acc_names), li

let process_t tyenv acc t =
  Type.Fixed.Deep.foldorig (fold_ty tyenv) t acc

let folde tyenv acc e = process_t tyenv acc (Typer.get_type tyenv e)

let process_e tyenv e acc = Expr.Writer.Deep.fold (folde tyenv) acc e

let process_i tyenv acc i = Instr.Fixed.Deep.foldg (process_e tyenv) i acc

let process_li tyenv acc li=
  List.fold_left (process_i tyenv) acc li

let process_top tyenv (acc1, acc2, li0) t = match t with
  | Prog.DeclarFun (_, _, _, li, _) ->
    let acc1, acc2, li0 = process_li tyenv (acc1, acc2, li0) li
    in acc1, acc2, t::li0
  | Prog.DeclareType (name, ty) ->
    let acc1, acc2, li0 = process_t tyenv (acc1, acc2, li0) ty in
    acc1, acc2, t::li0
  | _ -> acc1, acc2, t::li0

let apply tyenv prog =
  let acc1, acc2 = acc0 in
  let acc1, acc2, funs = List.fold_left (process_top tyenv) (acc1, acc2, []) prog.Prog.funs in
  let acc1, acc2, funs = match prog.Prog.main with
    | Some main -> process_li tyenv (acc1, acc2, funs) main
    | None -> acc1, acc2, funs
  in
  let prog =
    { prog with
      Prog.funs = List.rev funs;
    }
  in (acc1, acc2), prog

