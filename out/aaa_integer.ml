
let () =
begin
  let i = ref( 0 ) in
  i := (!i) - 1;
  Printf.printf "%d\n" (!i);
  i := (!i) + 55;
  Printf.printf "%d\n" (!i);
  i := (!i) * 13;
  Printf.printf "%d\n" (!i);
  i := (!i) / 2;
  Printf.printf "%d\n" (!i);
  i := (!i) + 1;
  Printf.printf "%d\n" (!i);
  i := (!i) / 3;
  Printf.printf "%d\n" (!i);
  i := (!i) - 1;
  Printf.printf "%d\n" (!i);
  (*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*)
  let a = 117 / 17 in
  Printf.printf "%d\n" a;
  let b = 117 / -17 in
  Printf.printf "%d\n" b;
  let c = -117 / 17 in
  Printf.printf "%d\n" c;
  let d = -117 / -17 in
  Printf.printf "%d\n" d;
  let e = 117 mod 17 in
  Printf.printf "%d\n" e;
  let f = 117 mod -17 in
  Printf.printf "%d\n" f;
  let g = -117 mod 17 in
  Printf.printf "%d\n" g;
  let h = -117 mod -17 in
  Printf.printf "%d\n" h
end
 