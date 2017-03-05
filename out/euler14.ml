let next0 n =
  if n mod 2 = 0 then
    n / 2
  else
    3 * n + 1

let rec find n m =
  if n = 1 then
    1
  else
    if n >= 1000000 then
      1 + find (next0 n) m
    else
      if m.(n) <> 0 then
        m.(n)
      else
        begin
           m.(n) <- 1 + find (next0 n) m;
           m.(n)
        end
let () =
 let m = Array.init 1000000 (fun _j ->
   0) in
  let max0 = ref( 0 ) in
  let maxi = ref( 0 ) in
  for i = 1 to 999 do
    (* normalement on met 999999 mais ça dépasse les int32... *)
    let n2 = find i m in
    if n2 > (!max0) then
      begin
         max0 := n2;
         maxi := i
      end
  done;
  Printf.printf "%d\n%d\n" (!max0) (!maxi) 
 