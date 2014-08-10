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
  ((fun i ->
       ((fun i ->
            (Printf.printf "%d" i;
            (Printf.printf "%s" "\n";
            ((fun i ->
                 (Printf.printf "%d" i;
                 (Printf.printf "%s" "\n";
                 ((fun i ->
                      (Printf.printf "%d" i;
                      (Printf.printf "%s" "\n";
                      ((fun i ->
                           (Printf.printf "%d" i;
                           (Printf.printf "%s" "\n";
                           ((fun i ->
                                (Printf.printf "%d" i;
                                (Printf.printf "%s" "\n";
                                ((fun i ->
                                     (Printf.printf "%d" i;
                                     (Printf.printf "%s" "\n";
                                     ((fun i ->
                                          (Printf.printf "%d" i;
                                          (Printf.printf "%s" "\n";
                                          (* 
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
 *)
                                          (Printf.printf "%d" (117 / 17);
                                          (Printf.printf "%s" "\n";
                                          (Printf.printf "%d" (117 / (- 17));
                                          (Printf.printf "%s" "\n";
                                          (Printf.printf "%d" ((- 117) / 17);
                                          (Printf.printf "%s" "\n";
                                          (Printf.printf "%d" ((- 117) / (- 17));
                                          (Printf.printf "%s" "\n";
                                          (Printf.printf "%d" (117 mod 17);
                                          (Printf.printf "%s" "\n";
                                          (Printf.printf "%d" (117 mod (- 17));
                                          (Printf.printf "%s" "\n";
                                          (Printf.printf "%d" ((- 117) mod 17);
                                          (Printf.printf "%s" "\n";
                                          (Printf.printf "%d" ((- 117) mod (- 17));
                                          (Printf.printf "%s" "\n";
                                          ()))))))))))))))))))) (i - 1))))) (i / 3))))) (i + 1))))) (i / 2))))) (i * 13))))) (i + 55))))) (i - 1))) 0);;

