let main =
  let n = 10 in
  (*  normalement on doit mettre 20 mais là on se tape un overflow  *)
  let n = (n + 1) in
  let tab = (Array.init n (fun  i -> let tab2 = (Array.init n (fun  j -> 0)) in
  tab2)) in
  let rec g l =
    (if (l <= (n - 1))
     then (
            tab.((n - 1)).(l) <- 1;
            tab.(l).((n - 1)) <- 1;
            (g (l + 1))
            )
     
     else let rec e o =
            (if (o <= n)
             then let r = (n - o) in
             let rec f p =
               (if (p <= n)
                then let q = (n - p) in
                (
                  tab.(r).(q) <- (tab.((r + 1)).(q) + tab.(r).((q + 1)));
                  (f (p + 1))
                  )
                
                else (e (o + 1))) in
               (f 2)
             else let rec c m =
                    (if (m <= (n - 1))
                     then let rec d k =
                            (if (k <= (n - 1))
                             then (
                                    (Printf.printf "%d " tab.(m).(k));
                                    (d (k + 1))
                                    )
                             
                             else (
                                    (Printf.printf "\n");
                                    (c (m + 1))
                                    )
                             ) in
                            (d 0)
                     else (Printf.printf "%d\n" tab.(0).(0))) in
                    (c 0)) in
            (e 2)) in
    (g 0)

