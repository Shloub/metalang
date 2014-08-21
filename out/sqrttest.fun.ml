let isqrt c =
  ((int_of_float (sqrt (float_of_int ( c)))))
let main =
  (
    (Printf.printf "%d %d %d %d %d %d " (isqrt 4) (isqrt 16) (isqrt 20) (isqrt 1000) (isqrt 500) (isqrt 10))
    )
  

