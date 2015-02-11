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
  let c () = let result = 0 in
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
   else let d () = (c ()) in
   (if (x > y)
    then (- 10000)
    else (if (cache.(y).(x) <> 0)
          then cache.(y).(x)
          else (d ()))))
let find len tab =
  let tab2 = (Array.init_withenv len (fun  i () -> let tab3 = (Array.init_withenv (i + 1) (fun  j () -> let b = 0 in
  ((), b)) ()) in
  let a = tab3 in
  ((), a)) ()) in
  (find0 len tab tab2 0 0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  r -> let len = r in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init_withenv len (fun  i () -> let tab2 = (Array.init_withenv (i + 1) (fun  j () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  g -> let tmp = g in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let f = tmp in
      ((), f)
      )
    )) ()) in
    let e = tab2 in
    ((), e)) ()) in
    (
      (Printf.printf "%d\n" (find len tab));
      let p = 0 in
      let q = (len - 1) in
      let rec h k =
        (if (k <= q)
         then let n = 0 in
         let o = k in
         let rec m l =
           (if (l <= o)
            then (
                   (Printf.printf "%d " tab.(k).(l));
                   (m (l + 1))
                   )
            
            else (
                   (Printf.printf "\n" );
                   (h (k + 1))
                   )
            ) in
           (m n)
         else ()) in
        (h p)
      )
    
    )
  )

