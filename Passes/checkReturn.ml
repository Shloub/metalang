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

(** Cette passe vérifie que l'on utilise pas de return dans une fonction void
    @see <http://prologin.org> Prologin
    @author Prologin (info\@prologin.org)
    @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

let find_return li =
  let f tra acc i = match Instr.unfix i with
    | Instr.Return _ ->
      let loc = Ast.PosMap.get (Instr.Fixed.annot i) in
      Some loc
    | Instr.AllocArray _ -> acc
    | _ -> tra acc i
  in
  let li = List.map
    (fun i ->
      f (Instr.Writer.Traverse.fold f) None i)
    li
  in try
       List.find (function | Some _ -> true | _ -> false) li
    with Not_found -> None

let check_noreturn li =
  match find_return li with
  | None -> ()
  | Some loc ->
    raise ( Warner.Error (fun f ->
      Format.fprintf f "return not expected %a" Warner.ploc loc
    ))

let rec check_must_return li =
  let last_instrs = List.rev @$ List.filter (fun i -> match Instr.unfix i with
    | Instr.Comment _ -> false
    | _ -> true) li in
  match last_instrs with
  | [] -> false
  | hd::tl -> match Instr.unfix hd with
    | Instr.Return _ -> true
    | Instr.If (_, li1, li2) -> 
      (check_must_return li1) && (check_must_return li2)
    | _ ->  false

let rec check_alloc_inside loc li =
  let last_instrs = List.rev @$ List.filter (fun i -> match Instr.unfix i with
    | Instr.Comment _ -> false
    | _ -> true) li in
  match last_instrs with
    | [] ->
      raise ( Warner.Error (fun f ->
        Format.fprintf f "return expected %a" Warner.ploc loc
      ))
    | hd::tl ->
      let loc = Ast.PosMap.get (Instr.Fixed.annot hd) in
      match Instr.unfix hd with
      | Instr.Return _ ->
        check_noreturn tl;
      | Instr.If (_, li1, li2) ->
        check_noreturn tl;
        check_alloc_inside loc li1;
        check_alloc_inside loc li2;
      | _ ->
        raise ( Warner.Error (fun f ->
          Format.fprintf f "return not expected %a" Warner.ploc loc
        ))

let check_alloc li =
  let f tra i = match Instr.unfix i with
    | Instr.AllocArray (_, _, _, Some(_, instrs)) ->
      let loc = Ast.PosMap.get (Instr.Fixed.annot i) in
      check_alloc_inside loc instrs
    | _ -> tra i
  in List.iter
    (fun i -> f (Instr.Writer.Traverse.iter f) i) li

let check_fun = function
  | Prog.DeclarFun (varname, ty, li, instrs) ->
    let loc = Ast.PosMap.get (Type.Fixed.annot ty) in
    begin
      check_alloc instrs;
      begin match Type.unfix ty with
      | Type.Void -> check_noreturn instrs
      | _ -> if not (check_must_return instrs ) then
          raise ( Warner.Error (fun f ->
            Format.fprintf f "in %a : not all control paths returns a value." Warner.ploc loc
          ))
      end
    end
  | _ -> ()

let apply () prog =
  begin match prog.Prog.main with
  | Some li -> check_noreturn li
  | None -> ()
  end;
  List.iter check_fun prog.Prog.funs;
  prog
