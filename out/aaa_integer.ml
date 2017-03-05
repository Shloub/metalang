
let () =
 let i = 0 in
  let i = i - 1 in
  Printf.printf "%d\n" i;
  let i = i + 55 in
  Printf.printf "%d\n" i;
  let i = i * 13 in
  Printf.printf "%d\n" i;
  let i = i / 2 in
  Printf.printf "%d\n" i;
  let i = i + 1 in
  Printf.printf "%d\n" i;
  let i = i / 3 in
  Printf.printf "%d\n" i;
  let i = i - 1 in
  Printf.printf "%d\n" i;
  (*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*)
  Printf.printf "%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n" (117 / 17) (117 / - 17) (- 117 / 17) (- 117 / - 17) (117 mod 17) (117 mod - 17) (- 117 mod 17) (- 117 mod - 17) 
 