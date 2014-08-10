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
  Scanf.scanf "%d" (fun strlen ->
                       (Scanf.scanf "%[\n \010]" (fun _ -> ((fun tab4 ->
                                                                ((fun
                                                                 e f ->
                                                                let rec d j strlen =
                                                                  (if (j <= f)
                                                                   then (Printf.printf "%c" tab4.(j);
                                                                   (d (j + 1) strlen))
                                                                   else ()) in
                                                                  (d e strlen)) 0 (strlen - 1))) ((Array.init_withenv strlen (fun
                        toto ->
                       (fun (strlen) ->
                           Scanf.scanf "%c" (fun tmpc ->
                                                ((fun c ->
                                                     ((fun b ->
                                                          (if (tmpc <> ' ')
                                                           then ((fun
                                                            c ->
                                                           (b c tmpc toto strlen)) ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a'))))
                                                           else (b c tmpc toto strlen))) (fun
                                                      c tmpc toto strlen ->
                                                     ((fun a ->
                                                          ((strlen), a)) (char_of_int (c)))))) (int_of_char (tmpc)))))) ) (strlen))))));;

