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
  ((fun a ->
       ((fun b ->
            ((fun sum ->
                 let rec e sum b a =
                   (if (a < 4000000)
                    then ((fun f ->
                              (if ((a mod 2) = 0)
                               then ((fun sum ->
                                         (f sum b a)) (sum + a))
                               else (f sum b a))) (fun sum b a ->
                                                      ((fun c ->
                                                           ((fun a ->
                                                                ((fun
                                                                 b ->
                                                                (e sum b a)) (b + c))) b)) a)))
                    else (Printf.printf "%d" sum;
                    (Printf.printf "%s" "\n";
                    ()))) in
                   (e sum b a)) 0)) 2)) 1);;

