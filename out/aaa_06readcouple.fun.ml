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
  let u = 1 in
  let v = 3 in
  let rec s i =
    (if (i <= v)
     then Scanf.scanf "%d"
     (fun  a -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  Scanf.scanf "%d"
                  (fun  b -> (
                               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                               (Printf.printf "a = %d b = %d\n" a b);
                               (s (i + 1))
                               )
                  )
                  )
     )
     else let l = (Array.init_withenv 10 (fun  k () -> Scanf.scanf "%d"
     (fun  m -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  let o = m in
                  ((), o)
                  )
     )) ()) in
     let q = 0 in
     let r = 9 in
     let rec p j =
       (if (j <= r)
        then (
               (Printf.printf "%d\n" l.(j));
               (p (j + 1))
               )
        
        else ()) in
       (p q)) in
    (s u)

