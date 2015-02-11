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

let main =
  let o = 1 in
  let p = 3 in
  let rec m i =
    (if (i <= p)
     then Scanf.scanf "%d"
     (fun  a -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  Scanf.scanf "%d"
                  (fun  b -> (
                               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                               Scanf.scanf "%d"
                               (fun  c -> (
                                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                            (Printf.printf "a = %d b = %dc =%d\n" a b c);
                                            (m (i + 1))
                                            )
                               )
                               )
                  )
                  )
     )
     else let l = (Array.init_withenv 10 (fun  d () -> Scanf.scanf "%d"
     (fun  e -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  let f = e in
                  ((), f)
                  )
     )) ()) in
     let h = 0 in
     let k = 9 in
     let rec g j =
       (if (j <= k)
        then (
               (Printf.printf "%d\n" l.(j));
               (g (j + 1))
               )
        
        else ()) in
       (g h)) in
    (m o)

