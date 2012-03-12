open Stdlib
open Ast

let var_of_int =
  let alpha = Array.init 26 (fun i -> char_of_int (i + (int_of_char 'a') ) ) in
  let len = 26 in
  let rec f i =
    let s = String.make 1 alpha.(i mod len)  in
    if i / len == 0 then s
    else
      (f (i / len) ) ^ s
  in f;;

let bindings = ref BindingSet.empty

let fresh_init (progname, toplvl, instrs) =
  let addset acc i = Instr.Writer.Deep.fold
    (fun acc i ->
      match Instr.unfix i with
	| Instr.Declare (b, _, _)
	| Instr.AllocArray (b, _, _, _)
	| Instr.Loop (b, _, _, _)
	    -> BindingSet.add b acc
	| _ -> acc
    ) acc i
  in
  let addtop (acc : BindingSet.t) t : BindingSet.t = match t with
    | Prog.DeclarFun (v, t, params, instrs) ->
      let acc = BindingSet.add v acc in
      let acc:BindingSet.t = List.fold_left
	(fun acc ((v:string), _ ) -> BindingSet.add v acc)
	acc params in
      let acc:BindingSet.t = List.fold_left addset acc instrs in
      acc
    | _ -> acc
  in
  let set = BindingSet.empty in
  let set = List.fold_left addset set instrs in
  let set = List.fold_left addtop set toplvl in
  (*let () = BindingSet.iter
    (fun s -> Printf.printf "%s\n" s) set in
  let () = Printf.printf "len = %d\n" (BindingSet.cardinal set) in
  *)
  let () = bindings := set
  in ();;

let fresh =
  let r = ref (-1) in
  let rec gen () =
    r := !r + 1 ;
    let out = var_of_int !r in
    if BindingSet.mem out !bindings then gen () else out
  in gen


