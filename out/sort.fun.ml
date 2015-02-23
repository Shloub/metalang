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

let copytab tab len =
  ((fun  (k, o) -> (
                     k;
                     o
                     )
  ) (Array.init_withenv len (fun  i () -> let h = tab.(i) in
  ((), h)) ()))
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
                                                           then let i = (if (i = (j - 1))
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
  (fun  v -> let len = v in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    ((fun  (m, tab) -> (
                         m;
                         let tab2 = (copytab tab len) in
                         (
                           (bubblesort tab2 len);
                           let t = 0 in
                           let u = (len - 1) in
                           let rec s i =
                             (if (i <= u)
                              then (
                                     (Printf.printf "%d " tab2.(i));
                                     (s (i + 1))
                                     )
                              
                              else (
                                     (Printf.printf "\n" );
                                     let tab3 = (copytab tab len) in
                                     (
                                       (qsort0 tab3 len 0 (len - 1));
                                       let q = 0 in
                                       let r = (len - 1) in
                                       let rec p i =
                                         (if (i <= r)
                                          then (
                                                 (Printf.printf "%d " tab3.(i));
                                                 (p (i + 1))
                                                 )
                                          
                                          else (Printf.printf "\n")) in
                                         (p q)
                                       )
                                     
                                     )
                              ) in
                             (s t)
                           )
                         
                         )
    ) (Array.init_withenv len (fun  i_ () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  n -> let tmp = n in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let l = tmp in
      ((), l)
      )
    )) ()))
    )
  )

