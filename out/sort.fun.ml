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

let rec copytab =
  (fun tab len ->
      ((fun o ->
           o) ((Array.init_withenv len (fun i ->
                                           (fun (tab, len) ->
                                               ((fun p ->
                                                    ((tab, len), p)) tab.(i)))) ) (tab, len))));;
let rec bubblesort =
  (fun tab len ->
      ((fun m n ->
           let rec f i tab len =
             (if (i <= n)
              then ((fun k l ->
                        let rec g j tab len =
                          (if (j <= l)
                           then ((fun h ->
                                     (if (tab.(i) > tab.(j))
                                      then ((fun tmp ->
                                                (tab.(i) <- tab.(j); (tab.(j) <- tmp; (h tab len)))) tab.(i))
                                      else (h tab len))) (fun tab len ->
                                                             (g (j + 1) tab len)))
                           else (f (i + 1) tab len)) in
                          (g k tab len)) (i + 1) (len - 1))
              else ()) in
             (f m tab len)) 0 (len - 1)));;
let rec qsort_ =
  (fun tab len i j ->
      ((fun a ->
           (if (i < j)
            then ((fun i0 ->
                      ((fun j0 ->
                           (*  pivot : tab[0]  *)
                           let rec c j0 i0 tab len i j =
                             (if (i <> j)
                              then ((fun d ->
                                        (if (tab.(i) > tab.(j))
                                         then ((fun e ->
                                                   (if (i = (j - 1))
                                                    then (*  on inverse simplement *)
                                                    ((fun tmp ->
                                                         (tab.(i) <- tab.(j); (tab.(j) <- tmp; ((fun
                                                          i ->
                                                         (e j0 i0 tab len i j)) (i + 1))))) tab.(i))
                                                    else (*  on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1]  *)
                                                    ((fun tmp ->
                                                         (tab.(i) <- tab.(j); (tab.(j) <- tab.((i + 1)); (tab.((i + 1)) <- tmp; ((fun
                                                          i ->
                                                         (e j0 i0 tab len i j)) (i + 1)))))) tab.(i)))) (fun
                                          j0 i0 tab len i j ->
                                         (d j0 i0 tab len i j)))
                                         else ((fun j ->
                                                   (d j0 i0 tab len i j)) (j - 1)))) (fun
                               j0 i0 tab len i j ->
                              (c j0 i0 tab len i j)))
                              else begin
                                     (qsort_ tab len i0 (i - 1));
                                     begin
                                       (qsort_ tab len (i + 1) j0);
                                       (a tab len i j)
                                       end
                                     
                                     end
                              ) in
                             (c j0 i0 tab len i j)) j)) i)
            else (a tab len i j))) (fun tab len i j ->
                                       ())));;
let rec main =
  ((fun len ->
       Scanf.scanf "%d" (fun y ->
                            ((fun len ->
                                 (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                  tab ->
                                 ((fun tab2 ->
                                      begin
                                        (bubblesort tab2 len);
                                        ((fun w x ->
                                             let rec v i tab2 len =
                                               (if (i <= x)
                                                then (Printf.printf "%d" tab2.(i);
                                                (Printf.printf "%s" " ";
                                                (v (i + 1) tab2 len)))
                                                else (Printf.printf "%s" "\n";
                                                ((fun tab3 ->
                                                     begin
                                                       (qsort_ tab3 len 0 (len - 1));
                                                       ((fun t u ->
                                                            let rec s i tab3 tab2 len =
                                                              (if (i <= u)
                                                               then (Printf.printf "%d" tab3.(i);
                                                               (Printf.printf "%s" " ";
                                                               (s (i + 1) tab3 tab2 len)))
                                                               else (Printf.printf "%s" "\n";
                                                               ())) in
                                                              (s t tab3 tab2 len)) 0 (len - 1))
                                                       end
                                                     ) (copytab tab len)))) in
                                               (v w tab2 len)) 0 (len - 1))
                                        end
                                      ) (copytab tab len))) ((Array.init_withenv len (fun
                                  i_ ->
                                 (fun (len) ->
                                     ((fun tmp ->
                                          Scanf.scanf "%d" (fun r ->
                                                               ((fun tmp ->
                                                                    (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                                     q ->
                                                                    ((len), q)) tmp)))) r))) 0))) ) (len)))))) y))) 2);;

