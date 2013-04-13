let rec foo a =
  let a = ref a in
  a := 4

let () =
begin
  let a = 0 in
  foo a;
  Printf.printf "%d" (a);
  Printf.printf "%s" ("\n")
end
 