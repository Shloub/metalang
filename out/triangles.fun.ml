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

let rec find0 =
  (fun len tab cache x y ->
      (* 
	Cette fonction est récursive
	 *)
      ((fun f ->
           (if (y = (len - 1))
            then tab.(y).(x)
            else ((fun g ->
                      (if (x > y)
                       then (- 10000)
                       else ((fun h ->
                                 (if (cache.(y).(x) <> 0)
                                  then cache.(y).(x)
                                  else (h len tab cache x y))) (fun len tab cache x y ->
                                                                   (g len tab cache x y))))) (fun
             len tab cache x y ->
            (f len tab cache x y))))) (fun len tab cache x y ->
                                          ((fun result ->
                                               ((fun out0 ->
                                                    ((fun out1 ->
                                                         ((fun e ->
                                                              (if (out0 > out1)
                                                               then ((fun
                                                                result ->
                                                               (e out1 out0 result len tab cache x y)) (out0 + tab.(y).(x)))
                                                               else ((fun
                                                                result ->
                                                               (e out1 out0 result len tab cache x y)) (out1 + tab.(y).(x))))) (fun
                                                          out1 out0 result len tab cache x y ->
                                                         (cache.(y).(x) <- result; result)))) (find0 len tab cache (x + 1) (y + 1)))) (find0 len tab cache x (y + 1)))) 0))));;
let rec find =
  (fun len tab ->
      ((fun tab2 ->
           (find0 len tab tab2 0 0)) ((Array.init_withenv len (fun i ->
                                                                  (fun
                                                                   (len, tab) ->
                                                                  ((fun
                                                                   a ->
                                                                  ((fun
                                                                   tab3 ->
                                                                  ((fun
                                                                   c ->
                                                                  ((len, tab), c)) tab3)) ((Array.init_withenv a (fun
                                                                   j ->
                                                                  (fun
                                                                   (a, i, len, tab) ->
                                                                  ((fun
                                                                   d ->
                                                                  ((a, i, len, tab), d)) 0))) ) (a, i, len, tab)))) (i + 1)))) ) (len, tab))));;
let rec main =
  ((fun len ->
       Scanf.scanf "%d" (fun v ->
                            ((fun len ->
                                 (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                  tab ->
                                 (Printf.printf "%d" (find len tab);
                                 (Printf.printf "%s" "\n";
                                 ((fun t u ->
                                      let rec p k len =
                                        (if (k <= u)
                                         then ((fun r s ->
                                                   let rec q l len =
                                                     (if (l <= s)
                                                      then (Printf.printf "%d" tab.(k).(l);
                                                      (Printf.printf "%s" " ";
                                                      (q (l + 1) len)))
                                                      else (Printf.printf "%s" "\n";
                                                      (p (k + 1) len))) in
                                                     (q r len)) 0 k)
                                         else ()) in
                                        (p t len)) 0 (len - 1))))) ((Array.init_withenv len (fun
                                  i ->
                                 (fun (len) ->
                                     ((fun b ->
                                          ((fun tab2 ->
                                               ((fun m ->
                                                    ((len), m)) tab2)) ((Array.init_withenv b (fun
                                           j ->
                                          (fun (b, i, len) ->
                                              ((fun tmp ->
                                                   Scanf.scanf "%d" (fun
                                                    o ->
                                                   ((fun tmp ->
                                                        (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                         n ->
                                                        ((b, i, len), n)) tmp)))) o))) 0))) ) (b, i, len)))) (i + 1)))) ) (len)))))) v))) 0);;

