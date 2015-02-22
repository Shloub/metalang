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
                          let ba = 0 in
                          let bb = (len - 1) in
                          let rec w i =
                            (if (i <= bb)
                             then (
                                    (Printf.printf "%d=>%d\n" i tab1.(i));
                                    (w (i + 1))
                                    )
                             
                             else let len = (Scanf.scanf "%d " (fun x -> x)) in
                             ((fun  (l, tab2) -> (
                                                   l;
                                                   let u = 0 in
                                                   let v = (len - 2) in
                                                   let rec p i =
                                                     (if (i <= v)
                                                      then let r = 0 in
                                                      let s = (len - 1) in
                                                      let rec q j =
                                                        (if (j <= s)
                                                         then (
                                                                (Printf.printf "%d " tab2.(i).(j));
                                                                (q (j + 1))
                                                                )
                                                         
                                                         else (
                                                                (Printf.printf "\n" );
                                                                (p (i + 1))
                                                                )
                                                         ) in
                                                        (q r)
                                                      else ()) in
                                                     (p u)
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
                            (w ba)
                          )
    ) (Array.init_withenv len (fun  a () -> Scanf.scanf "%d"
    (fun  b -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let g = b in
                 ((), g)
                 )
    )) ()))
    )
  

