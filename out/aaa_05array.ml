let id b =
  b

let g t index =
  t.(index) <- false
let () =
 let j = ref( 0 ) in
  let a = Array.init 5 (fun i ->
    Printf.printf "%d" i;
    j := (!j) + i;
    i mod 2 = 0) in
  Printf.printf "%d " (!j);
  if a.(0) then
    Printf.printf "True"
  else
    Printf.printf "False";
  Printf.printf "\n";
  g (id a) 0;
  if a.(0) then
    Printf.printf "True"
  else
    Printf.printf "False";
  Printf.printf "\n" 
 