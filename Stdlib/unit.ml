(* tests unitaires. *)
let () = begin
  let a = Stdlib.String.replace "o" "\\o" "toto" in
  Format.printf "a=%S\n" a;
  assert (a = "t\\ot\\o");
  assert (Stdlib.List.mapi (fun i a -> a + i) [0 ; 1; 10; 15] = [0; 2; 12; 18] );
end
