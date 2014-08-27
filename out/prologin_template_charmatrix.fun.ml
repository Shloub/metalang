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

let read_char_matrix x y =
  let tab = (Array.init_withenv y (fun  z () -> let b = (Array.init_withenv x (fun  c () -> Scanf.scanf "%c"
  (fun  d -> let q = d in
  ((), q))) ()) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let p = b in
    ((), p)
    )
  ) ()) in
  tab
let programme_candidat tableau taille_x taille_y =
  let out_ = 0 in
  let m = 0 in
  let o = (taille_y - 1) in
  let rec g i out_ =
    (if (i <= o)
     then let k = 0 in
     let l = (taille_x - 1) in
     let rec h j out_ =
       (if (j <= l)
        then let out_ = (out_ + ((int_of_char (tableau.(i).(j))) * (i + (j * 2)))) in
        (
          (Printf.printf "%c" tableau.(i).(j));
          (h (j + 1) out_)
          )
        
        else (
               (Printf.printf "--\n" );
               (g (i + 1) out_)
               )
        ) in
       (h k out_)
     else out_) in
    (g m out_)
let main =
  let taille_x = (Scanf.scanf "%d " (fun x -> x)) in
  let taille_y = (Scanf.scanf "%d " (fun x -> x)) in
  let tableau = (read_char_matrix taille_x taille_y) in
  (
    (Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y))
    )
  

