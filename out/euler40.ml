let exp0 a e =
  let o = ref( 1 ) in
  for _i = 1 to e do
    o := (!o) * a
  done;
  (!o)

exception Found_1 of int

let e t n =
  let n = ref n in
  try
  for i = 1 to 8 do
    if (!n) >= t.(i) * i then
      n := (!n) - t.(i) * i
    else
      begin
        let nombre = exp0 10 (i - 1) + (!n) / i in
        let chiffre = i - 1 - (!n) mod i in
        raise (Found_1((nombre / exp0 10 chiffre) mod 10))
      end
  done;
  -1
  with Found_1 (out) -> out

let () =
begin
  let t = Array.init 9 (fun i ->
    exp0 10 i - exp0 10 (i - 1)) in
  for i2 = 1 to 8 do
    Printf.printf "%d => %d\n" i2 t.(i2)
  done;
  for j = 0 to 80 do
    Printf.printf "%d" (e t j)
  done;
  Printf.printf "\n";
  for k = 1 to 50 do
    Printf.printf "%d" k
  done;
  Printf.printf "\n";
  for j2 = 169 to 220 do
    Printf.printf "%d" (e t j2)
  done;
  Printf.printf "\n";
  for k2 = 90 to 110 do
    Printf.printf "%d" k2
  done;
  Printf.printf "\n";
  let out0 = ref( 1 ) in
  for l = 0 to 6 do
    let puiss = exp0 10 l in
    let v = e t (puiss - 1) in
    out0 := (!out0) * v;
    Printf.printf "10^%d=%d v=%d\n" l puiss v
  done;
  Printf.printf "%d\n" (!out0)
end
 