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

let rec fibo_ =
  (fun a b i ->
      ((fun out_ ->
           ((fun a2 ->
                ((fun b2 ->
                     ((fun d e ->
                          let rec c j b2 a2 out_ a b i =
                            (if (j <= e)
                             then ((fun out_ ->
                                       ((fun tmp ->
                                            ((fun b2 ->
                                                 ((fun a2 ->
                                                      (c (j + 1) b2 a2 out_ a b i)) tmp)) (b2 + a2))) b2)) (out_ + a2))
                             else out_) in
                            (c d b2 a2 out_ a b i)) 0 (i + 1))) b)) a)) 0));;
let rec main =
  ((fun a ->
       ((fun b ->
            ((fun i ->
                 Scanf.scanf "%d" (fun h ->
                                      ((fun a ->
                                           (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                                            g ->
                                           ((fun b ->
                                                (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                                                 f ->
                                                ((fun i ->
                                                     (Printf.printf "%d" (fibo_ a b i);
                                                     ())) f))))) g))))) h))) 0)) 0)) 0);;

