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

let rec exp_ =
  (fun a b ->
      ((fun d ->
           (if (b = 0)
            then 1
            else (d a b))) (fun a b ->
                               ((fun c ->
                                    (if ((b mod 2) = 0)
                                     then ((fun o ->
                                               (o * o)) (exp_ a (b / 2)))
                                     else (a * (exp_ a (b - 1))))) (fun
                                a b ->
                               ())))));;
let rec main =
  ((fun a ->
       ((fun b ->
            Scanf.scanf "%d" (fun f ->
                                 ((fun a ->
                                      (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                                       e ->
                                      ((fun b ->
                                           (Printf.printf "%d" (exp_ a b);
                                           ())) e))))) f))) 0)) 0);;

