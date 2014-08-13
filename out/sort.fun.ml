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
      let o = (Array.init_withenv len (fun i ->
                                          (fun (tab, len) ->
                                              let p = tab.(i) in
                                              ((tab, len), p))) (tab, len)) in
      o);;
let rec bubblesort =
  (fun tab len ->
      let m = 0 in
      let n = (len - 1) in
      let rec f i tab len =
        (if (i <= n)
         then let k = (i + 1) in
         let l = (len - 1) in
         let rec g j tab len =
           (if (j <= l)
            then let h = (fun tab len ->
                             (g (j + 1) tab len)) in
            (if (tab.(i) > tab.(j))
             then let tmp = tab.(i) in
             (tab.(i) <- tab.(j); (tab.(j) <- tmp; (h tab len)))
             else (h tab len))
            else (f (i + 1) tab len)) in
           (g k tab len)
         else ()) in
        (f m tab len));;
let rec qsort_ =
  (fun tab len i j ->
      let a = (fun tab len i j ->
                  ()) in
      (if (i < j)
       then let i0 = i in
       let j0 = j in
       (*  pivot : tab[0]  *)
       let rec c j0 i0 tab len i j =
         (if (i <> j)
          then let d = (fun j0 i0 tab len i j ->
                           (c j0 i0 tab len i j)) in
          (if (tab.(i) > tab.(j))
           then let e = (fun j0 i0 tab len i j ->
                            (d j0 i0 tab len i j)) in
           (if (i = (j - 1))
            then (*  on inverse simplement *)
            let tmp = tab.(i) in
            (tab.(i) <- tab.(j); (tab.(j) <- tmp; let i = (i + 1) in
            (e j0 i0 tab len i j)))
            else (*  on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1]  *)
            let tmp = tab.(i) in
            (tab.(i) <- tab.(j); (tab.(j) <- tab.((i + 1)); (tab.((i + 1)) <- tmp; let i = (i + 1) in
            (e j0 i0 tab len i j)))))
           else let j = (j - 1) in
           (d j0 i0 tab len i j))
          else begin
                 (qsort_ tab len i0 (i - 1));
                 (qsort_ tab len (i + 1) j0);
                 (a tab len i j)
                 end
          ) in
         (c j0 i0 tab len i j)
       else (a tab len i j)));;
let rec main =
  let len = 2 in
  Scanf.scanf "%d"
  (fun y ->
      let len = y in
      (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
       i_ len ->
      let tmp = 0 in
      Scanf.scanf "%d"
      (fun r ->
          let tmp = r in
          (Scanf.scanf "%[\n \010]" (fun _ -> let q = tmp in
          (len, q))))) len) in
      let tab2 = (copytab tab len) in
      begin
        (bubblesort tab2 len);
        let w = 0 in
        let x = (len - 1) in
        let rec v i tab2 len =
          (if (i <= x)
           then begin
                  (Printf.printf "%d" tab2.(i));
                  (Printf.printf "%s" " ");
                  (v (i + 1) tab2 len)
                  end
           
           else begin
                  (Printf.printf "%s" "\n");
                  let tab3 = (copytab tab len) in
                  begin
                    (qsort_ tab3 len 0 (len - 1));
                    let t = 0 in
                    let u = (len - 1) in
                    let rec s i tab3 tab2 len =
                      (if (i <= u)
                       then begin
                              (Printf.printf "%d" tab3.(i));
                              (Printf.printf "%s" " ");
                              (s (i + 1) tab3 tab2 len)
                              end
                       
                       else (Printf.printf "%s" "\n")) in
                      (s t tab3 tab2 len)
                    end
                  
                  end
           ) in
          (v w tab2 len)
        end
      )));;

