let score () =
  let len = Scanf.scanf " %d " (fun len -> len) in
  let sum = ref( 0 ) in
  for _i = 1 to len do
    let c = Scanf.scanf "%c" (fun c -> c) in
    sum := (!sum) + (int_of_char (c)) - (int_of_char ('A')) + 1
    (*		print c print " " print sum print " " *)
  done;
  (!sum)
let () =
 let sum = ref( 0 ) in
  let n = Scanf.scanf "%d" (fun n -> n) in
  for i = 1 to n do
    sum := (!sum) + i * score ()
  done;
  Printf.printf "%d\n" (!sum) 
 