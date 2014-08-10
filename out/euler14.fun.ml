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

let rec next_ =
  (fun n ->
      ((fun e ->
           (if ((n mod 2) = 0)
            then (n / 2)
            else ((3 * n) + 1))) (fun n ->
                                     ())));;
let rec find =
  (fun n m ->
      ((fun b ->
           (if (n = 1)
            then 1
            else ((fun c ->
                      (if (n >= 1000000)
                       then (1 + (find (next_ n) m))
                       else ((fun d ->
                                 (if (m.(n) <> 0)
                                  then m.(n)
                                  else (m.(n) <- (1 + (find (next_ n) m)); m.(n)))) (fun
                        n m ->
                       (c n m))))) (fun n m ->
                                       (b n m))))) (fun n m ->
                                                       ())));;
let rec main =
  ((fun a ->
       ((fun m ->
            ((fun max_ ->
                 ((fun maxi ->
                      ((fun k l ->
                           let rec g i maxi max_ a =
                             (if (i <= l)
                              then (*  normalement on met 999999 mais ça dépasse les int32...  *)
                              ((fun n2 ->
                                   ((fun h ->
                                        (if (n2 > max_)
                                         then ((fun max_ ->
                                                   ((fun maxi ->
                                                        (h n2 maxi max_ a)) i)) n2)
                                         else (h n2 maxi max_ a))) (fun
                                    n2 maxi max_ a ->
                                   (g (i + 1) maxi max_ a)))) (find i m))
                              else (Printf.printf "%d" max_;
                              (Printf.printf "%s" "\n";
                              (Printf.printf "%d" maxi;
                              (Printf.printf "%s" "\n";
                              ()))))) in
                             (g k maxi max_ a)) 1 999)) 0)) 0)) ((Array.init_withenv a (fun
        j ->
       (fun (a) ->
           ((fun f ->
                ((a), f)) 0))) ) (a)))) 1000000);;

