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

let rec max2 =
  (fun a b ->
      ((fun g ->
           (if (a > b)
            then a
            else b)) (fun a b ->
                         ())));;
let rec min2 =
  (fun a b ->
      ((fun f ->
           (if (a < b)
            then a
            else b)) (fun a b ->
                         ())));;
let rec pgcd =
  (fun a b ->
      ((fun c ->
           ((fun d ->
                ((fun reste ->
                     ((fun e ->
                          (if (reste = 0)
                           then c
                           else (pgcd c reste))) (fun reste d c a b ->
                                                     ()))) (d mod c))) (max2 a b))) (min2 a b)));;
let rec main =
  ((fun top ->
       ((fun bottom ->
            ((fun u v ->
                 let rec h i bottom top =
                   (if (i <= v)
                    then ((fun s t ->
                              let rec l j bottom top =
                                (if (j <= t)
                                 then ((fun q r ->
                                           let rec m k bottom top =
                                             (if (k <= r)
                                              then ((fun n ->
                                                        (if ((i <> j) && (j <> k))
                                                         then ((fun a ->
                                                                   ((fun
                                                                    b ->
                                                                   ((fun
                                                                    o ->
                                                                   (if ((a * k) = (i * b))
                                                                    then (Printf.printf "%d" a;
                                                                    (Printf.printf "%s" "/";
                                                                    (Printf.printf "%d" b;
                                                                    (Printf.printf "%s" "\n";
                                                                    ((fun
                                                                     top ->
                                                                    ((fun
                                                                     bottom ->
                                                                    (o b a bottom top)) (bottom * b))) (top * a))))))
                                                                    else (o b a bottom top))) (fun
                                                                    b a bottom top ->
                                                                   (n bottom top)))) ((j * 10) + k))) ((i * 10) + j))
                                                         else (n bottom top))) (fun
                                               bottom top ->
                                              (m (k + 1) bottom top)))
                                              else (l (j + 1) bottom top)) in
                                             (m q bottom top)) 1 9)
                                 else (h (i + 1) bottom top)) in
                                (l s bottom top)) 1 9)
                    else (Printf.printf "%d" top;
                    (Printf.printf "%s" "/";
                    (Printf.printf "%d" bottom;
                    (Printf.printf "%s" "\n";
                    ((fun p ->
                         (Printf.printf "%s" "pgcd=";
                         (Printf.printf "%d" p;
                         (Printf.printf "%s" "\n";
                         (Printf.printf "%d" (bottom / p);
                         (Printf.printf "%s" "\n";
                         ())))))) (pgcd top bottom))))))) in
                   (h u bottom top)) 1 9)) 1)) 1);;

