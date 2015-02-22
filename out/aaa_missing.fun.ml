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

let result len tab =
  ((fun  (d, tab2) -> (
                        d;
                        let j = 0 in
                        let k = (len - 1) in
                        let rec h i1 =
                          (if (i1 <= k)
                           then (
                                  (Printf.printf "%d " tab.(i1));
                                  tab2.(tab.(i1)) <- true;
                                  (h (i1 + 1))
                                  )
                           
                           else (
                                  (Printf.printf "\n" );
                                  let f = 0 in
                                  let g = (len - 1) in
                                  let rec e i2 =
                                    (if (i2 <= g)
                                     then (if (not tab2.(i2))
                                           then i2
                                           else (e (i2 + 1)))
                                     else (- 1)) in
                                    (e f)
                                  )
                           ) in
                          (h j)
                        )
  ) (Array.init_withenv len (fun  i () -> let c = false in
  ((), c)) ()))
let main =
  let len = (Scanf.scanf "%d " (fun x -> x)) in
  (
    (Printf.printf "%d\n" len);
    ((fun  (m, tab) -> (
                         m;
                         (Printf.printf "%d\n" (result len tab))
                         )
    ) (Array.init_withenv len (fun  a () -> Scanf.scanf "%d"
    (fun  b -> (
                 (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                 let l = b in
                 ((), l)
                 )
    )) ()))
    )
  

