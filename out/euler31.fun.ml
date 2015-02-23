module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let rec result sum t maxIndex cache =
  (if (cache.(sum).(maxIndex) <> 0)
   then cache.(sum).(maxIndex)
   else (if ((sum = 0) || (maxIndex = 0))
         then 1
         else let out0 = 0 in
         let div = (sum / t.(maxIndex)) in
         let rec a i out0 =
           (if (i <= div)
            then let out0 = (out0 + (result (sum - (i * t.(maxIndex))) t (maxIndex - 1) cache)) in
            (a (i + 1) out0)
            else (
                   cache.(sum).(maxIndex) <- out0;
                   out0
                   )
            ) in
           (a 0 out0)))
let main =
  ((fun  (c, t) -> (
                     c;
                     t.(0) <- 1;
                     t.(1) <- 2;
                     t.(2) <- 5;
                     t.(3) <- 10;
                     t.(4) <- 20;
                     t.(5) <- 50;
                     t.(6) <- 100;
                     t.(7) <- 200;
                     ((fun  (e, cache) -> (
                                            e;
                                            (Printf.printf "%d" (result 200 t 7 cache))
                                            )
                     ) (Array.init_withenv 201 (fun  j () -> ((fun  (g, o) -> (
                                                                                g;
                                                                                let d = o in
                                                                                ((), d)
                                                                                )
                     ) (Array.init_withenv 8 (fun  k () -> let f = 0 in
                     ((), f)) ()))) ()))
                     )
  ) (Array.init_withenv 8 (fun  i () -> let b = 0 in
  ((), b)) ()))

