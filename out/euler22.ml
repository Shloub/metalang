
let score () =
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let len = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let sum = ref( 0 ) in
  for _i = 1 to len do
    let c = Scanf.scanf "%c" (fun x -> x) in
    sum := (!sum) + (int_of_char (c) - int_of_char ('A')) + 1
    (*		print c print " " print sum print " " *)
  done;
  (!sum)

let () =
begin
  let sum = ref( 0 ) in
  let n = Scanf.scanf "%d" (fun x -> x) in
  for i = 1 to n do
    sum := (!sum) + i * (score ())
  done;
  Printf.printf "%d" (!sum);
  Printf.printf "\n"
end
 