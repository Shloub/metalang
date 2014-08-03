let () =
begin
  let j = ref( 0 ) in
  for k = 0 to 10 do
    j := (!j) + k;
    Printf.printf "%d\n" (!j)
  done;
  let i = ref( 4 ) in
  while (!i) < 10
  do
      Printf.printf "%d" (!i);
      i := (!i) + 1;
      j := (!j) + (!i)
  done;
  Printf.printf "%d%dFIN TEST\n" (!j) (!i)
end
 