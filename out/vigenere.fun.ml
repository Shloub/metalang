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
      let i = (int_of_char (c)) in
      let f = (fun i c ->
                  ()) in
      (if ((i <= (int_of_char ('Z'))) && (i >= (int_of_char ('A'))))
       then (i - (int_of_char ('A')))
       else let g = (fun i c ->
                        (f i c)) in
       (if ((i <= (int_of_char ('z'))) && (i >= (int_of_char ('a'))))
        then (i - (int_of_char ('a')))
        else (- 1))));;
let rec of_position_alphabet =
  (fun c ->
      (char_of_int ((c + (int_of_char ('a'))))));;
let rec crypte =
  (fun taille_cle cle taille message ->
      let d = 0 in
      let e = (taille - 1) in
      let rec a i taille_cle cle taille message =
        (if (i <= e)
         then let lettre = (position_alphabet message.(i)) in
         let b = (fun lettre taille_cle cle taille message ->
                     (a (i + 1) taille_cle cle taille message)) in
         (if (lettre <> (- 1))
          then let addon = (position_alphabet cle.((i mod taille_cle))) in
          let new_ = ((addon + lettre) mod 26) in
          (message.(i) <- (of_position_alphabet new_); (b lettre taille_cle cle taille message))
          else (b lettre taille_cle cle taille message))
         else ()) in
        (a d taille_cle cle taille message));;
let rec main =
  Scanf.scanf "%d"
  (fun taille_cle ->
      (Scanf.scanf "%[\n \010]" (fun _ -> let cle = (Array.init_withenv taille_cle (fun
       index taille_cle ->
      Scanf.scanf "%c"
      (fun out_ ->
          let h = out_ in
          (taille_cle, h))) taille_cle) in
      (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
      (fun taille ->
          (Scanf.scanf "%[\n \010]" (fun _ -> let message = (Array.init_withenv taille (fun
           index2 ->
          (fun (taille, taille_cle) ->
              Scanf.scanf "%c"
              (fun out2 ->
                  let j = out2 in
                  ((taille, taille_cle), j)))) (taille, taille_cle)) in
          begin
            (crypte taille_cle cle taille message);
            let l = 0 in
            let m = (taille - 1) in
            let rec k i taille taille_cle =
              (if (i <= m)
               then begin
                      (Printf.printf "%c" message.(i));
                      (k (i + 1) taille taille_cle)
                      end
               
               else (Printf.printf "%s" "\n")) in
              (k l taille taille_cle)
            end
          ))))))));;

