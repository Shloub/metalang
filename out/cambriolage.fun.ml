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
  let h = 0 in
  let o = (m - 1) in
  let rec g i max_ancient max_recent =
    (if (i <= o)
     then let max_ancient = (if ((serrures.(i).(0) = (- 1)) && (serrures.(i).(1) > max_ancient))
                             then let max_ancient = serrures.(i).(1) in
                             max_ancient
                             else max_ancient) in
     let max_recent = (if ((serrures.(i).(0) = 1) && (serrures.(i).(1) > max_recent))
                       then let max_recent = serrures.(i).(1) in
                       max_recent
                       else max_recent) in
     (g (i + 1) max_ancient max_recent)
     else let max_ancient_pp = 0 in
     let max_recent_pp = 0 in
     let e = 0 in
     let f = (n - 1) in
     let rec d i max_ancient_pp max_recent_pp =
       (if (i <= f)
        then let pp = passepartout.(i) in
        (if ((pp.(0) >= max_ancient) && (pp.(1) >= max_recent))
         then 1
         else let max_ancient_pp = ((max (max_ancient_pp) (pp.(0)))) in
         let max_recent_pp = ((max (max_recent_pp) (pp.(1)))) in
         (d (i + 1) max_ancient_pp max_recent_pp))
        else let c () = () in
        (if ((max_ancient_pp >= max_ancient) && (max_recent_pp >= max_recent))
         then 2
         else 0)) in
       (d e max_ancient_pp max_recent_pp)) in
    (g h max_ancient max_recent)
let main =
  Scanf.scanf "%d"
  (fun  n -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               ((fun  (q, passepartout) -> (
                                             q;
                                             Scanf.scanf "%d"
                                             (fun  m -> (
                                                          (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                                          ((fun  (u, serrures) -> 
                                                          (
                                                            u;
                                                            (Printf.printf "%d" (nbPassePartout n passepartout m serrures))
                                                            )
                                                          ) (Array.init_withenv m (fun  k () -> ((fun  (w, out1) -> 
                                                          (
                                                            w;
                                                            let t = out1 in
                                                            ((), t)
                                                            )
                                                          ) (Array.init_withenv 2 (fun  l () -> Scanf.scanf "%d"
                                                          (fun  out_ -> 
                                                          (
                                                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                                            let v = out_ in
                                                            ((), v)
                                                            )
                                                          )) ()))) ()))
                                                          )
                                             )
                                             )
               ) (Array.init_withenv n (fun  i () -> ((fun  (s, out0) -> 
               (
                 s;
                 let p = out0 in
                 ((), p)
                 )
               ) (Array.init_withenv 2 (fun  j () -> Scanf.scanf "%d"
               (fun  out01 -> (
                                (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                let r = out01 in
                                ((), r)
                                )
               )) ()))) ()))
               )
  )

