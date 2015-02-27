let main =
  let n = 10 in
  (*  normalement on doit mettre 20 mais là on se tape un overflow  *)
  let n = (n + 1) in
  let tab = (Array.init n (fun  i -> let tab2 = (Array.init n (fun  j -> 0)) in
  tab2)) in
  let t = (n - 1) in
  let rec s l =
    (if (l <= t)
     then (
            tab.((n - 1)).(l) <- 1;
            tab.(l).((n - 1)) <- 1;
            (s (l + 1))
            )
     
     else let rec g o =
            (if (o <= n)
             then let r = (n - o) in
             let rec h p =
               (if (p <= n)
                then let q = (n - p) in
                (
                  tab.(r).(q) <- (tab.((r + 1)).(q) + tab.(r).((q + 1)));
                  (h (p + 1))
                  )
                
                else (g (o + 1))) in
               (h 2)
             else let f = (n - 1) in
             let rec c m =
               (if (m <= f)
                then let e = (n - 1) in
                let rec d k =
                  (if (k <= e)
                   then (
                          (Printf.printf "%d " tab.(m).(k));
                          (d (k + 1))
                          )
                   
                   else (
                          (Printf.printf "\n" );
                          (c (m + 1))
                          )
                   ) in
                  (d 0)
                else (
                       (Printf.printf "%d\n" tab.(0).(0))
                       )
                ) in
               (c 0)) in
            (g 2)) in
    (s 0)

