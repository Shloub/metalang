let id b =
  b

let g t index =
  t.(index) <- false

let () =
begin
  let j = ref( 0 ) in
  let a = Array.init 5 (fun i ->
    Printf.printf "%d" i;
    j := (!j) + i;
    (i mod 2) = 0) in
  Printf.printf "%d " (!j);
  let c = a.(0) in
  if c then
    Printf.printf "True"
  else
    Printf.printf "False";
  Printf.printf "\n";
  g (id a) 0;
  let d = a.(0) in
  if d then
    Printf.printf "True"
  else
    Printf.printf "False";
  Printf.printf "\n"
end
 