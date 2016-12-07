(*
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
*)
let () =
 let j = 0 in
  let j = 0 in
  Printf.printf "%d\n" j;
  let j = 1 in
  Printf.printf "%d\n" j;
  let j = 2 in
  Printf.printf "%d\n" j;
  let j = 3 in
  Printf.printf "%d\n" j;
  let j = 4 in
  Printf.printf "%d\n" j 
 