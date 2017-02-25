let g i =
  let j = i * 4 in
  if j mod 2 = 1 then
    0
  else
    j
let h i =
  Printf.printf "%d\n" i
let () =
 h 14;
  let a = 4 in
  let b = 5 in
  Printf.printf "%d" (a + b);
  (* main *)
  h 15;
  let a = 2 in
  let b = 1 in
  Printf.printf "%d" (a + b) 
 