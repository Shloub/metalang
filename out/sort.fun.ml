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

let copytab tab len =
  let o = (Array.init_withenv len (fun  i () -> let h = tab.(i) in
  ((), h)) ()) in
  o
let bubblesort tab len =
  let f = 0 in
  let g = (len - 1) in
  let rec b i =
    (if (i <= g)
     then let d = (i + 1) in
     let e = (len - 1) in
     let rec c j =
       (if (j <= e)
        then (
               (if (tab.(i) > tab.(j))
                then let tmp = tab.(i) in
                (
                  tab.(i) <- tab.(j);
                  tab.(j) <- tmp
                  )
                
                else ());
               (c (j + 1))
               )
        
        else (b (i + 1))) in
       (c d)
     else ()) in
    (b f)
let rec qsort0 tab len i j =
  ((fun  (i, j) -> ()) (if (i < j)
                        then let i0 = i in
                        let j0 = j in
                        (*  pivot : tab[0]  *)
                        let rec a i j =
                          (if (i <> j)
                           then ((fun  (i, j) -> (a i j)) (if (tab.(i) > tab.(j))
                                                           then let i = (
                                                           if (i = (j - 1))
                                                           then (*  on inverse simplement *)
                                                           let tmp = tab.(i) in
                                                           (
                                                             tab.(i) <- tab.(j);
                                                             tab.(j) <- tmp;
                                                             let i = (i + 1) in
                                                             i
                                                             )
                                                           
                                                           else (*  on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1]  *)
                                                           let tmp = tab.(i) in
                                                           (
                                                             tab.(i) <- tab.(j);
                                                             tab.(j) <- tab.((i + 1));
                                                             tab.((i + 1)) <- tmp;
                                                             let i = (i + 1) in
                                                             i
                                                             )
                                                           ) in
                                                           (i, j)
                                                           else let j = (j - 1) in
                                                           (i, j)))
                           else (
                                  (qsort0 tab len i0 (i - 1));
                                  (qsort0 tab len (i + 1) j0);
                                  (i, j)
                                  )
                           ) in
                          (a i j)
                        else (i, j)))
let main =
  let len = 2 in
  Scanf.scanf "%d"
  (fun  t -> let len = t in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init_withenv len (fun  i_ () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  l -> let tmp = l in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let k = tmp in
      ((), k)
      )
    )) ()) in
    let tab2 = (copytab tab len) in
    (
      (bubblesort tab2 len);
      let r = 0 in
      let s = (len - 1) in
      let rec q i =
        (if (i <= s)
         then (
                (Printf.printf "%d " tab2.(i));
                (q (i + 1))
                )
         
         else (
                (Printf.printf "\n" );
                let tab3 = (copytab tab len) in
                (
                  (qsort0 tab3 len 0 (len - 1));
                  let n = 0 in
                  let p = (len - 1) in
                  let rec m i =
                    (if (i <= p)
                     then (
                            (Printf.printf "%d " tab3.(i));
                            (m (i + 1))
                            )
                     
                     else (Printf.printf "\n")) in
                    (m n)
                  )
                
                )
         ) in
        (q r)
      )
    
    )
  )

