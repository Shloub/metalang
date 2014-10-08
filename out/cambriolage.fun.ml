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

let nbPassePartout n passepartout m serrures =
  let max_ancient = 0 in
  let max_recent = 0 in
  let r = 0 in
  let s = (m - 1) in
  let rec q i max_ancient max_recent =
    (if (i <= s)
     then let max_ancient = (if ((serrures.(i).(0) = (- 1)) && (serrures.(i).(1) > max_ancient))
                             then let max_ancient = serrures.(i).(1) in
                             max_ancient
                             else max_ancient) in
     let max_recent = (if ((serrures.(i).(0) = 1) && (serrures.(i).(1) > max_recent))
                       then let max_recent = serrures.(i).(1) in
                       max_recent
                       else max_recent) in
     (q (i + 1) max_ancient max_recent)
     else let max_ancient_pp = 0 in
     let max_recent_pp = 0 in
     let o = 0 in
     let p = (n - 1) in
     let rec h i max_ancient_pp max_recent_pp =
       (if (i <= p)
        then let pp = passepartout.(i) in
        (if ((pp.(0) >= max_ancient) && (pp.(1) >= max_recent))
         then 1
         else let max_ancient_pp = ((max (max_ancient_pp) (pp.(0)))) in
         let max_recent_pp = ((max (max_recent_pp) (pp.(1)))) in
         (h (i + 1) max_ancient_pp max_recent_pp))
        else let g () = () in
        (if ((max_ancient_pp >= max_ancient) && (max_recent_pp >= max_recent))
         then 2
         else 0)) in
       (h o max_ancient_pp max_recent_pp)) in
    (q r max_ancient max_recent)
let main =
  Scanf.scanf "%d"
  (fun  n -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let passepartout = (Array.init_withenv n (fun  i () -> let out0 = (Array.init_withenv 2 (fun  j () -> Scanf.scanf "%d"
               (fun  out01 -> (
                                (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                let u = out01 in
                                ((), u)
                                )
               )) ()) in
               let t = out0 in
               ((), t)) ()) in
               Scanf.scanf "%d"
               (fun  m -> (
                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                            let serrures = (Array.init_withenv m (fun  k () -> let out1 = (Array.init_withenv 2 (fun  l () -> Scanf.scanf "%d"
                            (fun  out_ -> (
                                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                            let w = out_ in
                                            ((), w)
                                            )
                            )) ()) in
                            let v = out1 in
                            ((), v)) ()) in
                            (Printf.printf "%d" (nbPassePartout n passepartout m serrures))
                            )
               )
               )
  )

