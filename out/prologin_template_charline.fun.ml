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
                               ((fun d ->
                                    ((n), d)) t)))) ) (n))));;
let rec programme_candidat =
  (fun tableau taille ->
      ((fun out_ ->
           ((fun b c ->
                let rec a i out_ tableau taille =
                  (if (i <= c)
                   then ((fun out_ ->
                             (Printf.printf "%c" tableau.(i);
                             (a (i + 1) out_ tableau taille))) (out_ + ((int_of_char (tableau.(i))) * i)))
                   else (Printf.printf "%s" "--\n";
                   out_)) in
                  (a b out_ tableau taille)) 0 (taille - 1))) 0));;
let rec main =
  ((fun taille ->
       ((fun tableau ->
            (Printf.printf "%d" (programme_candidat tableau taille);
            (Printf.printf "%s" "\n";
            ()))) (read_char_line taille))) (read_int ()));;

