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

let rec max2 =
  (fun a b ->
      let h = (fun a b ->
                  ()) in
      (if (a > b)
       then a
       else b));;
let rec read_int_line =
  (fun n ->
      let tab = (Array.init_withenv n (fun i n ->
                                          Scanf.scanf "%d"
                                          (fun t ->
                                              (Scanf.scanf "%[\n \010]" (fun _ -> let g = t in
                                              (n, g))))) n) in
      tab);;
let rec read_int_matrix =
  (fun x y ->
      let tab = (Array.init_withenv y (fun z ->
                                          (fun (x, y) ->
                                              let f = (read_int_line x) in
                                              ((x, y), f))) (x, y)) in
      tab);;
let rec find =
  (fun n m x y dx dy ->
      let d = (fun n m x y dx dy ->
                  ()) in
      (if ((((x < 0) || (x = 20)) || (y < 0)) || (y = 20))
       then (- 1)
       else let e = (fun n m x y dx dy ->
                        (d n m x y dx dy)) in
       (if (n = 0)
        then 1
        else (m.(y).(x) * (find (n - 1) m (x + dx) (y + dy) dx dy)))));;
let rec main =
  let c = 8 in
  let directions = (Array.init_withenv c (fun i c ->
                                             let l = (fun i c k ->
                                                         (c, k)) in
                                             (if (i = 0)
                                              then let k = (0, 1) in
                                              (c, k)
                                              else let o = (fun i c ->
                                                               (l i c)) in
                                              (if (i = 1)
                                               then let k = (1, 0) in
                                               (c, k)
                                               else let p = (fun i c ->
                                                                (o i c)) in
                                               (if (i = 2)
                                                then let k = (0, (- 1)) in
                                                (c, k)
                                                else let q = (fun i c ->
                                                                 (p i c)) in
                                                (if (i = 3)
                                                 then let k = ((- 1), 0) in
                                                 (c, k)
                                                 else let r = (fun i c ->
                                                                  (q i c)) in
                                                 (if (i = 4)
                                                  then let k = (1, 1) in
                                                  (c, k)
                                                  else let s = (fun i c ->
                                                                   (r i c)) in
                                                  (if (i = 5)
                                                   then let k = (1, (- 1)) in
                                                   (c, k)
                                                   else let u = (fun i c ->
                                                                    (s i c)) in
                                                   (if (i = 6)
                                                    then let k = ((- 1), 1) in
                                                    (c, k)
                                                    else let k = ((- 1), (- 1)) in
                                                    (c, k))))))))) c) in
  let max_ = 0 in
  let m = (read_int_matrix 20 20) in
  let bf = 0 in
  let bg = 7 in
  let rec v j m max_ c =
    (if (j <= bg)
     then ((fun (dx, dy) ->
               let bd = 0 in
               let be = 19 in
               let rec w x dx dy m max_ c =
                 (if (x <= be)
                  then let bb = 0 in
                  let bc = 19 in
                  let rec ba y dx dy m max_ c =
                    (if (y <= bc)
                     then let max_ = (max2 max_ (find 4 m x y dx dy)) in
                     (ba (y + 1) dx dy m max_ c)
                     else (w (x + 1) dx dy m max_ c)) in
                    (ba bb dx dy m max_ c)
                  else (v (j + 1) m max_ c)) in
                 (w bd dx dy m max_ c)) directions.(j))
     else begin
            (Printf.printf "%d" max_);
            (Printf.printf "%s" "\n")
            end
     ) in
    (v bf m max_ c);;

