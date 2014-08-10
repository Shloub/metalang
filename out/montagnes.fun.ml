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

let rec montagnes_ =
  (fun tab len ->
      ((fun max_ ->
           ((fun j ->
                ((fun i ->
                     let rec b i j max_ tab len =
                       (if (i >= 0)
                        then ((fun x ->
                                  let rec e x i j max_ tab len =
                                    (if ((j >= 0) && (x > tab.((len - j))))
                                     then ((fun j ->
                                               (e x i j max_ tab len)) (j - 1))
                                     else ((fun j ->
                                               (tab.((len - j)) <- x; ((fun
                                                c ->
                                               (if (j > max_)
                                                then ((fun max_ ->
                                                          (c x i j max_ tab len)) j)
                                                else (c x i j max_ tab len))) (fun
                                                x i j max_ tab len ->
                                               ((fun i ->
                                                    (b i j max_ tab len)) (i - 1)))))) (j + 1))) in
                                    (e x i j max_ tab len)) tab.(i))
                        else max_) in
                       (b i j max_ tab len)) (len - 2))) 1)) 1));;
let rec main =
  ((fun len ->
       Scanf.scanf "%d" (fun h ->
                            ((fun len ->
                                 (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                  tab ->
                                 (Printf.printf "%d" (montagnes_ tab len);
                                 ())) ((Array.init_withenv len (fun i ->
                                                                   (fun
                                                                    (len) ->
                                                                   ((fun
                                                                    x ->
                                                                   Scanf.scanf "%d" (fun
                                                                    g ->
                                                                   ((fun
                                                                    x ->
                                                                   (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                                    f ->
                                                                   ((len), f)) x)))) g))) 0))) ) (len)))))) h))) 0);;

