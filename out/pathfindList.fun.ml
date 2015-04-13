let rec pathfind_aux cache tab len pos =
  (if (pos >= (len - 1))
   then 0
   else (if (cache.(pos) <> (- 1))
         then cache.(pos)
         else (
                cache.(pos) <- (len * 2);
                let posval = (pathfind_aux cache tab len tab.(pos)) in
                let oneval = (pathfind_aux cache tab len (pos + 1)) in
                let out0 = 0 in
                let out0 = (if (posval < oneval)
                            then (1 + posval)
                            else (1 + oneval)) in
                (
                  cache.(pos) <- out0;
                  out0
                  )
                
                )
         ))
let pathfind tab len =
  let cache = (Array.init len (fun  i -> (- 1))) in
  (pathfind_aux cache tab len 0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  a -> let len = a in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init len (fun  i -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  b -> let tmp = b in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      tmp
      )
    ))) in
    let result = (pathfind tab len) in
    (Printf.printf "%d" result)
    )
  )

