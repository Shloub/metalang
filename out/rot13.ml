

(*
Ce test effectue un rot13 sur une chaine lue en entrée
*)
let () =
begin
  let strlen = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let tab4 = Array.init (strlen) (fun _toto ->
    let tmpc = Scanf.scanf "%c" (fun x -> x) in
    let c = ref( int_of_char (tmpc) ) in
    if tmpc <> ' ' then
      c := (((!c) - int_of_char ('a')) + 13) mod 26 + int_of_char ('a');
    char_of_int ((!c))) in
  for j = 0 to strlen - 1 do
    let a = tab4.(j) in
    Printf.printf "%c" a
  done
end
 