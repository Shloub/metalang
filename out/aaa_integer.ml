
let () =
begin
  let i = ref( 0 ) in
  i := (!i) - 1;
  Printf.printf "%d" (!i);
  Printf.printf "\n";
  i := (!i) + 55;
  Printf.printf "%d" (!i);
  Printf.printf "\n";
  i := (!i) * 13;
  Printf.printf "%d" (!i);
  Printf.printf "\n";
  i := (!i) / 2;
  Printf.printf "%d" (!i);
  Printf.printf "\n";
  i := (!i) + 1;
  Printf.printf "%d" (!i);
  Printf.printf "\n";
  i := (!i) / 3;
  Printf.printf "%d" (!i);
  Printf.printf "\n";
  i := (!i) - 1;
  Printf.printf "%d" (!i);
  Printf.printf "\n";
  (*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*)
  let a = 117 / 17 in
  Printf.printf "%d" a;
  Printf.printf "\n";
  let b = 117 / -17 in
  Printf.printf "%d" b;
  Printf.printf "\n";
  let c = -117 / 17 in
  Printf.printf "%d" c;
  Printf.printf "\n";
  let d = -117 / -17 in
  Printf.printf "%d" d;
  Printf.printf "\n";
  let e = 117 mod 17 in
  Printf.printf "%d" e;
  Printf.printf "\n";
  let f = 117 mod -17 in
  Printf.printf "%d" f;
  Printf.printf "\n";
  let g = -117 mod 17 in
  Printf.printf "%d" g;
  Printf.printf "\n";
  let h = -117 mod -17 in
  Printf.printf "%d" h;
  Printf.printf "\n"
end
 