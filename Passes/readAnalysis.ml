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

(** Cette passe collecte la liste des types qui sont utilisés dans les constructions def read type variable et read mutable.
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

let hasSkip li =
  let f acc i =
    match Instr.unfix i with
    | Instr.StdinSep -> true
    | _ -> acc
  in
  List.fold_left
    (fun acc i ->
      Instr.Writer.Deep.fold
        f
        (f acc i) i)
    false li

let hasSkip_progitem li =
  List.fold_right
    (fun f b -> match f with
    | Prog.DeclarFun (_, _, _, li, _) ->
      b || (hasSkip li)
    | _ -> b
    ) li false

let collectReads acc li =
  let f acc i =
    match Instr.unfix i with
    | Instr.DeclRead (ty, _, _)
    | Instr.Read(ty, _) ->
      TypeMap.add ty
        (Ast.PosMap.get (Instr.Fixed.annot i))
        acc
    | _ -> acc in
  List.fold_left
    (fun acc i ->
      Instr.Writer.Deep.fold f
        (f acc i) i)
    acc li

let collectReads_progitem li =
  List.fold_right
    (fun f acc -> match f with
    | Prog.DeclarFun (_, _, _, li, _) -> collectReads acc li
    | _ -> acc
    ) li TypeMap.empty

let apply prog =
  let reads_types_map =
    let acc = collectReads_progitem prog.Prog.funs
    in Option.map_default acc (collectReads acc) prog.Prog.main
  in
  let () = TypeMap.iter
    (fun ty loc ->
      match Type.unfix ty with
      | Type.Char | Type.Integer -> ()
      | _ -> raise (Warner.Error (fun f ->
        Format.fprintf f "Cannot read %s %a@\n"
          (Type.type_t_to_string ty) Warner.ploc loc
      ))
    )
    reads_types_map in
  let reads_types = TypeMap.fold (fun a b c -> TypeSet.add a c)
    reads_types_map TypeSet.empty in
  { prog with
    Prog.hasSkip =
      begin
        let acc = hasSkip_progitem prog.Prog.funs
        in acc || (Option.map_default false hasSkip prog.Prog.main )
      end;
    Prog.reads = reads_types
  }
