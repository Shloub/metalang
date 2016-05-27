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
open PassesUtils

type acc0 = unit
type 'a acc = string StringMap.t

let map : acc0 acc ref = ref StringMap.empty

let rec new_name i n =
  let n2 = (n ^ (string_of_int i)) in
  if StringSet.mem n2 !Fresh.bindings then
    new_name (i+1) n2
  else n2

let new_name n = new_name 0 n

let add name =
  map := StringMap.add name (new_name name) !map

let clear () =
  map := StringMap.empty

let init_acc () = !map

let mapname map name =
  match StringMap.find_opt name map with
  | Some s -> s
  | None -> name

let mapname_fun = mapname
let mapname_enum = mapname
let mapname_field = mapname
let mapname_ty = mapname

let mapname map = function
  | UserName username -> UserName (mapname map username)
  | InternalName i -> InternalName i

let rec mapty map t = match Type.unfix t with
| Type.Integer | Type.String | Type.Char | Type.Void | Type.Bool | Type.Lexems | Type.Auto -> t
| Type.Array t2 -> Type.array (mapty map t2)
| Type.Struct li -> Type.struct_ (List.map (fun (name, t) -> mapname_field map name, mapty map t) li)
| Type.Enum li -> Type.enum (List.map (mapname_enum map) li)
| Type.Named n -> Type.named (mapname_ty map n)
| Type.Tuple li -> Type.tuple (List.map (mapty map) li)

let rec mapmutable map m =
  match m |> Mutable.unfix with
  | Mutable.Var v -> Mutable.Var (mapname map v) |> Mutable.fix
  | Mutable.Array (v, li) ->
    Mutable.Array ((mapmutable map v), List.map (process_expr map) li) |> Mutable.fix
  | Mutable.Dot (m, f) ->
    Mutable.Dot ((mapmutable map m), mapname_field map f) |> Mutable.fix

and process_expr map e =
  let f e = Expr.Fixed.fixa (Expr.Fixed.annot e) (match Expr.Fixed.unfix e with
  | Expr.Access mutable_ ->
      Expr.Access (mapmutable map mutable_)
  | Expr.Call (funname, li) ->
      Expr.Call (mapname_fun map funname, li)
  | Expr.Lief (Expr.Enum e) -> Expr.Lief (Expr.Enum (mapname_enum map e))
  | Expr.Record li ->
      let li = List.map (fun (s, e) -> mapname_field map s, process_expr map e) li in
      Expr.Record li
  | e -> e)
  in Expr.Writer.Deep.map f e

let rec process_instr map i =
  let i2 = match Instr.unfix i with
    | Instr.Unquote (e) -> Instr.Unquote (process_expr map e)
    | Instr.Tag s -> Instr.Tag s
    | Instr.Declare (v, t, e, option) ->
      Instr.Declare (mapname map v, mapty map t, process_expr map e, option)
    | Instr.Affect (m, e) ->
      Instr.Affect ((mapmutable map m), process_expr map e)
    | Instr.SelfAffect (m, op, e) ->
      Instr.SelfAffect ((mapmutable map m), op, process_expr map e)
    | Instr.Loop (var, e1, e2, li) ->
      Instr.Loop (mapname map var, (process_expr map e1), (process_expr map e2), List.map (process_instr map) li )
    | Instr.While (e, li) ->
      Instr.While ((process_expr map e), List.map (process_instr map) li )
    | Instr.Comment s -> Instr.Comment s
    | Instr.Return e -> Instr.Return (process_expr map e)
    | Instr.AllocArray (name, t, e, None, opt) ->
      Instr.AllocArray (mapname map name, mapty map t, (process_expr map e), None, opt)
    | Instr.AllocArrayConst (name, t, e, lief, opt) ->
      Instr.AllocArrayConst (mapname map name, mapty map t, (process_expr map e), lief, opt)
    | Instr.AllocArray (name, t, e, Some ((var, li)), opt) ->
      let li2 = List.map (process_instr map) li in
      Instr.AllocArray (mapname map name, mapty map t, (process_expr map e), Some ((mapname map var, li2)), opt)
    | Instr.AllocRecord (name, t, el, opt) ->
      Instr.AllocRecord (mapname map name, mapty map t,
                         (List.map
                            (fun (field, e) ->
                              (mapname_field map field, process_expr map e))
                         ) el, opt)
    | Instr.If (e, li1, li2) ->
      Instr.If ((process_expr map e),
                (List.map (process_instr map) li1 ),
                (List.map (process_instr map) li2 )
      )
    | Instr.Call (name, li) ->
      Instr.Call (mapname_fun map name, List.map (process_expr map) li)
    | Instr.Print li ->
        let li = List.map (function
          | Instr.StringConst str -> Instr.StringConst str
          | Instr.PrintExpr (t, e) -> Instr.PrintExpr (mapty map t, process_expr map e)) li
        in Instr.Print li
    | Instr.Read li ->
        let li = List.map (function
          | Instr.Separation -> Instr.Separation
          | Instr.DeclRead (t, v, opt) -> Instr.DeclRead (mapty map t, mapname map v, opt)
          | Instr.ReadExpr (t, m) -> Instr.ReadExpr (mapty map t, mapmutable map m)) li
        in Instr.Read li
    | Instr.Untuple (li, e, opt)->
      Instr.Untuple (List.map (fun (t, n) -> mapty map t, mapname map n) li, process_expr map e, opt)
  in Instr.Fixed.fixa (Instr.Fixed.annot i) i2

let process_main acc m = acc, List.map (process_instr acc) m
let process acc p =
  let p = match p with
    | Prog.DeclarFun (funname, t, params, instrs, opt) ->
      Prog.DeclarFun (mapname_fun acc funname,  mapty acc t,
                      (List.map (fun (n, t) -> (mapname acc n),  mapty acc t) params),
                      (List.map (process_instr acc) instrs), opt)
    | Prog.DeclareType (tyname, ty) ->
        Prog.DeclareType (mapname_ty acc tyname, mapty acc ty)
    | _ -> p
  in acc, p
