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
  let rec a i =
    (if (i <= (taille - 1))
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
                        let cle = (Array.init taille_cle (fun  index -> Scanf.scanf "%c"
                        (fun  out0 -> out0))) in
                        (
                          (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                          Scanf.scanf "%d"
                          (fun  taille -> (
                                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                            let message = (Array.init taille (fun  index2 -> Scanf.scanf "%c"
                                            (fun  out2 -> out2))) in
                                            (
                                              (crypte taille_cle cle taille message);
                                              let rec b i =
                                                (if (i <= (taille - 1))
                                                 then (
                                                        (Printf.printf "%c" message.(i));
                                                        (b (i + 1))
                                                        )
                                                 
                                                 else (Printf.printf "\n")) in
                                                (b 0)
                                              )
                                            
                                            )
                          )
                          )
                        
                        )
  )

