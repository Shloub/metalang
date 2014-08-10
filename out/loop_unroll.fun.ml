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
  ((fun j ->
       ((fun j ->
            (Printf.printf "%d" j;
            (Printf.printf "%s" "\n";
            ((fun j ->
                 (Printf.printf "%d" j;
                 (Printf.printf "%s" "\n";
                 ((fun j ->
                      (Printf.printf "%d" j;
                      (Printf.printf "%s" "\n";
                      ((fun j ->
                           (Printf.printf "%d" j;
                           (Printf.printf "%s" "\n";
                           ((fun j ->
                                (Printf.printf "%d" j;
                                (Printf.printf "%s" "\n";
                                ()))) 4)))) 3)))) 2)))) 1)))) 0)) 0);;

