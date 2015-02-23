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

let rec find0 len tab cache x y =
  (* 
	Cette fonction est récursive
	 *)
  (if (y = (len - 1))
   then tab.(y).(x)
   else (if (x > y)
         then (- 10000)
         else (if (cache.(y).(x) <> 0)
               then cache.(y).(x)
               else let result = 0 in
               let out0 = (find0 len tab cache x (y + 1)) in
               let out1 = (find0 len tab cache (x + 1) (y + 1)) in
               let result = (if (out0 > out1)
                             then let result = (out0 + tab.(y).(x)) in
                             result
                             else let result = (out1 + tab.(y).(x)) in
                             result) in
               (
                 cache.(y).(x) <- result;
                 result
                 )
               )))
let find len tab =
  ((fun  (b, tab2) -> (find0 len tab tab2 0 0)) (Array.init_withenv len (fun  i b -> ((fun  (d, tab3) -> let a = tab3 in
  ((), a)) (Array.init_withenv (i + 1) (fun  j d -> let c = 0 in
  ((), c)) ()))) ()))
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  q -> let len = q in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    ((fun  (f, tab) -> (
                         (Printf.printf "%d\n" (find len tab));
                         let m = (len - 1) in
                         let rec g k =
                           (if (k <= m)
                            then let rec h l =
                                   (if (l <= k)
                                    then (
                                           (Printf.printf "%d " tab.(k).(l));
                                           (h (l + 1))
                                           )
                                    
                                    else (
                                           (Printf.printf "\n" );
                                           (g (k + 1))
                                           )
                                    ) in
                                   (h 0)
                            else ()) in
                           (g 0)
                         )
    ) (Array.init_withenv len (fun  i f -> ((fun  (o, tab2) -> let e = tab2 in
    ((), e)) (Array.init_withenv (i + 1) (fun  j o -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  p -> let tmp = p in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let n = tmp in
      ((), n)
      )
    )) ()))) ()))
    )
  )

