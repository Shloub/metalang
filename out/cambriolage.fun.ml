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

let max2 a b =
  let r () = () in
  (if (a > b)
   then a
   else b)
let nbPassePartout n passepartout m serrures =
  let max_ancient = 0 in
  let max_recent = 0 in
  let p = 0 in
  let q = (m - 1) in
  let rec o i max_ancient max_recent =
    (if (i <= q)
     then let max_ancient = (if ((serrures.(i).(0) = (- 1)) && (serrures.(i).(1) > max_ancient))
                             then let max_ancient = serrures.(i).(1) in
                             max_ancient
                             else max_ancient) in
     let max_recent = (if ((serrures.(i).(0) = 1) && (serrures.(i).(1) > max_recent))
                       then let max_recent = serrures.(i).(1) in
                       max_recent
                       else max_recent) in
     (o (i + 1) max_ancient max_recent)
     else let max_ancient_pp = 0 in
     let max_recent_pp = 0 in
     let g = 0 in
     let h = (n - 1) in
     let rec f i max_ancient_pp max_recent_pp =
       (if (i <= h)
        then let pp = passepartout.(i) in
        (if ((pp.(0) >= max_ancient) && (pp.(1) >= max_recent))
         then 1
         else let max_ancient_pp = (max2 max_ancient_pp pp.(0)) in
         let max_recent_pp = (max2 max_recent_pp pp.(1)) in
         (f (i + 1) max_ancient_pp max_recent_pp))
        else let e () = () in
        (if ((max_ancient_pp >= max_ancient) && (max_recent_pp >= max_recent))
         then 2
         else 0)) in
       (f g max_ancient_pp max_recent_pp)) in
    (o p max_ancient max_recent)
let main =
  Scanf.scanf "%d"
  (fun  n -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let passepartout = (Array.init_withenv n (fun  i () -> let c = 2 in
               let out0 = (Array.init_withenv c (fun  j () -> Scanf.scanf "%d"
               (fun  out__ -> (
                                (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                let t = out__ in
                                ((), t)
                                )
               )) ()) in
               let s = out0 in
               ((), s)) ()) in
               Scanf.scanf "%d"
               (fun  m -> (
                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                            let serrures = (Array.init_withenv m (fun  k () -> let d = 2 in
                            let out1 = (Array.init_withenv d (fun  l () -> Scanf.scanf "%d"
                            (fun  out_ -> (
                                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                            let v = out_ in
                                            ((), v)
                                            )
                            )) ()) in
                            let u = out1 in
                            ((), u)) ()) in
                            (Printf.printf "%d" (nbPassePartout n passepartout m serrures))
                            )
               )
               )
  )

