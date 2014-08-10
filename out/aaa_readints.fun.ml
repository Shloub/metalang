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
let rec read_int_matrix =
  (fun x y ->
      ((fun tab ->
           tab) ((Array.init_withenv y (fun z ->
                                           (fun (x, y) ->
                                               ((fun a ->
                                                    ((x, y), a)) (read_int_line x)))) ) (x, y))));;
let rec main =
  ((fun len ->
       (Printf.printf "%d" len;
       (Printf.printf "%s" "=len\n";
       ((fun tab1 ->
            ((fun l m ->
                 let rec k i tab1 len =
                   (if (i <= m)
                    then (Printf.printf "%d" i;
                    (Printf.printf "%s" "=>";
                    (Printf.printf "%d" tab1.(i);
                    (Printf.printf "%s" "\n";
                    (k (i + 1) tab1 len)))))
                    else ((fun len ->
                              ((fun tab2 ->
                                   ((fun g h ->
                                        let rec c i tab2 tab1 len =
                                          (if (i <= h)
                                           then ((fun e f ->
                                                     let rec d j tab2 tab1 len =
                                                       (if (j <= f)
                                                        then (Printf.printf "%d" tab2.(i).(j);
                                                        (Printf.printf "%s" " ";
                                                        (d (j + 1) tab2 tab1 len)))
                                                        else (Printf.printf "%s" "\n";
                                                        (c (i + 1) tab2 tab1 len))) in
                                                       (d e tab2 tab1 len)) 0 (len - 1))
                                           else ()) in
                                          (c g tab2 tab1 len)) 0 (len - 2))) (read_int_matrix len (len - 1)))) (read_int ()))) in
                   (k l tab1 len)) 0 (len - 1))) (read_int_line len))))) (read_int ()));;

