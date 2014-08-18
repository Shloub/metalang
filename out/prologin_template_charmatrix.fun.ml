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

let read_int =
  (fun () -> Scanf.scanf "%d"
  (fun out_ ->
      (Scanf.scanf "%[\n \010]" (fun _ -> out_))));;
let read_char_line =
  (fun n ->
      let tab = (Array.init_withenv n (fun i ->
                                          (fun () -> Scanf.scanf "%c"
                                          (fun t ->
                                              let h = t in
                                              ((), h)))) ()) in
      (Scanf.scanf "%[\n \010]" (fun _ -> tab)));;
let read_char_matrix =
  (fun x y ->
      let tab = (Array.init_withenv y (fun z ->
                                          (fun () -> let g = (read_char_line x) in
                                          ((), g))) ()) in
      tab);;
let programme_candidat =
  (fun tableau taille_x taille_y ->
      let out_ = 0 in
      let e = 0 in
      let f = (taille_y - 1) in
      let rec a i out_ =
        (if (i <= f)
         then let c = 0 in
         let d = (taille_x - 1) in
         let rec b j out_ =
           (if (j <= d)
            then let out_ = (out_ + ((int_of_char (tableau.(i).(j))) * (i + (j * 2)))) in
            (
              (Printf.printf "%c" tableau.(i).(j));
              (b (j + 1) out_)
              )
            
            else (
                   (Printf.printf "%s" "--\n");
                   (a (i + 1) out_)
                   )
            ) in
           (b c out_)
         else out_) in
        (a e out_));;
let main =
  let taille_x = (read_int ()) in
  let taille_y = (read_int ()) in
  let tableau = (read_char_matrix taille_x taille_y) in
  (
    (Printf.printf "%d" (programme_candidat tableau taille_x taille_y));
    (Printf.printf "%s" "\n")
    )
  ;;

