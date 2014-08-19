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

let rec go_ tab a b =
  let m = ((a + b) / 2) in
  (if (a = m)
   then let g () = let i = a in
   let j = b in
   let rec f i j =
     (if (i < j)
      then let e = tab.(i) in
      ((fun  (i, j) -> (f i j)) (if (e < m)
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
       then (go_ tab a m)
       else (go_ tab m b))) in
     (f i j) in
   (if (tab.(a) = m)
    then b
    else a)
   else let i = a in
   let j = b in
   let rec f i j =
     (if (i < j)
      then let e = tab.(i) in
      ((fun  (i, j) -> (f i j)) (if (e < m)
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
       then (go_ tab a m)
       else (go_ tab m b))) in
     (f i j))
let plus_petit_ tab len =
  (go_ tab 0 len)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  l -> let len = l in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init_withenv len (fun  i () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  k -> let tmp = k in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let h = tmp in
      ((), h)
      )
    )) ()) in
    (Printf.printf "%d" (plus_petit_ tab len))
    )
  )

