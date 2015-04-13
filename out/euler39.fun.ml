let main =
  let t = (Array.init 1001 (fun  i -> 0)) in
  let rec d a =
    (if (a <= 1000)
     then let rec f b =
            (if (b <= 1000)
             then let c2 = ((a * a) + (b * b)) in
             let c = ((int_of_float (sqrt (float_of_int ( c2))))) in
             (if ((c * c) = c2)
              then let p = ((a + b) + c) in
              (if (p <= 1000)
               then (
                      t.(p) <- (t.(p) + 1);
                      (f (b + 1))
                      )
               
               else (f (b + 1)))
              else (f (b + 1)))
             else (d (a + 1))) in
            (f 1)
     else let j = 0 in
     let rec e k j =
       (if (k <= 1000)
        then (if (t.(k) > t.(j))
              then let j = k in
              (e (k + 1) j)
              else (e (k + 1) j))
        else (Printf.printf "%d" j)) in
       (e 1 j)) in
    (d 1)

