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

let rec position_alphabet =
  (fun c ->
      ((fun i ->
           ((fun f ->
                (if ((i <= (int_of_char ('Z'))) && (i >= (int_of_char ('A'))))
                 then (i - (int_of_char ('A')))
                 else ((fun g ->
                           (if ((i <= (int_of_char ('z'))) && (i >= (int_of_char ('a'))))
                            then (i - (int_of_char ('a')))
                            else (- 1))) (fun i c ->
                                             (f i c))))) (fun i c ->
                                                             ()))) (int_of_char (c))));;
let rec of_position_alphabet =
  (fun c ->
      (char_of_int ((c + (int_of_char ('a'))))));;
let rec crypte =
  (fun taille_cle cle taille message ->
      ((fun d e ->
           let rec a i taille_cle cle taille message =
             (if (i <= e)
              then ((fun lettre ->
                        ((fun b ->
                             (if (lettre <> (- 1))
                              then ((fun addon ->
                                        ((fun new_ ->
                                             (message.(i) <- (of_position_alphabet new_); (b lettre taille_cle cle taille message))) ((addon + lettre) mod 26))) (position_alphabet cle.((i mod taille_cle))))
                              else (b lettre taille_cle cle taille message))) (fun
                         lettre taille_cle cle taille message ->
                        (a (i + 1) taille_cle cle taille message)))) (position_alphabet message.(i)))
              else ()) in
             (a d taille_cle cle taille message)) 0 (taille - 1)));;
let rec main =
  Scanf.scanf "%d" (fun taille_cle ->
                       (Scanf.scanf "%[\n \010]" (fun _ -> ((fun cle ->
                                                                (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                                                                 taille ->
                                                                (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                                                 message ->
                                                                begin
                                                                  (crypte taille_cle cle taille message);
                                                                  ((fun
                                                                   l m ->
                                                                  let rec k i taille taille_cle =
                                                                    (
                                                                    if (i <= m)
                                                                    then (Printf.printf "%c" message.(i);
                                                                    (k (i + 1) taille taille_cle))
                                                                    else (Printf.printf "%s" "\n";
                                                                    ())) in
                                                                    (k l taille taille_cle)) 0 (taille - 1))
                                                                  end
                                                                ) ((Array.init_withenv taille (fun
                                                                 index2 ->
                                                                (fun (taille, taille_cle) ->
                                                                    Scanf.scanf "%c" (fun
                                                                     out2 ->
                                                                    ((fun
                                                                     j ->
                                                                    ((taille, taille_cle), j)) out2)))) ) (taille, taille_cle))))))))) ((Array.init_withenv taille_cle (fun
                        index ->
                       (fun (taille_cle) ->
                           Scanf.scanf "%c" (fun out_ ->
                                                ((fun h ->
                                                     ((taille_cle), h)) out_)))) ) (taille_cle))))));;

