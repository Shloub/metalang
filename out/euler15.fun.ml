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

let main =
  let n = 10 in
  (*  normalement on doit mettre 20 mais là on se tape un overflow  *)
  let n = (n + 1) in
  let tab = (Array.init_withenv n (fun  i () -> let tab2 = (Array.init_withenv n (fun  j () -> let b = 0 in
  ((), b)) ()) in
  let a = tab2 in
  ((), a)) ()) in
  let z = 0 in
  let ba = (n - 1) in
  let rec y l =
    (if (l <= ba)
     then (
            tab.((n - 1)).(l) <- 1;
            tab.(l).((n - 1)) <- 1;
            (y (l + 1))
            )
     
     else let w = 2 in
     let x = n in
     let rec s o =
       (if (o <= x)
        then let r = (n - o) in
        let u = 2 in
        let v = n in
        let rec t p =
          (if (p <= v)
           then let q = (n - p) in
           (
             tab.(r).(q) <- (tab.((r + 1)).(q) + tab.(r).((q + 1)));
             (t (p + 1))
             )
           
           else (s (o + 1))) in
          (t u)
        else let g = 0 in
        let h = (n - 1) in
        let rec c m =
          (if (m <= h)
           then let e = 0 in
           let f = (n - 1) in
           let rec d k =
             (if (k <= f)
              then (
                     (Printf.printf "%d" tab.(m).(k));
                     (Printf.printf "%s" " ");
                     (d (k + 1))
                     )
              
              else (
                     (Printf.printf "%s" "\n");
                     (c (m + 1))
                     )
              ) in
             (d e)
           else (
                  (Printf.printf "%d" tab.(0).(0));
                  (Printf.printf "%s" "\n")
                  )
           ) in
          (c g)) in
       (s w)) in
    (y z)

