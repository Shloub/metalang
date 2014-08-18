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

let max2 =
  (fun a b ->
      let h = (fun () -> ()) in
      (if (a > b)
       then a
       else b));;
let read_int_line =
  (fun n ->
      let tab = (Array.init_withenv n (fun i ->
                                          (fun () -> Scanf.scanf "%d"
                                          (fun t ->
                                              (Scanf.scanf "%[\n \010]" (fun _ -> let g = t in
                                              ((), g)))))) ()) in
      tab);;
let read_int_matrix =
  (fun x y ->
      let tab = (Array.init_withenv y (fun z ->
                                          (fun () -> let f = (read_int_line x) in
                                          ((), f))) ()) in
      tab);;
let rec find =
  (fun n m x y dx dy ->
      let d = (fun () -> ()) in
      (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
       then (- 1)
       else let e = (fun () -> (d ())) in
       (if (n = 0)
        then 1
        else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy)))));;
let main =
  let c = 8 in
  let directions = (Array.init_withenv c (fun i ->
                                             (fun () -> let l = (fun k ->
                                                                    ((), k)) in
                                             (if (i = 0)
                                              then let k = (0, 1) in
                                              ((), k)
                                              else let o = (fun () -> (l ())) in
                                              (if (i = 1)
                                               then let k = (1, 0) in
                                               ((), k)
                                               else let p = (fun () -> (o ())) in
                                               (if (i = 2)
                                                then let k = (0, (- 1)) in
                                                ((), k)
                                                else let q = (fun () -> (p ())) in
                                                (if (i = 3)
                                                 then let k = ((- 1), 0) in
                                                 ((), k)
                                                 else let r = (fun () -> (q ())) in
                                                 (if (i = 4)
                                                  then let k = (1, 1) in
                                                  ((), k)
                                                  else let s = (fun () -> (r ())) in
                                                  (if (i = 5)
                                                   then let k = (1, (- 1)) in
                                                   ((), k)
                                                   else let u = (fun () -> (s ())) in
                                                   (if (i = 6)
                                                    then let k = ((- 1), 1) in
                                                    ((), k)
                                                    else let k = ((- 1), (- 1)) in
                                                    ((), k)))))))))) ()) in
  let max_ = 0 in
  let m = (read_int_matrix 20 20) in
  let bf = 0 in
  let bg = 7 in
  let rec v j max_ =
    (if (j <= bg)
     then ((fun (dx, dy) ->
               let bd = 0 in
               let be = 19 in
               let rec w x max_ =
                 (if (x <= be)
                  then let bb = 0 in
                  let bc = 19 in
                  let rec ba y max_ =
                    (if (y <= bc)
                     then let max_ = (max2 max_ (find 4 m x y dx dy)) in
                     (ba (y + 1) max_)
                     else (w (x + 1) max_)) in
                    (ba bb max_)
                  else (v (j + 1) max_)) in
                 (w bd max_)) directions.(j))
     else (
            (Printf.printf "%d" max_);
            (Printf.printf "%s" "\n")
            )
     ) in
    (v bf max_);;

