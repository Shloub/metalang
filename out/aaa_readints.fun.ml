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
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d=len\n" len);
    ((fun  (h, tab1) -> let v = (len - 1) in
    let rec u i =
      (if (i <= v)
       then (
              (Printf.printf "%d=>%d\n" i tab1.(i));
              (u (i + 1))
              )
       
       else let len = (Scanf.scanf "%d " (fun x -> x)) in
       ((fun  (l, tab2) -> let q = (len - 2) in
       let rec m i =
         (if (i <= q)
          then let p = (len - 1) in
          let rec o j =
            (if (j <= p)
             then (
                    (Printf.printf "%d " tab2.(i).(j));
                    (o (j + 1))
                    )
             
             else (
                    (Printf.printf "\n" );
                    (m (i + 1))
                    )
             ) in
            (o 0)
          else ()) in
         (m 0)) (Array.init_withenv (len - 1) (fun  c l -> ((fun  (s, e) -> let k = e in
       ((), k)) (Array.init_withenv len (fun  f s -> Scanf.scanf "%d"
       (fun  d -> (
                    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                    let r = d in
                    ((), r)
                    )
       )) ()))) ()))) in
      (u 0)) (Array.init_withenv len (fun  a h -> Scanf.scanf "%d"
    (fun  b -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let g = b in
                 ((), g)
                 )
    )) ()))
    )
  

