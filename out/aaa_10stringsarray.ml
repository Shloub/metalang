(*
TODO ajouter un record qui contient des chaines.
*)
let idstring s =
  s

let printstring s =
  Printf.printf "%s\n" (idstring s)

let () =
begin
  let tab = Array.init 2 (fun _i ->
    idstring "chaine de test") in
  for j = 0 to 1 do
    printstring (idstring tab.(j))
  done
end
 