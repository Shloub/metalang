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
  let rec h i =
    (if (i <= 3)
     then Scanf.scanf "%d"
     (fun  a -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  Scanf.scanf "%d"
                  (fun  b -> (
                               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                               (Printf.printf "a = %d b = %d\n" a b);
                               (h (i + 1))
                               )
                  )
                  )
     )
     else ((fun  (f, l) -> let rec g j =
                             (if (j <= 9)
                              then (
                                     (Printf.printf "%d\n" l.(j));
                                     (g (j + 1))
                                     )
                              
                              else ()) in
                             (g 0)) (Array.init_withenv 10 (fun  c f -> Scanf.scanf "%d"
     (fun  d -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  let e = d in
                  ((), e)
                  )
     )) ()))) in
    (h 1)

