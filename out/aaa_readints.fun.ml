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
    ((fun  (h, tab1) -> (
                          h;
                          let v = (len - 1) in
                          let rec u i =
                            (if (i <= v)
                             then (
                                    (Printf.printf "%d=>%d\n" i tab1.(i));
                                    (u (i + 1))
                                    )
                             
                             else let len = (Scanf.scanf "%d " (fun x -> x)) in
                             ((fun  (l, tab2) -> (
                                                   l;
                                                   let s = (len - 2) in
                                                   let rec p i =
                                                     (if (i <= s)
                                                      then let r = (len - 1) in
                                                      let rec q j =
                                                        (if (j <= r)
                                                         then (
                                                                (Printf.printf "%d " tab2.(i).(j));
                                                                (q (j + 1))
                                                                )
                                                         
                                                         else (
                                                                (Printf.printf "\n" );
                                                                (p (i + 1))
                                                                )
                                                         ) in
                                                        (q 0)
                                                      else ()) in
                                                     (p 0)
                                                   )
                             ) (Array.init_withenv (len - 1) (fun  c () -> ((fun  (o, e) -> 
                             (
                               o;
                               let k = e in
                               ((), k)
                               )
                             ) (Array.init_withenv len (fun  f () -> Scanf.scanf "%d"
                             (fun  d -> (
                                          (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                          let m = d in
                                          ((), m)
                                          )
                             )) ()))) ()))) in
                            (u 0)
                          )
    ) (Array.init_withenv len (fun  a () -> Scanf.scanf "%d"
    (fun  b -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let g = b in
                 ((), g)
                 )
    )) ()))
    )
  

