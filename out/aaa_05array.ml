let id b =
  b

let g t index =
  t.(index) <- false

let () =
begin
  let c = 5 in
  let a = Array.init c (fun i ->
    Printf.printf "%d" i;
    (i mod 2) = 0) in
  let d = a.(0) in
  if d then
    Printf.printf "True"
  else
    Printf.printf "False";
  Printf.printf "\n";
  g (id a) 0;
  let e = a.(0) in
  if e then
    Printf.printf "True"
  else
    Printf.printf "False";
  Printf.printf "\n"
end
 