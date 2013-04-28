
let () =
begin
  let j = ref( 0 ) in
  j := 0;
  Printf.printf "%d" (!j);
  Printf.printf "%s" "\n";
  j := 1;
  Printf.printf "%d" (!j);
  Printf.printf "%s" "\n";
  j := 2;
  Printf.printf "%d" (!j);
  Printf.printf "%s" "\n";
  j := 3;
  Printf.printf "%d" (!j);
  Printf.printf "%s" "\n";
  j := 4;
  Printf.printf "%d" (!j);
  Printf.printf "%s" "\n"
end
 