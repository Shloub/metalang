let nbPassePartout n passepartout m serrures =
  let max_ancient = 0 in
  let max_recent = 0 in
  let rec c i max_ancient max_recent =
    if i <= m - 1
    then let max_ancient = if serrures.(i).(0) = - 1 && serrures.(i).(1) > max_ancient
                           then serrures.(i).(1)
                           else max_ancient in
    if serrures.(i).(0) = 1 && serrures.(i).(1) > max_recent
    then let max_recent = serrures.(i).(1) in
    c (i + 1) max_ancient max_recent
    else c (i + 1) max_ancient max_recent
    else let max_ancient_pp = 0 in
    let max_recent_pp = 0 in
    let rec d i max_ancient_pp max_recent_pp =
      if i <= n - 1
      then let pp = passepartout.(i) in
      if pp.(0) >= max_ancient && pp.(1) >= max_recent
      then 1
      else let max_ancient_pp = (max (max_ancient_pp) (pp.(0))) in
      let max_recent_pp = (max (max_recent_pp) (pp.(1))) in
      d (i + 1) max_ancient_pp max_recent_pp
      else if max_ancient_pp >= max_ancient && max_recent_pp >= max_recent
           then 2
           else 0 in
      d 0 max_ancient_pp max_recent_pp in
    c 0 max_ancient max_recent

let main =
  Scanf.scanf "%d"
  (fun n -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
              let passepartout = Array.init n (fun i -> Array.init 2 (fun j -> Scanf.scanf "%d"
              (fun out01 -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                              out01)))) in
              Scanf.scanf "%d"
              (fun m -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                          let serrures = Array.init m (fun k -> Array.init 2 (fun l -> Scanf.scanf "%d"
                          (fun out_ -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                                         out_)))) in
                          Printf.printf "%d" (nbPassePartout n passepartout m serrures)))))

