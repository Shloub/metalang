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
  let p = 1 in
  let q = 3 in
  let rec o i =
    (if (i <= q)
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
                                            (o (i + 1))
                                            )
                               )
                               )
                  )
                  )
     )
     else ((fun  (g, l) -> (
                             g;
                             let k = 0 in
                             let m = 9 in
                             let rec h j =
                               (if (j <= m)
                                then (
                                       (Printf.printf "%d\n" l.(j));
                                       (h (j + 1))
                                       )
                                
                                else ()) in
                               (h k)
                             )
     ) (Array.init_withenv 10 (fun  d () -> Scanf.scanf "%d"
     (fun  e -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  let f = e in
                  ((), f)
                  )
     )) ()))) in
    (o p)

