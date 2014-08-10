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
  Scanf.scanf "%d" (fun len ->
                       (Scanf.scanf "%[\n \010]" (fun _ -> (Printf.printf "%d" len;
                       (Printf.printf "%s" "=len\n";
                       ((fun len ->
                            (Printf.printf "%s" "len*2=";
                            (Printf.printf "%d" len;
                            (Printf.printf "%s" "\n";
                            ((fun len ->
                                 ((fun tab ->
                                      (Printf.printf "%s" "\n";
                                      ((fun tab2 ->
                                           Scanf.scanf "%d" (fun strlen ->
                                                                (Scanf.scanf "%[\n \010]" (fun _ -> (Printf.printf "%d" strlen;
                                                                (Printf.printf "%s" "=strlen\n";
                                                                ((fun
                                                                 tab4 ->
                                                                ((fun
                                                                 g h ->
                                                                let rec f j strlen len =
                                                                  (if (j <= h)
                                                                   then (Printf.printf "%c" tab4.(j);
                                                                   (f (j + 1) strlen len))
                                                                   else ()) in
                                                                  (f g strlen len)) 0 (strlen - 1))) ((Array.init_withenv strlen (fun
                                                                 toto ->
                                                                (fun (strlen, len) ->
                                                                    Scanf.scanf "%c" (fun
                                                                     tmpc ->
                                                                    ((fun
                                                                     c ->
                                                                    (Printf.printf "%c" tmpc;
                                                                    (Printf.printf "%s" ":";
                                                                    (Printf.printf "%d" c;
                                                                    (Printf.printf "%s" " ";
                                                                    ((fun
                                                                     e ->
                                                                    (
                                                                    if (tmpc <> ' ')
                                                                    then ((fun
                                                                     c ->
                                                                    (e c tmpc toto strlen len)) ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a'))))
                                                                    else (e c tmpc toto strlen len))) (fun
                                                                     c tmpc toto strlen len ->
                                                                    ((fun
                                                                     d ->
                                                                    ((strlen, len), d)) (char_of_int (c)))))))))) (int_of_char (tmpc)))))) ) (strlen, len))))))))) ((Array.init_withenv len (fun
                                       i_ ->
                                      (fun (len) ->
                                          Scanf.scanf "%d" (fun tmpi2 ->
                                                               (Scanf.scanf "%[\n \010]" (fun _ -> (Printf.printf "%d" i_;
                                                               (Printf.printf "%s" "==>";
                                                               (Printf.printf "%d" tmpi2;
                                                               (Printf.printf "%s" " ";
                                                               ((fun b ->
                                                                    ((len), b)) tmpi2)))))))))) ) (len))))) ((Array.init_withenv len (fun
                                  i ->
                                 (fun (len) ->
                                     Scanf.scanf "%d" (fun tmpi1 ->
                                                          (Scanf.scanf "%[\n \010]" (fun _ -> (Printf.printf "%d" i;
                                                          (Printf.printf "%s" "=>";
                                                          (Printf.printf "%d" tmpi1;
                                                          (Printf.printf "%s" " ";
                                                          ((fun a ->
                                                               ((len), a)) tmpi1)))))))))) ) (len)))) (len / 2)))))) (len * 2)))))));;

