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
  let m = 1 in
  let o = 3 in
  let rec k i =
    (if (i <= o)
     then Scanf.scanf "%d"
     (fun  a -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  Scanf.scanf "%d"
                  (fun  b -> (
                               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                               (Printf.printf "a = %d b = %d\n" a b);
                               (k (i + 1))
                               )
                  )
                  )
     )
     else let l = (Array.init_withenv 10 (fun  c () -> Scanf.scanf "%d"
     (fun  d -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  let e = d in
                  ((), e)
                  )
     )) ()) in
     let g = 0 in
     let h = 9 in
     let rec f j =
       (if (j <= h)
        then (
               (Printf.printf "%d\n" l.(j));
               (f (j + 1))
               )
        
        else ()) in
       (f g)) in
    (k m)

