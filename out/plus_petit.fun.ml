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

let rec go0 tab a b =
  let m = ((a + b) / 2) in
  (if (a = m)
   then let f () = let i = a in
   let j = b in
   let rec d i j =
     (if (i < j)
      then let e = tab.(i) in
      ((fun  (i, j) -> (d i j)) (if (e < m)
                                 then let i = (i + 1) in
                                 (i, j)
                                 else let j = (j - 1) in
                                 (
                                   tab.(i) <- tab.(j);
                                   tab.(j) <- e;
                                   (i, j)
                                   )
                                 ))
      else let c () = () in
      (if (i < m)
       then (go0 tab a m)
       else (go0 tab m b))) in
     (d i j) in
   (if (tab.(a) = m)
    then b
    else a)
   else let i = a in
   let j = b in
   let rec d i j =
     (if (i < j)
      then let e = tab.(i) in
      ((fun  (i, j) -> (d i j)) (if (e < m)
                                 then let i = (i + 1) in
                                 (i, j)
                                 else let j = (j - 1) in
                                 (
                                   tab.(i) <- tab.(j);
                                   tab.(j) <- e;
                                   (i, j)
                                   )
                                 ))
      else let c () = () in
      (if (i < m)
       then (go0 tab a m)
       else (go0 tab m b))) in
     (d i j))
let plus_petit0 tab len =
  (go0 tab 0 len)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  k -> let len = k in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init_withenv len (fun  i () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  h -> let tmp = h in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let g = tmp in
      ((), g)
      )
    )) ()) in
    (Printf.printf "%d" (plus_petit0 tab len))
    )
  )

