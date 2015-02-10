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
  let w = 1 in
  let x = 3 in
  let rec v i =
    (if (i <= x)
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
                                            (v (i + 1))
                                            )
                               )
                               )
                  )
                  )
     )
     else let l = (Array.init_withenv 10 (fun  o () -> Scanf.scanf "%d"
     (fun  p -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  let q = p in
                  ((), q)
                  )
     )) ()) in
     let s = 0 in
     let u = 9 in
     let rec r j =
       (if (j <= u)
        then (
               (Printf.printf "%d\n" l.(j));
               (r (j + 1))
               )
        
        else ()) in
       (r s)) in
    (v w)

