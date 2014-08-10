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

let rec main =
  (* 
	a + b + c = 1000 && a * a + b * b = c * c
	 *)
  ((fun i j ->
       let rec d a =
         (if (a <= j)
          then ((fun g h ->
                    let rec e b =
                      (if (b <= h)
                       then ((fun c ->
                                 ((fun a2b2 ->
                                      ((fun cc ->
                                           ((fun f ->
                                                (if ((cc = a2b2) && (c > a))
                                                 then (Printf.printf "%d" a;
                                                 (Printf.printf "%s" "\n";
                                                 (Printf.printf "%d" b;
                                                 (Printf.printf "%s" "\n";
                                                 (Printf.printf "%d" c;
                                                 (Printf.printf "%s" "\n";
                                                 (Printf.printf "%d" ((a * b) * c);
                                                 (Printf.printf "%s" "\n";
                                                 (f cc a2b2 c)))))))))
                                                 else (f cc a2b2 c))) (fun
                                            cc a2b2 c ->
                                           (e (b + 1))))) (c * c))) ((a * a) + (b * b)))) ((1000 - a) - b))
                       else (d (a + 1))) in
                      (e g)) (a + 1) 1000)
          else ()) in
         (d i)) 1 1000);;

