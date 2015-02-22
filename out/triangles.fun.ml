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
  let e () = let result = 0 in
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
   in
  (if (y = (len - 1))
   then tab.(y).(x)
   else let f () = (e ()) in
   (if (x > y)
    then (- 10000)
    else (if (cache.(y).(x) <> 0)
          then cache.(y).(x)
          else (f ()))))
let find len tab =
  ((fun  (b, tab2) -> (
                        b;
                        (find0 len tab tab2 0 0)
                        )
  ) (Array.init_withenv len (fun  i () -> ((fun  (d, tab3) -> (
                                                                d;
                                                                let a = tab3 in
                                                                ((), a)
                                                                )
  ) (Array.init_withenv (i + 1) (fun  j () -> let c = 0 in
  ((), c)) ()))) ()))
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  v -> let len = v in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    ((fun  (h, tab) -> (
                         h;
                         (Printf.printf "%d\n" (find len tab));
                         let t = 0 in
                         let u = (len - 1) in
                         let rec p k =
                           (if (k <= u)
                            then let r = 0 in
                            let s = k in
                            let rec q l =
                              (if (l <= s)
                               then (
                                      (Printf.printf "%d " tab.(k).(l));
                                      (q (l + 1))
                                      )
                               
                               else (
                                      (Printf.printf "\n" );
                                      (p (k + 1))
                                      )
                               ) in
                              (q r)
                            else ()) in
                           (p t)
                         )
    ) (Array.init_withenv len (fun  i () -> ((fun  (n, tab2) -> (
                                                                  n;
                                                                  let g = tab2 in
                                                                  ((), g)
                                                                  )
    ) (Array.init_withenv (i + 1) (fun  j () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  o -> let tmp = o in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let m = tmp in
      ((), m)
      )
    )) ()))) ()))
    )
  )

