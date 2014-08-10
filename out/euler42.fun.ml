module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let rec isqrt =
  (fun c ->
      ((int_of_float (sqrt (float_of_int ( c))))));;
let rec is_triangular =
  (fun n ->
      (* 
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
    *)
      ((fun a ->
           ((a * (a + 1)) = (n * 2))) (isqrt (n * 2))));;
let rec score =
  (fun () -> (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
   len ->
  (Scanf.scanf "%[\n \010]" (fun _ -> ((fun sum ->
                                           ((fun e f ->
                                                let rec d i sum len =
                                                  (if (i <= f)
                                                   then Scanf.scanf "%c" (fun
                                                    c ->
                                                   ((fun sum ->
                                                        (* 		print c print " " print sum print " "  *)
                                                        (d (i + 1) sum len)) (sum + (((int_of_char (c)) - (int_of_char ('A'))) + 1))))
                                                   else ((fun b ->
                                                             (if (is_triangular sum)
                                                              then 1
                                                              else 0)) (fun
                                                    sum len ->
                                                   ()))) in
                                                  (d e sum len)) 1 len)) 0)))))));;
let rec main =
  ((fun m o ->
       let rec k i =
         (if (i <= o)
          then ((fun l ->
                    (if (is_triangular i)
                     then (Printf.printf "%d" i;
                     (Printf.printf "%s" " ";
                     (l ())))
                     else (l ()))) (fun () -> (k (i + 1))))
          else (Printf.printf "%s" "\n";
          ((fun sum ->
               Scanf.scanf "%d" (fun n ->
                                    ((fun h j ->
                                         let rec g i n sum =
                                           (if (i <= j)
                                            then ((fun sum ->
                                                      (g (i + 1) n sum)) (sum + (score ())))
                                            else (Printf.printf "%d" sum;
                                            (Printf.printf "%s" "\n";
                                            ()))) in
                                           (g h n sum)) 1 n))) 0))) in
         (k m)) 1 55);;

