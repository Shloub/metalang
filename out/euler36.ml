exception Found_1 of bool

let palindrome2 pow2 n =
  try
  let t = Array.init 20 (fun i ->
    n / pow2.(i) mod 2 = 1) in
  let nnum = ref( 0 ) in
  for j = 1 to 19 do
    if t.(j) then
      nnum := j
  done;
  for k = 0 to (!nnum) / 2 do
    if t.(k) <> t.((!nnum) - k) then
      raise (Found_1(false))
  done;
  true
  with Found_1 (out) -> out
let () =
 let p = ref( 1 ) in
  let pow2 = Array.init 20 (fun i ->
    p := (!p) * 2;
    (!p) / 2) in
  let sum = ref( 0 ) in
  for d = 1 to 9 do
    if palindrome2 pow2 d then
      begin
         Printf.printf "%d\n" d;
         sum := (!sum) + d
      end;
    if palindrome2 pow2 (d * 10 + d) then
      begin
         Printf.printf "%d\n" (d * 10 + d);
         sum := (!sum) + d * 10 + d
      end
  done;
  for a0 = 0 to 4 do
    let a = a0 * 2 + 1 in
    for b = 0 to 9 do
      for c = 0 to 9 do
        let num0 = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a in
        if palindrome2 pow2 num0 then
          begin
             Printf.printf "%d\n" num0;
             sum := (!sum) + num0
          end;
        let num1 = a * 10000 + b * 1000 + c * 100 + b * 10 + a in
        if palindrome2 pow2 num1 then
          begin
             Printf.printf "%d\n" num1;
             sum := (!sum) + num1
          end
      done;
      let num2 = a * 100 + b * 10 + a in
      if palindrome2 pow2 num2 then
        begin
           Printf.printf "%d\n" num2;
           sum := (!sum) + num2
        end;
      let num3 = a * 1000 + b * 100 + b * 10 + a in
      if palindrome2 pow2 num3 then
        begin
           Printf.printf "%d\n" num3;
           sum := (!sum) + num3
        end
    done
  done;
  Printf.printf "sum=%d\n" (!sum) 
 