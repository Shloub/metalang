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

(**
   Cette passe effectue un renomage des variables.
   Le but est de renommer les variables qui ont des noms inutilisables (les mots clés par exemple)
   @see <http://prologin.org> Prologin
   @author Prologin (info\@prologin.org)
   @author Maxime Audouin (coucou747\@gmail.com)
*)

open Stdlib

open Ast
open Fresh
open PassesUtils

type acc0 = unit
type 'a acc = varname BindingMap.t

let map = ref BindingMap.empty;;

let rec new_name i n =
  let n2 = (n ^ (string_of_int i)) in
  if BindingSet.mem n2 !Fresh.bindings then
    new_name (i+1) n2
  else n2

let new_name n = new_name 0 n

let add name =
  map := BindingMap.add name (new_name name) !map

let clear () =
  map := BindingMap.empty

let init_acc () = !map

let mapname map name =
  match BindingMap.find_opt name map with
  | Some s -> s
  | None -> name

let rec mapmutable map m =
  match m |> Mutable.unfix with
  | Mutable.Var v -> Mutable.Var (mapname map v) |> Mutable.fix
  | Mutable.Array (v, li) ->
    Mutable.Array ((mapmutable map v), List.map (process_expr map) li) |> Mutable.fix
  | Mutable.Dot (m, f) ->
    Mutable.Dot ((mapmutable map m), f) |> Mutable.fix

and process_expr map e =
  let f e = Expr.Fixed.fixa (Expr.Fixed.annot e) (match Expr.Fixed.unfix e with
    | Expr.Access mutable_ ->
      Expr.Access (mapmutable map mutable_)
    | Expr.Call (funname, li) ->
      Expr.Call ((mapname map funname), li)
    | e -> e)
  in Expr.Writer.Deep.map f e

let rec process_instr map i =
  let i2 = match Instr.unfix i with
    | Instr.Unquote (e) -> Instr.Unquote (process_expr map e)
    | Instr.Tag s -> Instr.Tag s
    | Instr.Declare (v, t, e, option) ->
      Instr.Declare ( (mapname map v), t, process_expr map e, option)
    | Instr.Affect (m, e) ->
      Instr.Affect ((mapmutable map m), process_expr map e)
    | Instr.Loop (var, e1, e2, li) ->
      Instr.Loop ( (mapname map var), (process_expr map e1), (process_expr map e2), List.map (process_instr map) li )
    | Instr.While (e, li) ->
      Instr.While ((process_expr map e), List.map (process_instr map) li )
    | Instr.Comment s -> Instr.Comment s
    | Instr.Return e -> Instr.Return (process_expr map e)
    | Instr.AllocArray (name, t, e, None) ->
      Instr.AllocArray ((mapname map name), t, (process_expr map e), None)
    | Instr.AllocArray (name, t, e, Some ((var, li))) ->
      let li2 = List.map (process_instr map) li in
      Instr.AllocArray ((mapname map name), t, (process_expr map e), Some (( (mapname map var), li2)))
    | Instr.AllocRecord (name, t, el) ->
      Instr.AllocRecord ((mapname map name), t,
                         (List.map
                            (fun (field, e) ->
                              (field, process_expr map e))
                         ) el)
    | Instr.If (e, li1, li2) ->
      Instr.If ((process_expr map e),
                (List.map (process_instr map) li1 ),
                (List.map (process_instr map) li2 )
      )
    | Instr.Call (name, li) ->
      Instr.Call ((mapname map name), List.map (process_expr map) li)
    | Instr.Print (t, e) ->
      Instr.Print (t, process_expr map e)
    | Instr.Read (t, m) ->
      Instr.Read (t, mapmutable map m)
    | Instr.DeclRead (t, v, opt) ->
      Instr.DeclRead (t, mapname map v, opt)
    | Instr.Untuple (li, e)->
      Instr.Untuple (List.map (fun (t, n) -> t, mapname map n) li, process_expr map e)
    | Instr.StdinSep -> Instr.StdinSep
  in Instr.Fixed.fixa (Instr.Fixed.annot i) i2

let process_main acc m = acc, List.map (process_instr acc) m
let process acc p =
  let p = match p with
    | Prog.DeclarFun (funname, t, params, instrs, opt) ->
      Prog.DeclarFun (mapname acc funname, t,
                      (List.map (fun (n, t) -> (mapname acc n), t) params),
                      (List.map (process_instr acc) instrs), opt)
    | _ -> p (* TODO *)
  in acc, p
