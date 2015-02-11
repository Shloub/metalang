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
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d=len\n" len);
    let tab1 = (Array.init_withenv len (fun  a () -> Scanf.scanf "%d"
    (fun  b -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let g = b in
                 ((), g)
                 )
    )) ()) in
    let u = 0 in
    let v = (len - 1) in
    let rec s i =
      (if (i <= v)
       then (
              (Printf.printf "%d=>%d\n" i tab1.(i));
              (s (i + 1))
              )
       
       else let len = (Scanf.scanf "%d " (fun x -> x)) in
       let tab2 = (Array.init_withenv (len - 1) (fun  c () -> let e = (Array.init_withenv len (fun  f () -> Scanf.scanf "%d"
       (fun  d -> (
                    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                    let k = d in
                    ((), k)
                    )
       )) ()) in
       let h = e in
       ((), h)) ()) in
       let q = 0 in
       let r = (len - 2) in
       let rec l i =
         (if (i <= r)
          then let o = 0 in
          let p = (len - 1) in
          let rec m j =
            (if (j <= p)
             then (
                    (Printf.printf "%d " tab2.(i).(j));
                    (m (j + 1))
                    )
             
             else (
                    (Printf.printf "\n" );
                    (l (i + 1))
                    )
             ) in
            (m o)
          else ()) in
         (l q)) in
      (s u)
    )
  

