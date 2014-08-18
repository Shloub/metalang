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
  (fun () -> Scanf.scanf "%d"
  (fun out_ ->
      (Scanf.scanf "%[\n \010]" (fun _ -> out_))));;
let rec read_int_line =
  (fun n ->
      let tab = (Array.init_withenv n (fun i n ->
                                          Scanf.scanf "%d"
                                          (fun t ->
                                              (Scanf.scanf "%[\n \010]" (fun _ -> let h = t in
                                              (n, h))))) n) in
      tab);;
let rec read_int_matrix =
  (fun x y ->
      let tab = (Array.init_withenv y (fun z ->
                                          (fun (x, y) ->
                                              let g = (read_int_line x) in
                                              ((x, y), g))) (x, y)) in
      tab);;
let rec programme_candidat =
  (fun tableau x y ->
      let out_ = 0 in
      let e = 0 in
      let f = (y - 1) in
      let rec a i out_ tableau x y =
        (if (i <= f)
         then let c = 0 in
         let d = (x - 1) in
         let rec b j out_ tableau x y =
           (if (j <= d)
            then let out_ = (out_ + (tableau.(i).(j) * ((i * 2) + j))) in
            (b (j + 1) out_ tableau x y)
            else (a (i + 1) out_ tableau x y)) in
           (b c out_ tableau x y)
         else out_) in
        (a e out_ tableau x y));;
let rec main =
  let taille_x = (read_int ()) in
  let taille_y = (read_int ()) in
  let tableau = (read_int_matrix taille_x taille_y) in
  begin
    (Printf.printf "%d" (programme_candidat tableau taille_x taille_y));
    (Printf.printf "%s" "\n")
    end
  ;;
