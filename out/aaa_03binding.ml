let g i =
  let j = i * 4 in
  if (j mod 2) = 1 then
    0
  else
    j

let h i =
  Printf.printf "%d\n" i

let () =
begin
  h 14;
  let a = ref( 4 ) in
  let b = ref( 5 ) in
  Printf.printf "%d" ((!a) + (!b));
  (* main *)
  h 15;
  a := 2;
  b := 1;
  Printf.printf "%d" ((!a) + (!b))
end
 