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

let position_alphabet c =
  let i = (int_of_char (c)) in
  let e () = () in
  (if ((i <= (int_of_char ('Z'))) && (i >= (int_of_char ('A'))))
   then (i - (int_of_char ('A')))
   else let f () = (e ()) in
   (if ((i <= (int_of_char ('z'))) && (i >= (int_of_char ('a'))))
    then (i - (int_of_char ('a')))
    else (- 1)))
let of_position_alphabet c =
  (char_of_int ((c + (int_of_char ('a')))))
let crypte taille_cle cle taille message =
  let b = 0 in
  let d = (taille - 1) in
  let rec a i =
    (if (i <= d)
     then let lettre = (position_alphabet message.(i)) in
     (
       (if (lettre <> (- 1))
        then let addon = (position_alphabet cle.((i mod taille_cle))) in
        let new_ = ((addon + lettre) mod 26) in
        (
          message.(i) <- (of_position_alphabet new_);
          ()
          )
        
        else ());
       (a (i + 1))
       )
     
     else ()) in
    (a b)
let main =
  Scanf.scanf "%d"
  (fun  taille_cle -> (Scanf.scanf "%[\n \010]" (fun _ -> let cle = (Array.init_withenv taille_cle (fun  index () -> Scanf.scanf "%c"
  (fun  out_ -> let g = out_ in
  ((), g))) ()) in
  (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
  (fun  taille -> (Scanf.scanf "%[\n \010]" (fun _ -> let message = (Array.init_withenv taille (fun  index2 () -> Scanf.scanf "%c"
  (fun  out2 -> let h = out2 in
  ((), h))) ()) in
  (
    (crypte taille_cle cle taille message);
    let k = 0 in
    let l = (taille - 1) in
    let rec j i =
      (if (i <= l)
       then (
              (Printf.printf "%c" message.(i));
              (j (i + 1))
              )
       
       else (Printf.printf "%s" "\n")) in
      (j k)
    )
  ))))))))

