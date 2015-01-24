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
    let tab1 = (Array.init_withenv len (fun  h () -> Scanf.scanf "%d"
    (fun  k -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let w = k in
                 ((), w)
                 )
    )) ()) in
    let bj = 0 in
    let bk = (len - 1) in
    let rec bi i =
      (if (i <= bk)
       then (
              (Printf.printf "%d=>%d\n" i tab1.(i));
              (bi (i + 1))
              )
       
       else let len = (Scanf.scanf "%d " (fun x -> x)) in
       let tab2 = (Array.init_withenv (len - 1) (fun  q () -> let v = (Array.init_withenv len (fun  s () -> Scanf.scanf "%d"
       (fun  u -> (
                    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                    let bb = u in
                    ((), bb)
                    )
       )) ()) in
       let ba = v in
       ((), ba)) ()) in
       let bg = 0 in
       let bh = (len - 2) in
       let rec bc i =
         (if (i <= bh)
          then let be = 0 in
          let bf = (len - 1) in
          let rec bd j =
            (if (j <= bf)
             then (
                    (Printf.printf "%d " tab2.(i).(j));
                    (bd (j + 1))
                    )
             
             else (
                    (Printf.printf "\n" );
                    (bc (i + 1))
                    )
             ) in
            (bd be)
          else ()) in
         (bc bg)) in
      (bi bj)
    )
  

