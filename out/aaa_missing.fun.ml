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
                                                                     j ->
                                                                    ((n), j)) t)))))) ) (n))));;
let rec result =
  (fun len tab ->
      ((fun tab2 ->
           ((fun g h ->
                let rec f i1 len tab =
                  (if (i1 <= h)
                   then (tab2.(tab.(i1)) <- true; (f (i1 + 1) len tab))
                   else ((fun d e ->
                             let rec b i2 len tab =
                               (if (i2 <= e)
                                then ((fun c ->
                                          (if (not tab2.(i2))
                                           then i2
                                           else (c len tab))) (fun len tab ->
                                                                  (b (i2 + 1) len tab)))
                                else (- 1)) in
                               (b d len tab)) 0 (len - 1))) in
                  (f g len tab)) 0 (len - 1))) ((Array.init_withenv len (fun
       i ->
      (fun (len, tab) ->
          ((fun a ->
               ((len, tab), a)) false))) ) (len, tab))));;
let rec main =
  ((fun len ->
       (Printf.printf "%d" len;
       (Printf.printf "%s" "\n";
       ((fun tab ->
            (Printf.printf "%d" (result len tab);
            ())) (read_int_line len))))) (read_int ()));;

