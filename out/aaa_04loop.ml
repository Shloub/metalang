exception Found_1 of bool

let h i =
  try
  (*  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end *)
  let j = ref( i - 2 ) in
  while (!j) <= i + 2
  do
      if (i mod (!j)) = 5 then
        raise (Found_1(true));
      j := (!j) + 1
  done;
  false
  with Found_1 (out) -> out

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
 