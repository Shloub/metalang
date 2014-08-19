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

let read_int () =
  Scanf.scanf "%d"
  (fun  out_ -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  out_
                  )
  )
let read_int_line n =
  let tab = (Array.init_withenv n (fun  i () -> Scanf.scanf "%d"
  (fun  t -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let h = t in
               ((), h)
               )
  )) ()) in
  tab
let read_int_matrix x y =
  let tab = (Array.init_withenv y (fun  z () -> let g = (read_int_line x) in
  ((), g)) ()) in
  tab
let programme_candidat tableau x y =
  let out_ = 0 in
  let e = 0 in
  let f = (y - 1) in
  let rec a i out_ =
    (if (i <= f)
     then let c = 0 in
     let d = (x - 1) in
     let rec b j out_ =
       (if (j <= d)
        then let out_ = (out_ + (tableau.(i).(j) * ((i * 2) + j))) in
        (b (j + 1) out_)
        else (a (i + 1) out_)) in
       (b c out_)
     else out_) in
    (a e out_)
let main =
  let taille_x = (read_int ()) in
  let taille_y = (read_int ()) in
  let tableau = (read_int_matrix taille_x taille_y) in
  (
    (Printf.printf "%d" (programme_candidat tableau taille_x taille_y));
    (Printf.printf "%s" "\n")
    )
  

