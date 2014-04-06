
let isqrt c =
  (int_of_float (sqrt (float_of_int ( c))))

let () =
begin
  let a = isqrt 4 in
  Printf.printf "%d" a;
  Printf.printf " ";
  let b = isqrt 16 in
  Printf.printf "%d" b;
  Printf.printf " ";
  let d = isqrt 20 in
  Printf.printf "%d" d;
  Printf.printf " ";
  let e = isqrt 1000 in
  Printf.printf "%d" e;
  Printf.printf " ";
  let f = isqrt 500 in
  Printf.printf "%d" f;
  Printf.printf " ";
  let g = isqrt 10 in
  Printf.printf "%d" g;
  Printf.printf " "
end
 