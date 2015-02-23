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
  Printf.printf "%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n" (117 / 17) (117 / -17) (-117 /
                                                                            17) (-117 /
                                                                                -17) (117 mod
                                                                                17) (117 mod
                                                                                -17) (-117 mod
                                                                                17) (-117 mod
                                                                                -17)
end
 