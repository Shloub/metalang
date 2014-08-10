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

let rec h =
  (fun i ->
      (*   for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end  *)
      ((fun j ->
           let rec b j i =
             (if (j <= (i + 2))
              then ((fun c ->
                        (if ((i mod j) = 5)
                         then true
                         else (c j i))) (fun j i ->
                                            ((fun j ->
                                                 (b j i)) (j + 1))))
              else false) in
             (b j i)) (i - 2)));;
let rec main =
  ((fun j ->
       ((fun g l ->
            let rec f k j =
              (if (k <= l)
               then ((fun j ->
                         (Printf.printf "%d" j;
                         (Printf.printf "%s" "\n";
                         (f (k + 1) j)))) (j + k))
               else ((fun i ->
                         let rec e i j =
                           (if (i < 10)
                            then (Printf.printf "%d" i;
                            ((fun i ->
                                 ((fun j ->
                                      (e i j)) (j + i))) (i + 1)))
                            else (Printf.printf "%d" j;
                            (Printf.printf "%d" i;
                            (Printf.printf "%s" "FIN TEST\n";
                            ())))) in
                           (e i j)) 4)) in
              (f g j)) 0 10)) 0);;

