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
  let tab2 = (Array.init_withenv len (fun  i () -> let a = (i + 1) in
  let tab3 = (Array.init_withenv a (fun  j () -> let d = 0 in
  ((), d)) ()) in
  let c = tab3 in
  ((), c)) ()) in
  (find0 len tab tab2 0 0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  t -> let len = t in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init_withenv len (fun  i () -> let b = (i + 1) in
    let tab2 = (Array.init_withenv b (fun  j () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  m -> let tmp = m in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let h = tmp in
      ((), h)
      )
    )) ()) in
    let g = tab2 in
    ((), g)) ()) in
    (
      (Printf.printf "%d\n" (find len tab));
      let r = 0 in
      let s = (len - 1) in
      let rec n k =
        (if (k <= s)
         then let p = 0 in
         let q = k in
         let rec o l =
           (if (l <= q)
            then (
                   (Printf.printf "%d " tab.(k).(l));
                   (o (l + 1))
                   )
            
            else (
                   (Printf.printf "\n" );
                   (n (k + 1))
                   )
            ) in
           (o p)
         else ()) in
        (n r)
      )
    
    )
  )

