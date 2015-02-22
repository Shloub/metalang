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

let main =
  let n = 10 in
  (*  normalement on doit mettre 20 mais là on se tape un overflow  *)
  let n = (n + 1) in
  ((fun  (b, tab) -> (
                       b;
                       let bb = 0 in
                       let bc = (n - 1) in
                       let rec ba l =
                         (if (l <= bc)
                          then (
                                 tab.((n - 1)).(l) <- 1;
                                 tab.(l).((n - 1)) <- 1;
                                 (ba (l + 1))
                                 )
                          
                          else let y = 2 in
                          let z = n in
                          let rec u o =
                            (if (o <= z)
                             then let r = (n - o) in
                             let w = 2 in
                             let x = n in
                             let rec v p =
                               (if (p <= x)
                                then let q = (n - p) in
                                (
                                  tab.(r).(q) <- (tab.((r + 1)).(q) + tab.(r).((q + 1)));
                                  (v (p + 1))
                                  )
                                
                                else (u (o + 1))) in
                               (v w)
                             else let s = 0 in
                             let t = (n - 1) in
                             let rec e m =
                               (if (m <= t)
                                then let g = 0 in
                                let h = (n - 1) in
                                let rec f k =
                                  (if (k <= h)
                                   then (
                                          (Printf.printf "%d " tab.(m).(k));
                                          (f (k + 1))
                                          )
                                   
                                   else (
                                          (Printf.printf "\n" );
                                          (e (m + 1))
                                          )
                                   ) in
                                  (f g)
                                else (
                                       (Printf.printf "%d\n" tab.(0).(0))
                                       )
                                ) in
                               (e s)) in
                            (u y)) in
                         (ba bb)
                       )
  ) (Array.init_withenv n (fun  i () -> ((fun  (d, tab2) -> (
                                                              d;
                                                              let a = tab2 in
                                                              ((), a)
                                                              )
  ) (Array.init_withenv n (fun  j () -> let c = 0 in
  ((), c)) ()))) ()))

