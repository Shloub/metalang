
let score () =
  let len = Scanf.scanf " %d " (fun v_0 -> v_0) in
  let sum = ref( 0 ) in
  for _i = 1 to len do
    let c = Scanf.scanf "%c" (fun v_0 -> v_0) in
    sum := (!sum) + (int_of_char (c) - int_of_char ('A')) + 1
    (*		print c print " " print sum print " " *)
  done;
  (!sum)

let () =
begin
  let sum = ref( 0 ) in
  let n = Scanf.scanf "%d" (fun v_0 -> v_0) in
  for i = 1 to n do
    sum := (!sum) + i * (score ())
  done;
  Printf.printf "%d" (!sum);
  Printf.printf "\n"
end
 