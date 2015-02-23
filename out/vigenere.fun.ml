module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let position_alphabet c =
  let i = (int_of_char (c)) in
  (if ((i <= (int_of_char ('Z'))) && (i >= (int_of_char ('A'))))
   then (i - (int_of_char ('A')))
   else (if ((i <= (int_of_char ('z'))) && (i >= (int_of_char ('a'))))
         then (i - (int_of_char ('a')))
         else (- 1)))
let of_position_alphabet c =
  (char_of_int ((c + (int_of_char ('a')))))
let crypte taille_cle cle taille message =
  let b = (taille - 1) in
  let rec a i =
    (if (i <= b)
     then let lettre = (position_alphabet message.(i)) in
     (if (lettre <> (- 1))
      then let addon = (position_alphabet cle.((i mod taille_cle))) in
      let new0 = ((addon + lettre) mod 26) in
      (
        message.(i) <- (of_position_alphabet new0);
        (a (i + 1))
        )
      
      else (a (i + 1)))
     else ()) in
    (a 0)
let main =
  Scanf.scanf "%d"
  (fun  taille_cle -> (
                        (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                        ((fun  (e, cle) -> (
                                             e;
                                             (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                             Scanf.scanf "%d"
                                             (fun  taille -> (
                                                               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                                               ((fun  (g, message) -> 
                                                               (
                                                                 g;
                                                                 (crypte taille_cle cle taille message);
                                                                 let j = (taille - 1) in
                                                                 let rec h i =
                                                                   (if (i <= j)
                                                                    then (
                                                                           (Printf.printf "%c" message.(i));
                                                                           (h (i + 1))
                                                                           )
                                                                    
                                                                    else (Printf.printf "\n")) in
                                                                   (h 0)
                                                                 )
                                                               ) (Array.init_withenv taille (fun  index2 () -> Scanf.scanf "%c"
                                                               (fun  out2 -> let f = out2 in
                                                               ((), f))) ()))
                                                               )
                                             )
                                             )
                        ) (Array.init_withenv taille_cle (fun  index () -> Scanf.scanf "%c"
                        (fun  out0 -> let d = out0 in
                        ((), d))) ()))
                        )
  )

