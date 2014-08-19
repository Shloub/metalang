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

let rec pathfind_aux cache tab len pos =
  let b () = () in
  (if (pos >= (len - 1))
   then 0
   else let c () = (b ()) in
   (if (cache.(pos) <> (- 1))
    then cache.(pos)
    else (
           cache.(pos) <- (len * 2);
           let posval = (pathfind_aux cache tab len tab.(pos)) in
           let oneval = (pathfind_aux cache tab len (pos + 1)) in
           let out_ = 0 in
           let out_ = (if (posval < oneval)
                       then let out_ = (1 + posval) in
                       out_
                       else let out_ = (1 + oneval) in
                       out_) in
           (
             cache.(pos) <- out_;
             out_
             )
           
           )
    ))
let pathfind tab len =
  let cache = (Array.init_withenv len (fun  i () -> let a = (- 1) in
  ((), a)) ()) in
  (pathfind_aux cache tab len 0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  f -> let len = f in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init_withenv len (fun  i () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  e -> let tmp = e in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let d = tmp in
      ((), d)
      )
    )) ()) in
    let result = (pathfind tab len) in
    (Printf.printf "%d" result)
    )
  )

