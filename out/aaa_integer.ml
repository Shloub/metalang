
let () =
begin
  let i = ref( 0 ) in
  i := (!i) + 1;
  Printf.printf "%d" (!i);
  i := (!i) + 55;
  Printf.printf "%d" (!i);
  i := (!i) * 13;
  Printf.printf "%d" (!i);
  i := (!i) / 2;
  Printf.printf "%d" (!i);
  i := (!i) + 1;
  Printf.printf "%d" (!i);
  i := (!i) / 3;
  Printf.printf "%d" (!i);
  i := (!i) - 1;
  Printf.printf "%d" (!i)
end
 