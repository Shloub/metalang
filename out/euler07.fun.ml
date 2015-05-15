let divisible n t size =
  let rec a i =
    if i <= size - 1
    then if n mod t.(i) = 0
         then true
         else a (i + 1)
    else false in
    a 0
let find n t used nth =
  let rec b n used =
    if used <> nth
    then if divisible n t used
         then let n = n + 1 in
         b n used
         else ( t.(used) <- n;
                let n = n + 1 in
                let used = used + 1 in
                b n used)
    else t.(used - 1) in
    b n used
let main =
  let n = 10001 in
  let t = Array.init n (fun i -> 2) in
  Printf.printf "%d\n" (find 3 t 1 n)

