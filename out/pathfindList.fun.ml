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
                            then let out0 = (1 + posval) in
                            out0
                            else let out0 = (1 + oneval) in
                            out0) in
                (
                  cache.(pos) <- out0;
                  out0
                  )
                
                )
         ))
let pathfind tab len =
  ((fun  (b, cache) -> (
                         b;
                         (pathfind_aux cache tab len 0)
                         )
  ) (Array.init_withenv len (fun  i () -> let a = (- 1) in
  ((), a)) ()))
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  f -> let len = f in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    ((fun  (d, tab) -> (
                         d;
                         let result = (pathfind tab len) in
                         (Printf.printf "%d" result)
                         )
    ) (Array.init_withenv len (fun  i () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  e -> let tmp = e in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let c = tmp in
      ((), c)
      )
    )) ()))
    )
  )

