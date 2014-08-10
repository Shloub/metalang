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

let rec read_int =
  (fun () -> Scanf.scanf "%d" (fun out_ ->
                                  (Scanf.scanf "%[\n \010]" (fun _ -> out_))));;
let rec read_int_line =
  (fun n ->
      ((fun tab ->
           tab) ((Array.init_withenv n (fun i ->
                                           (fun (n) ->
                                               Scanf.scanf "%d" (fun t ->
                                                                    (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                                     b ->
                                                                    ((n), b)) t)))))) ) (n))));;
let rec read_char_line =
  (fun n ->
      ((fun tab ->
           (Scanf.scanf "%[\n \010]" (fun _ -> tab))) ((Array.init_withenv n (fun
       i ->
      (fun (n) ->
          Scanf.scanf "%c" (fun t ->
                               ((fun a ->
                                    ((n), a)) t)))) ) (n))));;
let rec main =
  ((fun len ->
       (Printf.printf "%d" len;
       (Printf.printf "%s" "=len\n";
       ((fun tab ->
            ((fun r s ->
                 let rec q i tab len =
                   (if (i <= s)
                    then (Printf.printf "%d" i;
                    (Printf.printf "%s" "=>";
                    (Printf.printf "%d" tab.(i);
                    (Printf.printf "%s" " ";
                    (q (i + 1) tab len)))))
                    else (Printf.printf "%s" "\n";
                    ((fun tab2 ->
                         ((fun o p ->
                              let rec m i_ tab2 tab len =
                                (if (i_ <= p)
                                 then (Printf.printf "%d" i_;
                                 (Printf.printf "%s" "==>";
                                 (Printf.printf "%d" tab2.(i_);
                                 (Printf.printf "%s" " ";
                                 (m (i_ + 1) tab2 tab len)))))
                                 else ((fun strlen ->
                                           (Printf.printf "%d" strlen;
                                           (Printf.printf "%s" "=strlen\n";
                                           ((fun tab4 ->
                                                ((fun k l ->
                                                     let rec g i3 tab4 strlen tab2 tab len =
                                                       (if (i3 <= l)
                                                        then ((fun tmpc ->
                                                                  ((fun
                                                                   c ->
                                                                  (Printf.printf "%c" tmpc;
                                                                  (Printf.printf "%s" ":";
                                                                  (Printf.printf "%d" c;
                                                                  (Printf.printf "%s" " ";
                                                                  ((fun
                                                                   h ->
                                                                  (if (tmpc <> ' ')
                                                                   then ((fun
                                                                    c ->
                                                                   (h c tmpc tab4 strlen tab2 tab len)) ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a'))))
                                                                   else (h c tmpc tab4 strlen tab2 tab len))) (fun
                                                                   c tmpc tab4 strlen tab2 tab len ->
                                                                  (tab4.(i3) <- (char_of_int (c)); (g (i3 + 1) tab4 strlen tab2 tab len))))))))) (int_of_char (tmpc)))) tab4.(i3))
                                                        else ((fun e f ->
                                                                  let rec d j tab4 strlen tab2 tab len =
                                                                    (
                                                                    if (j <= f)
                                                                    then (Printf.printf "%c" tab4.(j);
                                                                    (d (j + 1) tab4 strlen tab2 tab len))
                                                                    else ()) in
                                                                    (d e tab4 strlen tab2 tab len)) 0 (strlen - 1))) in
                                                       (g k tab4 strlen tab2 tab len)) 0 (strlen - 1))) (read_char_line strlen))))) (read_int ()))) in
                                (m o tab2 tab len)) 0 (len - 1))) (read_int_line len)))) in
                   (q r tab len)) 0 (len - 1))) (read_int_line len))))) (read_int ()));;

