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
      let prod = 1 in
      let w = 2 in
      let x = n in
      let rec v i prod n =
        (if (i <= x)
         then let prod = (prod * i) in
         (v (i + 1) prod n)
         else prod) in
        (v w prod n));;
let rec show =
  (fun lim nth ->
      let t = (Array.init_withenv lim (fun i ->
                                          (fun (lim, nth) ->
                                              let a = i in
                                              ((lim, nth), a))) (lim, nth)) in
      let pris = (Array.init_withenv lim (fun j ->
                                             (fun (lim, nth) ->
                                                 let b = false in
                                                 ((lim, nth), b))) (lim, nth)) in
      let s = 1 in
      let u = (lim - 1) in
      let rec g k lim nth =
        (if (k <= u)
         then let n = (fact (lim - k)) in
         let nchiffre = (nth / n) in
         let nth = (nth mod n) in
         let q = 0 in
         let r = (lim - 1) in
         let rec h l nchiffre n lim nth =
           (if (l <= r)
            then let o = (fun nchiffre n lim nth ->
                             (h (l + 1) nchiffre n lim nth)) in
            (if (not pris.(l))
             then let p = (fun nchiffre n lim nth ->
                              let nchiffre = (nchiffre - 1) in
                              (o nchiffre n lim nth)) in
             (if (nchiffre = 0)
              then begin
                     (Printf.printf "%d" l);
                     (pris.(l) <- true; (p nchiffre n lim nth))
                     end
              
              else (p nchiffre n lim nth))
             else (o nchiffre n lim nth))
            else (g (k + 1) lim nth)) in
           (h q nchiffre n lim nth)
         else let e = 0 in
         let f = (lim - 1) in
         let rec c m lim nth =
           (if (m <= f)
            then let d = (fun lim nth ->
                             (c (m + 1) lim nth)) in
            (if (not pris.(m))
             then begin
                    (Printf.printf "%d" m);
                    (d lim nth)
                    end
             
             else (d lim nth))
            else (Printf.printf "%s" "\n")) in
           (c e lim nth)) in
        (g s lim nth));;
let rec main =
  begin
    (show 10 999999);
    ()
    end
  ;;

