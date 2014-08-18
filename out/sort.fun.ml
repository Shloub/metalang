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

let copytab =
  (fun tab len ->
      let o = (Array.init_withenv len (fun i ->
                                          (fun () -> let k = tab.(i) in
                                          ((), k))) ()) in
      o);;
let bubblesort =
  (fun tab len ->
      let g = 0 in
      let h = (len - 1) in
      let rec c i =
        (if (i <= h)
         then let e = (i + 1) in
         let f = (len - 1) in
         let rec d j =
           (if (j <= f)
            then (
                   (if (tab.(i) > tab.(j))
                    then let tmp = tab.(i) in
                    (
                      tab.(i) <- tab.(j);
                      tab.(j) <- tmp;
                      ()
                      )
                    
                    else ());
                   (d (j + 1))
                   )
            
            else (c (i + 1))) in
           (d e)
         else ()) in
        (c g));;
let rec qsort_ =
  (fun tab len i j ->
      ((fun (i, j) ->
           ()) (if (i < j)
                then let i0 = i in
                let j0 = j in
                (*  pivot : tab[0]  *)
                let rec b i j =
                  (if (i <> j)
                   then ((fun (i, j) ->
                             (b i j)) (if (tab.(i) > tab.(j))
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
                          (qsort_ tab len i0 (i - 1));
                          (qsort_ tab len (i + 1) j0);
                          (i, j)
                          )
                   ) in
                  (b i j)
                else (i, j))));;
let main =
  let len = 2 in
  Scanf.scanf "%d"
  (fun u ->
      let len = u in
      (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
       i_ ->
      (fun () -> let tmp = 0 in
      Scanf.scanf "%d"
      (fun m ->
          let tmp = m in
          (Scanf.scanf "%[\n \010]" (fun _ -> let l = tmp in
          ((), l)))))) ()) in
      let tab2 = (copytab tab len) in
      (
        (bubblesort tab2 len);
        let s = 0 in
        let t = (len - 1) in
        let rec r i =
          (if (i <= t)
           then (
                  (Printf.printf "%d" tab2.(i));
                  (Printf.printf "%s" " ");
                  (r (i + 1))
                  )
           
           else (
                  (Printf.printf "%s" "\n");
                  let tab3 = (copytab tab len) in
                  (
                    (qsort_ tab3 len 0 (len - 1));
                    let p = 0 in
                    let q = (len - 1) in
                    let rec n i =
                      (if (i <= q)
                       then (
                              (Printf.printf "%d" tab3.(i));
                              (Printf.printf "%s" " ");
                              (n (i + 1))
                              )
                       
                       else (Printf.printf "%s" "\n")) in
                      (n p)
                    )
                  
                  )
           ) in
          (r s)
        )
      )));;

