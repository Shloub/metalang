(*
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
*)
let () =
begin
  let j = ref( 0 ) in
  j := 0;
  Printf.printf "%d\n" (!j);
  j := 1;
  Printf.printf "%d\n" (!j);
  j := 2;
  Printf.printf "%d\n" (!j);
  j := 3;
  Printf.printf "%d\n" (!j);
  j := 4;
  Printf.printf "%d\n" (!j)
end
 