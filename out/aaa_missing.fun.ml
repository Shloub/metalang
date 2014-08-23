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

let result len tab =
  let tab2 = (Array.init_withenv len (fun  i () -> let f = false in
  ((), f)) ()) in
  let l = 0 in
  let m = (len - 1) in
  let rec k i1 =
    (if (i1 <= m)
     then (
            tab2.(tab.(i1)) <- true;
            (k (i1 + 1))
            )
     
     else let h = 0 in
     let j = (len - 1) in
     let rec g i2 =
       (if (i2 <= j)
        then (if (not tab2.(i2))
              then i2
              else (g (i2 + 1)))
        else (- 1)) in
       (g h)) in
    (k l)
let main =
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d\n" len);
    let c = (Array.init_withenv len (fun  d () -> Scanf.scanf "%d"
    (fun  e -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let o = e in
                 ((), o)
                 )
    )) ()) in
    let tab = c in
    (Printf.printf "%d" (result len tab))
    )
  

