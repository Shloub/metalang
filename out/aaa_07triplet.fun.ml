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

let main =
  let rec k i =
    (if (i <= 3)
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
                                            (k (i + 1))
                                            )
                               )
                               )
                  )
                  )
     )
     else ((fun  (g, l) -> let rec h j =
                             (if (j <= 9)
                              then (
                                     (Printf.printf "%d\n" l.(j));
                                     (h (j + 1))
                                     )
                              
                              else ()) in
                             (h 0)) (Array.init_withenv 10 (fun  d g -> Scanf.scanf "%d"
     (fun  e -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  let f = e in
                  ((), f)
                  )
     )) ()))) in
    (k 1)

