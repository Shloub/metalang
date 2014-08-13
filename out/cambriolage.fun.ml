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

let rec max2 =
  (fun a b ->
      let u = (fun a b ->
                  ()) in
      (if (a > b)
       then a
       else b));;
let rec nbPassePartout =
  (fun n passepartout m serrures ->
      let max_ancient = 0 in
      let max_recent = 0 in
      let s = 0 in
      let t = (m - 1) in
      let rec p i max_recent max_ancient n passepartout m serrures =
        (if (i <= t)
         then let r = (fun max_recent max_ancient n passepartout m serrures ->
                          let q = (fun max_recent max_ancient n passepartout m serrures ->
                                      (p (i + 1) max_recent max_ancient n passepartout m serrures)) in
                          (if ((serrures.(i).(0) = 1) && (serrures.(i).(1) > max_recent))
                           then let max_recent = serrures.(i).(1) in
                           (q max_recent max_ancient n passepartout m serrures)
                           else (q max_recent max_ancient n passepartout m serrures))) in
         (if ((serrures.(i).(0) = (- 1)) && (serrures.(i).(1) > max_ancient))
          then let max_ancient = serrures.(i).(1) in
          (r max_recent max_ancient n passepartout m serrures)
          else (r max_recent max_ancient n passepartout m serrures))
         else let max_ancient_pp = 0 in
         let max_recent_pp = 0 in
         let h = 0 in
         let o = (n - 1) in
         let rec f i max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures =
           (if (i <= o)
            then let pp = passepartout.(i) in
            let g = (fun pp max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures ->
                        let max_ancient_pp = (max2 max_ancient_pp pp.(0)) in
                        let max_recent_pp = (max2 max_recent_pp pp.(1)) in
                        (f (i + 1) max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures)) in
            (if ((pp.(0) >= max_ancient) && (pp.(1) >= max_recent))
             then 1
             else (g pp max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures))
            else let e = (fun max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures ->
                             ()) in
            (if ((max_ancient_pp >= max_ancient) && (max_recent_pp >= max_recent))
             then 2
             else 0)) in
           (f h max_recent_pp max_ancient_pp max_recent max_ancient n passepartout m serrures)) in
        (p s max_recent max_ancient n passepartout m serrures));;
let rec main =
  Scanf.scanf "%d"
  (fun n ->
      (Scanf.scanf "%[\n \010]" (fun _ -> let passepartout = (Array.init_withenv n (fun
       i n ->
      let c = 2 in
      let out0 = (Array.init_withenv c (fun j ->
                                           (fun (c, i, n) ->
                                               Scanf.scanf "%d"
                                               (fun out__ ->
                                                   (Scanf.scanf "%[\n \010]" (fun _ -> let w = out__ in
                                                   ((c, i, n), w)))))) (c, i, n)) in
      let v = out0 in
      (n, v)) n) in
      Scanf.scanf "%d"
      (fun m ->
          (Scanf.scanf "%[\n \010]" (fun _ -> let serrures = (Array.init_withenv m (fun
           k ->
          (fun (m, n) ->
              let d = 2 in
              let out1 = (Array.init_withenv d (fun l ->
                                                   (fun (d, k, m, n) ->
                                                       Scanf.scanf "%d"
                                                       (fun out_ ->
                                                           (Scanf.scanf "%[\n \010]" (fun _ -> let y = out_ in
                                                           ((d, k, m, n), y)))))) (d, k, m, n)) in
              let x = out1 in
              ((m, n), x))) (m, n)) in
          (Printf.printf "%d" (nbPassePartout n passepartout m serrures))))))));;

