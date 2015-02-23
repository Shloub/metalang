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
  ((fun  (g, o) -> (
                     g;
                     o
                     )
  ) (Array.init_withenv len (fun  i () -> let f = tab.(i) in
  ((), f)) ()))
let bubblesort tab len =
  let e = (len - 1) in
  let rec b i =
    (if (i <= e)
     then let d = (len - 1) in
     let rec c j =
       (if (j <= d)
        then (if (tab.(i) > tab.(j))
              then let tmp = tab.(i) in
              (
                tab.(i) <- tab.(j);
                tab.(j) <- tmp;
                (c (j + 1))
                )
              
              else (c (j + 1)))
        else (b (i + 1))) in
       (c (i + 1))
     else ()) in
    (b 0)
let rec qsort0 tab len i j =
  (if (i < j)
   then let i0 = i in
   let j0 = j in
   (*  pivot : tab[0]  *)
   let rec a i j =
     (if (i <> j)
      then (if (tab.(i) > tab.(j))
            then (if (i = (j - 1))
                  then (*  on inverse simplement *)
                  let tmp = tab.(i) in
                  (
                    tab.(i) <- tab.(j);
                    tab.(j) <- tmp;
                    let i = (i + 1) in
                    (a i j)
                    )
                  
                  else (*  on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1]  *)
                  let tmp = tab.(i) in
                  (
                    tab.(i) <- tab.(j);
                    tab.(j) <- tab.((i + 1));
                    tab.((i + 1)) <- tmp;
                    let i = (i + 1) in
                    (a i j)
                    )
                  )
            else let j = (j - 1) in
            (a i j))
      else (
             (qsort0 tab len i0 (i - 1));
             (qsort0 tab len (i + 1) j0);
             ()
             )
      ) in
     (a i j)
   else ())
let main =
  let len = 2 in
  Scanf.scanf "%d"
  (fun  r -> let len = r in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    ((fun  (k, tab) -> (
                         k;
                         let tab2 = (copytab tab len) in
                         (
                           (bubblesort tab2 len);
                           let q = (len - 1) in
                           let rec p i =
                             (if (i <= q)
                              then (
                                     (Printf.printf "%d " tab2.(i));
                                     (p (i + 1))
                                     )
                              
                              else (
                                     (Printf.printf "\n" );
                                     let tab3 = (copytab tab len) in
                                     (
                                       (qsort0 tab3 len 0 (len - 1));
                                       let n = (len - 1) in
                                       let rec m i =
                                         (if (i <= n)
                                          then (
                                                 (Printf.printf "%d " tab3.(i));
                                                 (m (i + 1))
                                                 )
                                          
                                          else (Printf.printf "\n")) in
                                         (m 0)
                                       )
                                     
                                     )
                              ) in
                             (p 0)
                           )
                         
                         )
    ) (Array.init_withenv len (fun  i_ () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  l -> let tmp = l in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let h = tmp in
      ((), h)
      )
    )) ()))
    )
  )

