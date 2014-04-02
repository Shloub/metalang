
let () =
begin
  let sum = ref( 0 ) in
  for i = 0 to 999 do
    if (i mod 3) = 0 or (i mod 5) = 0 then
      sum := (!sum) + i
  done;
  Printf.printf "%d" (!sum);
  Printf.printf "\n"
end
 