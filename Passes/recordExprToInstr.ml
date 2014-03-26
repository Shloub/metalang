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


(**
@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

type acc0 = Typer.env
type 'lex acc = Typer.env;;
let init_acc env = env;;

let foldmapexpr tyenv acc e = match Expr.unfix e with
(*  | Expr.Tuple li ->
    let varnmae = Fresh.fresh () in
    let ni = Instr.AllocRecord (varname, t, li) in
    let ne = Expr.access (Mutable.var varname) in
in ni::acc, ne *)
  | Expr.Record li ->
    let t = Typer.get_type tyenv e in
    let varname = Fresh.fresh () in
    let ni = Instr.alloc_record varname t li in
    let ne = Expr.access (Mutable.var varname) in
    ni::acc, ne
  | _ -> acc, e

let process tyenv acc e = 
  let acc, e = foldmapexpr tyenv acc e in
  Expr.Writer.Deep.foldmap (foldmapexpr tyenv) acc e

let process_mut tyenv acc m = Mutable.foldmap_expr (process tyenv) acc m

let expand tyenv i = match Instr.unfix i with
  | Instr.Declare (n, t, e) ->
    let instrs, e = process tyenv [] e in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.Declare (n, t, e))  ) :: instrs)
  | Instr.Affect (mut, e) ->
    let instrs, e = process tyenv [] e in
    let instrs, mut = process_mut tyenv instrs mut in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.Affect (mut, e))  ) :: instrs)
  | Instr.Loop (v, e1, e2, li) ->
    let instrs, e1 = process tyenv [] e1 in
    let instrs, e2 = process tyenv instrs e2 in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.Loop (v, e1, e2, li))  ) :: instrs)
  | Instr.While (e, li) ->
    let instrs, e = process tyenv [] e in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.While (e, li))  ) :: instrs)
  | Instr.Return e ->
    let instrs, e = process tyenv [] e in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.Return e)  ) :: instrs)
  | Instr.AllocArray (n, t, e, opt) ->
    let instrs, e = process tyenv [] e in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.AllocArray (n, t, e, opt))  ) :: instrs)
  | Instr.AllocRecord (n, t, lie) ->
    let instrs, lie = List.fold_left_map (fun acc (f, e) ->
      let acc, e = process tyenv acc e
      in acc, (f, e)) [] lie in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.AllocRecord (n, t, lie))  ) :: instrs)
  | Instr.If (e, l1, l2) ->
    let instrs, e = process tyenv [] e in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.If (e, l1, l2))  ) :: instrs)
  | Instr.Call (funname, lie) ->
    let instrs, lie = List.fold_left_map (process tyenv) [] lie in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.Call (funname, lie))  ) :: instrs)
  | Instr.Print (t, e) ->
    let instrs, e = process tyenv [] e in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.Print (t, e))  ) :: instrs)
  | Instr.Read (t, mut) ->
    let instrs, mut = process_mut tyenv [] mut in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.Read (t, mut))  ) :: instrs)
  | Instr.Untuple(li, e) ->
    let instrs, e = process tyenv [] e in
    List.rev ((Instr.fixa (Instr.Fixed.annot i) (Instr.Untuple (li, e))  ) :: instrs)
  | _ -> [i]
      
let mapi tyenv i =
  Instr.deep_map_bloc
    (List.flatten @* (List.map (expand tyenv)) )
    (Instr.unfix i) |> Instr.fixa (Instr.Fixed.annot i)

let process tyenv is = tyenv, List.map (mapi tyenv) (List.flatten (List.map (expand tyenv) is))
