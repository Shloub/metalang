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

let nbPassePartout n passepartout m serrures =
  let max_ancient = 0 in
  let max_recent = 0 in
  let f = (m - 1) in
  let rec e i max_ancient max_recent =
    (if (i <= f)
     then let max_ancient = (if ((serrures.(i).(0) = (- 1)) && (serrures.(i).(1) > max_ancient))
                             then let max_ancient = serrures.(i).(1) in
                             max_ancient
                             else max_ancient) in
     (if ((serrures.(i).(0) = 1) && (serrures.(i).(1) > max_recent))
      then let max_recent = serrures.(i).(1) in
      (e (i + 1) max_ancient max_recent)
      else (e (i + 1) max_ancient max_recent))
     else let max_ancient_pp = 0 in
     let max_recent_pp = 0 in
     let d = (n - 1) in
     let rec c i max_ancient_pp max_recent_pp =
       (if (i <= d)
        then let pp = passepartout.(i) in
        (if ((pp.(0) >= max_ancient) && (pp.(1) >= max_recent))
         then 1
         else let max_ancient_pp = ((max (max_ancient_pp) (pp.(0)))) in
         let max_recent_pp = ((max (max_recent_pp) (pp.(1)))) in
         (c (i + 1) max_ancient_pp max_recent_pp))
        else (if ((max_ancient_pp >= max_ancient) && (max_recent_pp >= max_recent))
              then 2
              else 0)) in
       (c 0 max_ancient_pp max_recent_pp)) in
    (e 0 max_ancient max_recent)
let main =
  Scanf.scanf "%d"
  (fun  n -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               ((fun  (h, passepartout) -> (
                                             h;
                                             Scanf.scanf "%d"
                                             (fun  m -> (
                                                          (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                                          ((fun  (r, serrures) -> 
                                                          (
                                                            r;
                                                            (Printf.printf "%d" (nbPassePartout n passepartout m serrures))
                                                            )
                                                          ) (Array.init_withenv m (fun  k () -> ((fun  (t, out1) -> 
                                                          (
                                                            t;
                                                            let q = out1 in
                                                            ((), q)
                                                            )
                                                          ) (Array.init_withenv 2 (fun  l () -> Scanf.scanf "%d"
                                                          (fun  out_ -> (
                                                                          (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                                                          let s = out_ in
                                                                          ((), s)
                                                                          )
                                                          )) ()))) ()))
                                                          )
                                             )
                                             )
               ) (Array.init_withenv n (fun  i () -> ((fun  (p, out0) -> (
                                                                           p;
                                                                           let g = out0 in
                                                                           ((), g)
                                                                           )
               ) (Array.init_withenv 2 (fun  j () -> Scanf.scanf "%d"
               (fun  out01 -> (
                                (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                let o = out01 in
                                ((), o)
                                )
               )) ()))) ()))
               )
  )

