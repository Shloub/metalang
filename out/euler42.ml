
let isqrt c =
  (int_of_float (sqrt (float_of_int ( c))))


let is_triangular n =
  (*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   *)
  let a = isqrt (n * 2) in
  a * (a + 1) = n * 2

let score () =
  let len = Scanf.scanf " %d " (fun v_0 -> v_0) in
  let sum = ref( 0 ) in
  for _i = 1 to len do
    let c = Scanf.scanf "%c" (fun v_0 -> v_0) in
    sum := (!sum) + (int_of_char (c) - int_of_char ('A')) + 1
    (*		print c print " " print sum print " " *)
  done;
  if is_triangular (!sum) then
    1
  else
    0

let () =
begin
  for i = 1 to 55 do
    if is_triangular i then
      begin
        Printf.printf "%d " i
      end
  done;
  Printf.printf "\n";
  let sum = ref( 0 ) in
  let n = Scanf.scanf "%d" (fun v_0 -> v_0) in
  for i = 1 to n do
    sum := (!sum) + (score ())
  done;
  Printf.printf "%d\n" (!sum)
end
 