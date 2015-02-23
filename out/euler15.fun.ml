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
                       let v = (n - 1) in
                       let rec u l =
                         (if (l <= v)
                          then (
                                 tab.((n - 1)).(l) <- 1;
                                 tab.(l).((n - 1)) <- 1;
                                 (u (l + 1))
                                 )
                          
                          else let rec s o =
                                 (if (o <= n)
                                  then let r = (n - o) in
                                  let rec t p =
                                    (if (p <= n)
                                     then let q = (n - p) in
                                     (
                                       tab.(r).(q) <- (tab.((r + 1)).(q) + tab.(r).((q + 1)));
                                       (t (p + 1))
                                       )
                                     
                                     else (s (o + 1))) in
                                    (t 2)
                                  else let h = (n - 1) in
                                  let rec e m =
                                    (if (m <= h)
                                     then let g = (n - 1) in
                                     let rec f k =
                                       (if (k <= g)
                                        then (
                                               (Printf.printf "%d " tab.(m).(k));
                                               (f (k + 1))
                                               )
                                        
                                        else (
                                               (Printf.printf "\n" );
                                               (e (m + 1))
                                               )
                                        ) in
                                       (f 0)
                                     else (
                                            (Printf.printf "%d\n" tab.(0).(0))
                                            )
                                     ) in
                                    (e 0)) in
                                 (s 2)) in
                         (u 0)
                       )
  ) (Array.init_withenv n (fun  i () -> ((fun  (d, tab2) -> (
                                                              d;
                                                              let a = tab2 in
                                                              ((), a)
                                                              )
  ) (Array.init_withenv n (fun  j () -> let c = 0 in
  ((), c)) ()))) ()))

