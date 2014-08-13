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
let rec read_char_line =
  (fun n ->
      let tab = (Array.init_withenv n (fun i n ->
                                          Scanf.scanf "%c"
                                          (fun t ->
                                              let d = t in
                                              (n, d))) n) in
      (Scanf.scanf "%[\n \010]" (fun _ -> tab)));;
let rec programme_candidat =
  (fun tableau taille ->
      let out_ = 0 in
      let b = 0 in
      let c = (taille - 1) in
      let rec a i out_ tableau taille =
        (if (i <= c)
         then let out_ = (out_ + ((int_of_char (tableau.(i))) * i)) in
         begin
           (Printf.printf "%c" tableau.(i));
           (a (i + 1) out_ tableau taille)
           end
         
         else begin
                (Printf.printf "%s" "--\n");
                out_
                end
         ) in
        (a b out_ tableau taille));;
let rec main =
  let taille = (read_int ()) in
  let tableau = (read_char_line taille) in
  begin
    (Printf.printf "%d" (programme_candidat tableau taille));
    (Printf.printf "%s" "\n")
    end
  ;;

