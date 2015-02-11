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
  let tab2 = (Array.init_withenv len (fun  i () -> let c = false in
  ((), c)) ()) in
  let h = 0 in
  let j = (len - 1) in
  let rec g i1 =
    (if (i1 <= j)
     then (
            (Printf.printf "%d " tab.(i1));
            tab2.(tab.(i1)) <- true;
            (g (i1 + 1))
            )
     
     else (
            (Printf.printf "\n" );
            let e = 0 in
            let f = (len - 1) in
            let rec d i2 =
              (if (i2 <= f)
               then (if (not tab2.(i2))
                     then i2
                     else (d (i2 + 1)))
               else (- 1)) in
              (d e)
            )
     ) in
    (g h)
let main =
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d\n" len);
    let tab = (Array.init_withenv len (fun  a () -> Scanf.scanf "%d"
    (fun  b -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let k = b in
                 ((), k)
                 )
    )) ()) in
    (
      (Printf.printf "%d\n" (result len tab))
      )
    
    )
  

