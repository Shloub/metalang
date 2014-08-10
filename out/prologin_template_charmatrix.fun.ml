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
                               ((fun h ->
                                    ((n), h)) t)))) ) (n))));;
let rec read_char_matrix =
  (fun x y ->
      ((fun tab ->
           tab) ((Array.init_withenv y (fun z ->
                                           (fun (x, y) ->
                                               ((fun g ->
                                                    ((x, y), g)) (read_char_line x)))) ) (x, y))));;
let rec programme_candidat =
  (fun tableau taille_x taille_y ->
      ((fun out_ ->
           ((fun e f ->
                let rec a i out_ tableau taille_x taille_y =
                  (if (i <= f)
                   then ((fun c d ->
                             let rec b j out_ tableau taille_x taille_y =
                               (if (j <= d)
                                then ((fun out_ ->
                                          (Printf.printf "%c" tableau.(i).(j);
                                          (b (j + 1) out_ tableau taille_x taille_y))) (out_ + ((int_of_char (tableau.(i).(j))) * (i + (j * 2)))))
                                else (Printf.printf "%s" "--\n";
                                (a (i + 1) out_ tableau taille_x taille_y))) in
                               (b c out_ tableau taille_x taille_y)) 0 (taille_x - 1))
                   else out_) in
                  (a e out_ tableau taille_x taille_y)) 0 (taille_y - 1))) 0));;
let rec main =
  ((fun taille_x ->
       ((fun taille_y ->
            ((fun tableau ->
                 (Printf.printf "%d" (programme_candidat tableau taille_x taille_y);
                 (Printf.printf "%s" "\n";
                 ()))) (read_char_matrix taille_x taille_y))) (read_int ()))) (read_int ()));;

