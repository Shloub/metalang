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
open PassesUtils

let mapt (_, acc) t = Option.default t (TypeMap.find_opt t acc)

let mapt t p = Type.Fixed.Deep.map (mapt p) t

let maptli li acc = List.map (fun (x, t) -> x, mapt t acc ) li

let name_of_field (i: int) (t : Type.t) (acc, _) =
  try
    List.nth (TypeMap.find t acc) i
  with Not_found ->
    (raise (Error (fun f -> Format.fprintf f "cannot find field %i in type %s@\n" i
      (Type.type_t_to_string t))))

let locate loc instr =
  PosMap.add (Instr.Fixed.annot instr) loc; instr

(* TODO positions *)
let rewrite acc (i : Utils.instr) : Utils.instr list = match Instr.unfix i with
  | Instr.Untuple (li, e, opt) ->
    let loc = PosMap.get (Instr.Fixed.annot i) in
    let t = Type.auto () in
    let b = fresh_internal () in
    let vb = Mutable.var b in
    let t_tuple = Type.tuple (List.map fst li) in
    let access = List.mapi (fun i (t, name) ->
      let fieldname = name_of_field i t_tuple acc in
      Instr.Declare (name, t, Expr.access (Mutable.dot vb fieldname), opt) |> Instr.fix |> locate loc
    ) li in
    (Instr.Declare (b, t, e, opt) |> Instr.fix |> locate loc)::access
  | j -> [i]

let rewrite acc i =
  let annot = Instr.Fixed.annot i in
  let i = Instr.deep_map_bloc (List.collect (rewrite acc)) (Instr.unfix i)
  in rewrite acc (Instr.fixa annot i)

type acc0 = Typer.env * DeclareTuples.acc
type 'lex acc = Typer.env * DeclareTuples.acc
let init_acc env = env

let mape tyenv (mapfields, _) e =
  match Expr.unfix e with
  | Expr.Tuple li ->
    let t = Typer.get_type tyenv e in
    let fieldsnames = TypeMap.find t mapfields in
    Expr.record (List.combine fieldsnames li)
  | _ -> e

let mapde tyenv acc e = Expr.Fixed.Deep.map (mape tyenv acc) e

let mapi acc = function
  | Instr.Declare (v, t, e, option) -> Instr.Declare (v, mapt t acc, e, option)
  | Instr.AllocArray (v, t, e, opt, optd) -> Instr.AllocArray (v, mapt t acc, e, opt, optd)
  | Instr.AllocRecord (v, t, li, opt) -> Instr.AllocRecord (v, mapt t acc, li, opt)
  | x -> x

let mapti i tyenv acc = Instr.Fixed.Deep.map2 (mapi acc) (mapde tyenv acc) i

let process (tyenv, acc) p =
  match p with
  | Prog.DeclarFun (x, y, z, instrs, opt)->
    let instrs = List.map (fun i -> mapti i tyenv acc) instrs in
    (tyenv, acc), Prog.DeclarFun (x, mapt y acc, maptli z acc, List.collect (rewrite acc) instrs, opt)
  | Prog.DeclareType (name, ty) -> 
    (tyenv, acc), Prog.DeclareType (name, mapt ty acc)
  | _ -> (tyenv, acc), p

let process_main (tyenv, acc) instrs =
  let instrs = List.map (fun i -> mapti i tyenv acc) instrs in
  (tyenv, acc), List.collect (rewrite acc) instrs

