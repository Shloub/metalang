

let rec read_int () =
  let out_ = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  out_

let rec read_int_line n =
  let tab = Array.init n (fun _i ->
    let t_ = Scanf.scanf "%d" (fun x -> x) in
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    t_) in
  tab

let rec read_char_line n =
  let tab = Array.init n (fun _i ->
    let t_ = Scanf.scanf "%c" (fun x -> x) in
    t_) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  tab

(*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*)
let () =
begin
  let len = (read_int ()) in
  Printf.printf "%d" len;
  Printf.printf "=len\n";
  let tab = read_int_line len in
  for i = 0 to len - 1 do
    Printf.printf "%d" i;
    Printf.printf "=>";
    let a = tab.(i) in
    Printf.printf "%d" a;
    Printf.printf " "
  done;
  Printf.printf "\n";
  let tab2 = read_int_line len in
  for i_ = 0 to len - 1 do
    Printf.printf "%d" i_;
    Printf.printf "==>";
    let b = tab2.(i_) in
    Printf.printf "%d" b;
    Printf.printf " "
  done;
  let strlen = (read_int ()) in
  Printf.printf "%d" strlen;
  Printf.printf "=strlen\n";
  let tab4 = read_char_line strlen in
  for i3 = 0 to strlen - 1 do
    let tmpc = tab4.(i3) in
    let c = ref( int_of_char (tmpc) ) in
    Printf.printf "%c" tmpc;
    Printf.printf ":";
    Printf.printf "%d" (!c);
    Printf.printf " ";
    if tmpc <> ' ' then
      c := (((!c) - int_of_char ('a')) + 13) mod 26 + int_of_char ('a');
    tab4.(i3) <- char_of_int ((!c))
  done;
  for j = 0 to strlen - 1 do
    let d = tab4.(j) in
    Printf.printf "%c" d
  done
end
 