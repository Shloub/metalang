let isqrt c =
  ((int_of_float (sqrt (float_of_int ( c)))))
let main =
  (
    (Printf.printf "%d" (isqrt 4));
    (Printf.printf "%s" " ");
    (Printf.printf "%d" (isqrt 16));
    (Printf.printf "%s" " ");
    (Printf.printf "%d" (isqrt 20));
    (Printf.printf "%s" " ");
    (Printf.printf "%d" (isqrt 1000));
    (Printf.printf "%s" " ");
    (Printf.printf "%d" (isqrt 500));
    (Printf.printf "%s" " ");
    (Printf.printf "%d" (isqrt 10));
    (Printf.printf "%s" " ")
    )
  

