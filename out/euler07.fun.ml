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

let rec divisible =
  (fun n t size ->
      ((fun f g ->
           let rec d i n t size =
             (if (i <= g)
              then ((fun e ->
                        (if ((n mod t.(i)) = 0)
                         then true
                         else (e n t size))) (fun n t size ->
                                                 (d (i + 1) n t size)))
              else false) in
             (d f n t size)) 0 (size - 1)));;
let rec find =
  (fun n t used nth ->
      let rec b n t used nth =
        (if (used <> nth)
         then ((fun c ->
                   (if (divisible n t used)
                    then ((fun n ->
                              (c n t used nth)) (n + 1))
                    else (t.(used) <- n; ((fun n ->
                                              ((fun used ->
                                                   (c n t used nth)) (used + 1))) (n + 1))))) (fun
          n t used nth ->
         (b n t used nth)))
         else t.((used - 1))) in
        (b n t used nth));;
let rec main =
  ((fun n ->
       ((fun t ->
            (Printf.printf "%d" (find 3 t 1 n);
            (Printf.printf "%s" "\n";
            ()))) ((Array.init_withenv n (fun i ->
                                             (fun (n) ->
                                                 ((fun h ->
                                                      ((n), h)) 2))) ) (n)))) 10001);;

