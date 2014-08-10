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

let rec sumdiag =
  (fun n ->
      ((fun nterms ->
           ((fun un ->
                ((fun sum ->
                     ((fun b c ->
                          let rec a i sum un nterms n =
                            (if (i <= c)
                             then ((fun d ->
                                       ((fun un ->
                                            (*  print int d print "=>" print un print " "  *)
                                            ((fun sum ->
                                                 (a (i + 1) sum un nterms n)) (sum + un))) (un + d))) (2 * (1 + (i / 4))))
                             else sum) in
                            (a b sum un nterms n)) 0 (nterms - 2))) 1)) 1)) ((n * 2) - 1)));;
let rec main =
  (Printf.printf "%d" (sumdiag 1001);
  ());;

