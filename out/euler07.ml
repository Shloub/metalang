exception Found_1 of bool

let divisible n t size =
  try
  for i = 0 to size - 1 do
    if n mod t.(i) = 0 then
      raise (Found_1(true))
  done;
  false
  with Found_1 (out) -> out

let find n t used nth =
  let n = ref n in
  let used = ref used in
  while (!used) <> nth do
    if divisible (!n) t (!used) then
      n := (!n) + 1
    else
      begin
         t.((!used)) <- (!n);
         n := (!n) + 1;
         used := (!used) + 1
      end
  done;
  t.((!used) - 1)

let () =
 let n = 10001 in
  let t = Array.init n (fun _i ->
    2) in
  Printf.printf "%d\n" (find 3 t 1 n) 
 