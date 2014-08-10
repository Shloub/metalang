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
                                                                     d ->
                                                                    ((n), d)) t)))))) ) (n))));;
let rec programme_candidat =
  (fun tableau taille ->
      ((fun out_ ->
           ((fun b c ->
                let rec a i out_ tableau taille =
                  (if (i <= c)
                   then ((fun out_ ->
                             (a (i + 1) out_ tableau taille)) (out_ + tableau.(i)))
                   else out_) in
                  (a b out_ tableau taille)) 0 (taille - 1))) 0));;
let rec main =
  ((fun taille ->
       ((fun tableau ->
            (Printf.printf "%d" (programme_candidat tableau taille);
            (Printf.printf "%s" "\n";
            ()))) (read_int_line taille))) (read_int ()));;

