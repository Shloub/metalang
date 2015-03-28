type toto = {
  mutable s : string;
  mutable v : int;
};;

let idstring s =
  s

let printstring s =
  Printf.printf "%s\n" (idstring s)

let print_toto t =
  Printf.printf "%s = %d\n" t.s t.v

let () =
begin
  let tab = Array.init 2 (fun _i ->
    idstring "chaine de test") in
  for j = 0 to 1 do
    printstring (idstring tab.(j))
  done;
  print_toto {
    s="one";
    v=1;
  }
end
 