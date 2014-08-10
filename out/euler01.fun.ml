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

let rec main =
  ((fun sum ->
       ((fun c d ->
            let rec a i sum =
              (if (i <= d)
               then ((fun b ->
                         (if (((i mod 3) = 0) || ((i mod 5) = 0))
                          then ((fun sum ->
                                    (b sum)) (sum + i))
                          else (b sum))) (fun sum ->
                                             (a (i + 1) sum)))
               else (Printf.printf "%d" sum;
               (Printf.printf "%s" "\n";
               ()))) in
              (a c sum)) 0 999)) 0);;

