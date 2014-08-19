let main =
  let maximum = 1 in
  let b0 = 2 in
  let a = 408464633 in
  let rec d a b0 =
    (if (a <> 1)
     then let b = b0 in
     let found = false in
     let rec f a b b0 found =
       (if ((b * b) < a)
        then ((fun  (a, b, b0, found) -> let b = (b + 1) in
        (f a b b0 found)) (if ((a mod b) = 0)
                           then let a = (a / b) in
                           let b0 = b in
                           let b = a in
                           let found = true in
                           (a, b, b0, found)
                           else (a, b, b0, found)))
        else let a = (if (not found)
                      then (
                             (Printf.printf "%d" a);
                             (Printf.printf "%s" "\n");
                             let a = 1 in
                             a
                             )
                      
                      else a) in
        (d a b0)) in
       (f a b b0 found)
     else ()) in
    (d a b0)

