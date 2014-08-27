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

let read_int_matrix x y =
  let tab = (Array.init_withenv y (fun  z () -> let b = (Array.init_withenv x (fun  c () -> Scanf.scanf "%d"
  (fun  d -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let o = d in
               ((), o)
               )
  )) ()) in
  let m = b in
  ((), m)) ()) in
  tab
let main =
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d=len\n" len);
    let g = (Array.init_withenv len (fun  h () -> Scanf.scanf "%d"
    (fun  k -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let p = k in
                 ((), p)
                 )
    )) ()) in
    let tab1 = g in
    let bb = 0 in
    let bc = (len - 1) in
    let rec ba i =
      (if (i <= bc)
       then (
              (Printf.printf "%d=>%d\n" i tab1.(i));
              (ba (i + 1))
              )
       
       else let len = (Scanf.scanf "%d " (fun x -> x)) in
       let tab2 = (read_int_matrix len (len - 1)) in
       let v = 0 in
       let w = (len - 2) in
       let rec q i =
         (if (i <= w)
          then let s = 0 in
          let u = (len - 1) in
          let rec r j =
            (if (j <= u)
             then (
                    (Printf.printf "%d " tab2.(i).(j));
                    (r (j + 1))
                    )
             
             else (
                    (Printf.printf "\n" );
                    (q (i + 1))
                    )
             ) in
            (r s)
          else ()) in
         (q v)) in
      (ba bb)
    )
  

