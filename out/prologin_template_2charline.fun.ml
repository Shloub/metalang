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
let rec read_char_line =
  (fun n ->
      ((fun tab ->
           (Scanf.scanf "%[\n \010]" (fun _ -> tab))) ((Array.init_withenv n (fun
       i ->
      (fun (n) ->
          Scanf.scanf "%c" (fun t ->
                               ((fun g ->
                                    ((n), g)) t)))) ) (n))));;
let rec programme_candidat =
  (fun tableau1 taille1 tableau2 taille2 ->
      ((fun out_ ->
           ((fun e f ->
                let rec d i out_ tableau1 taille1 tableau2 taille2 =
                  (if (i <= f)
                   then ((fun out_ ->
                             (Printf.printf "%c" tableau1.(i);
                             (d (i + 1) out_ tableau1 taille1 tableau2 taille2))) (out_ + ((int_of_char (tableau1.(i))) * i)))
                   else (Printf.printf "%s" "--\n";
                   ((fun b c ->
                        let rec a j out_ tableau1 taille1 tableau2 taille2 =
                          (if (j <= c)
                           then ((fun out_ ->
                                     (Printf.printf "%c" tableau2.(j);
                                     (a (j + 1) out_ tableau1 taille1 tableau2 taille2))) (out_ + ((int_of_char (tableau2.(j))) * (j * 100))))
                           else (Printf.printf "%s" "--\n";
                           out_)) in
                          (a b out_ tableau1 taille1 tableau2 taille2)) 0 (taille2 - 1)))) in
                  (d e out_ tableau1 taille1 tableau2 taille2)) 0 (taille1 - 1))) 0));;
let rec main =
  ((fun taille1 ->
       ((fun tableau1 ->
            ((fun taille2 ->
                 ((fun tableau2 ->
                      (Printf.printf "%d" (programme_candidat tableau1 taille1 tableau2 taille2);
                      (Printf.printf "%s" "\n";
                      ()))) (read_char_line taille2))) (read_int ()))) (read_char_line taille1))) (read_int ()));;

