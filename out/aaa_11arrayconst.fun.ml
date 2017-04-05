let test tab len =
  let rec a i =
    if i <= len - 1
    then ( Printf.printf "%d " tab.(i);
           a (i + 1))
    else Printf.printf "%s" "\n" in
    a 0

let main =
  let t = Array.init 5 (fun i -> 1) in
  ( test t 5;
    ())

