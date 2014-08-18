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
                                              let g = t in
                                              ((), g)))) ()) in
      (Scanf.scanf "%[\n \010]" (fun _ -> tab)));;
let programme_candidat =
  (fun tableau1 taille1 tableau2 taille2 ->
      let out_ = 0 in
      let e = 0 in
      let f = (taille1 - 1) in
      let rec d i out_ =
        (if (i <= f)
         then let out_ = (out_ + ((int_of_char (tableau1.(i))) * i)) in
         (
           (Printf.printf "%c" tableau1.(i));
           (d (i + 1) out_)
           )
         
         else (
                (Printf.printf "%s" "--\n");
                let b = 0 in
                let c = (taille2 - 1) in
                let rec a j out_ =
                  (if (j <= c)
                   then let out_ = (out_ + ((int_of_char (tableau2.(j))) * (j * 100))) in
                   (
                     (Printf.printf "%c" tableau2.(j));
                     (a (j + 1) out_)
                     )
                   
                   else (
                          (Printf.printf "%s" "--\n");
                          out_
                          )
                   ) in
                  (a b out_)
                )
         ) in
        (d e out_));;
let main =
  let taille1 = (read_int ()) in
  let tableau1 = (read_char_line taille1) in
  let taille2 = (read_int ()) in
  let tableau2 = (read_char_line taille2) in
  (
    (Printf.printf "%d" (programme_candidat tableau1 taille1 tableau2 taille2));
    (Printf.printf "%s" "\n")
    )
  ;;

