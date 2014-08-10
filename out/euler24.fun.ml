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

let rec fact =
  (fun n ->
      ((fun prod ->
           ((fun w x ->
                let rec v i prod n =
                  (if (i <= x)
                   then ((fun prod ->
                             (v (i + 1) prod n)) (prod * i))
                   else prod) in
                  (v w prod n)) 2 n)) 1));;
let rec show =
  (fun lim nth ->
      ((fun t ->
           ((fun pris ->
                ((fun s u ->
                     let rec g k lim nth =
                       (if (k <= u)
                        then ((fun n ->
                                  ((fun nchiffre ->
                                       ((fun nth ->
                                            ((fun q r ->
                                                 let rec h l nchiffre n lim nth =
                                                   (if (l <= r)
                                                    then ((fun o ->
                                                              (if (not pris.(l))
                                                               then ((fun
                                                                p ->
                                                               (if (nchiffre = 0)
                                                                then (Printf.printf "%d" l;
                                                                (pris.(l) <- true; (p nchiffre n lim nth)))
                                                                else (p nchiffre n lim nth))) (fun
                                                                nchiffre n lim nth ->
                                                               ((fun nchiffre ->
                                                                    (o nchiffre n lim nth)) (nchiffre - 1))))
                                                               else (o nchiffre n lim nth))) (fun
                                                     nchiffre n lim nth ->
                                                    (h (l + 1) nchiffre n lim nth)))
                                                    else (g (k + 1) lim nth)) in
                                                   (h q nchiffre n lim nth)) 0 (lim - 1))) (nth mod n))) (nth / n))) (fact (lim - k)))
                        else ((fun e f ->
                                  let rec c m lim nth =
                                    (if (m <= f)
                                     then ((fun d ->
                                               (if (not pris.(m))
                                                then (Printf.printf "%d" m;
                                                (d lim nth))
                                                else (d lim nth))) (fun
                                      lim nth ->
                                     (c (m + 1) lim nth)))
                                     else (Printf.printf "%s" "\n";
                                     ())) in
                                    (c e lim nth)) 0 (lim - 1))) in
                       (g s lim nth)) 1 (lim - 1))) ((Array.init_withenv lim (fun
            j ->
           (fun (lim, nth) ->
               ((fun b ->
                    ((lim, nth), b)) false))) ) (lim, nth)))) ((Array.init_withenv lim (fun
       i ->
      (fun (lim, nth) ->
          ((fun a ->
               ((lim, nth), a)) i))) ) (lim, nth))));;
let rec main =
  begin
    (show 10 999999);
    ()
    end
  ;;

