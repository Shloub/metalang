
let isqrt c =
  (int_of_float (sqrt (float_of_int ( c))))

let () =
begin
  let a = isqrt 4 in
  Printf.printf "%d " a;
  let b = isqrt 16 in
  Printf.printf "%d " b;
  let d = isqrt 20 in
  Printf.printf "%d " d;
  let e = isqrt 1000 in
  Printf.printf "%d " e;
  let f = isqrt 500 in
  Printf.printf "%d " f;
  let g = isqrt 10 in
  Printf.printf "%d " g
end
 