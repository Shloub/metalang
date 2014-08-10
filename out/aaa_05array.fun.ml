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

let rec id =
  (fun b ->
      b);;
let rec g =
  (fun t index ->
      (t.(index) <- false; ()));;
let rec main =
  ((fun c ->
       ((fun a ->
            ((fun d ->
                 ((fun j ->
                      (if d
                       then (Printf.printf "%s" "True";
                       (j d c))
                       else (Printf.printf "%s" "False";
                       (j d c)))) (fun d c ->
                                      (Printf.printf "%s" "\n";
                                      begin
                                        (g (id a) 0);
                                        ((fun e ->
                                             ((fun h ->
                                                  (if e
                                                   then (Printf.printf "%s" "True";
                                                   (h e d c))
                                                   else (Printf.printf "%s" "False";
                                                   (h e d c)))) (fun e d c ->
                                                                    (Printf.printf "%s" "\n";
                                                                    ())))) a.(0))
                                        end
                                      )))) a.(0))) ((Array.init_withenv c (fun
        i ->
       (fun (c) ->
           (Printf.printf "%d" i;
           ((fun f ->
                ((c), f)) ((i mod 2) = 0))))) ) (c)))) 5);;

