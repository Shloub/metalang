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

let rec score =
  (fun () -> (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
   len ->
  (Scanf.scanf "%[\n \010]" (fun _ -> ((fun sum ->
                                           ((fun b d ->
                                                let rec a i sum len =
                                                  (if (i <= d)
                                                   then Scanf.scanf "%c" (fun
                                                    c ->
                                                   ((fun sum ->
                                                        (* 		print c print " " print sum print " "  *)
                                                        (a (i + 1) sum len)) (sum + (((int_of_char (c)) - (int_of_char ('A'))) + 1))))
                                                   else sum) in
                                                  (a b sum len)) 1 len)) 0)))))));;
let rec main =
  ((fun sum ->
       Scanf.scanf "%d" (fun n ->
                            ((fun f g ->
                                 let rec e i n sum =
                                   (if (i <= g)
                                    then ((fun sum ->
                                              (e (i + 1) n sum)) (sum + (i * (score ()))))
                                    else (Printf.printf "%d" sum;
                                    (Printf.printf "%s" "\n";
                                    ()))) in
                                   (e f n sum)) 1 n))) 0);;

