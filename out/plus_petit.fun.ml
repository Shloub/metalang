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

let rec go_ =
  (fun tab a b ->
      let m = ((a + b) / 2) in
      let h = (fun m tab a b ->
                  let i = a in
                  let j = b in
                  let rec f j i m tab a b =
                    (if (i < j)
                     then let e = tab.(i) in
                     let g = (fun e j i m tab a b ->
                                 (f j i m tab a b)) in
                     (if (e < m)
                      then let i = (i + 1) in
                      (g e j i m tab a b)
                      else let j = (j - 1) in
                      (tab.(i) <- tab.(j); (tab.(j) <- e; (g e j i m tab a b))))
                     else let c = (fun j i m tab a b ->
                                      ()) in
                     (if (i < m)
                      then (go_ tab a m)
                      else (go_ tab m b))) in
                    (f j i m tab a b)) in
      (if (a = m)
       then let k = (fun m tab a b ->
                        (h m tab a b)) in
       (if (tab.(a) = m)
        then b
        else a)
       else (h m tab a b)));;
let rec plus_petit_ =
  (fun tab len ->
      (go_ tab 0 len));;
let rec main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun o ->
      let len = o in
      (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
       i len ->
      let tmp = 0 in
      Scanf.scanf "%d"
      (fun n ->
          let tmp = n in
          (Scanf.scanf "%[\n \010]" (fun _ -> let l = tmp in
          (len, l))))) len) in
      (Printf.printf "%d" (plus_petit_ tab len)))));;

