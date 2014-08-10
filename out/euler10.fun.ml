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

let rec eratostene =
  (fun t max_ ->
      ((fun sum ->
           ((fun f g ->
                let rec a i sum t max_ =
                  (if (i <= g)
                   then ((fun b ->
                             (if (t.(i) = i)
                              then ((fun sum ->
                                        ((fun j ->
                                             (* 
			detect overflow
			 *)
                                             ((fun c ->
                                                  (if ((j / i) = i)
                                                   then let rec e j sum t max_ =
                                                          (if ((j < max_) && (j > 0))
                                                           then (t.(j) <- 0; ((fun
                                                            j ->
                                                           (e j sum t max_)) (j + i)))
                                                           else (c j sum t max_)) in
                                                          (e j sum t max_)
                                                   else (c j sum t max_))) (fun
                                              j sum t max_ ->
                                             (b sum t max_)))) (i * i))) (sum + i))
                              else (b sum t max_))) (fun sum t max_ ->
                                                        (a (i + 1) sum t max_)))
                   else sum) in
                  (a f sum t max_)) 2 (max_ - 1))) 0));;
let rec main =
  ((fun n ->
       (*  normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages  *)
       ((fun t ->
            (t.(1) <- 0; (Printf.printf "%d" (eratostene t n);
            (Printf.printf "%s" "\n";
            ())))) ((Array.init_withenv n (fun i ->
                                              (fun (n) ->
                                                  ((fun h ->
                                                       ((n), h)) i))) ) (n)))) 100000);;

