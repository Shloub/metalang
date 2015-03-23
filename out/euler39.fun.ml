let main =
  let t = (Array.init 1001 (fun  i -> 0)) in
  let rec g a =
    (if (a <= 1000)
     then let rec h b =
            (if (b <= 1000)
             then let c2 = ((a * a) + (b * b)) in
             let c = ((int_of_float (sqrt (float_of_int ( c2))))) in
             (if ((c * c) = c2)
              then let p = ((a + b) + c) in
              (if (p <= 1000)
               then (
                      t.(p) <- (t.(p) + 1);
                      (h (b + 1))
                      )
               
               else (h (b + 1)))
              else (h (b + 1)))
             else (g (a + 1))) in
            (h 1)
     else let j = 0 in
     let rec f k j =
       (if (k <= 1000)
        then (if (t.(k) > t.(j))
              then let j = k in
              (f (k + 1) j)
              else (f (k + 1) j))
        else (Printf.printf "%d" j)) in
       (f 1 j)) in
    (g 1)

