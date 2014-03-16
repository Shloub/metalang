let rec read_int () =
  let out_ = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  out_

let rec read_int_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%d" (fun x -> x) in
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    t) in
  tab

let rec read_int_matrix x y =
  let tab = Array.init y (fun _z ->
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    read_int_line x) in
  tab

let () =
begin
  let len = ref( (read_int ()) ) in
  Printf.printf "%d" (!len);
  Printf.printf "=len\n";
  let tab1 = read_int_line (!len) in
  for i = 0 to (!len) - 1 do
    Printf.printf "%d" i;
    Printf.printf "=>";
    let a = tab1.(i) in
    Printf.printf "%d" a;
    Printf.printf "\n"
  done;
  len := (read_int ());
  let tab2 = read_int_matrix (!len) ((!len) - 1) in
  for i = 0 to (!len) - 2 do
    for j = 0 to (!len) - 1 do
      let b = tab2.(i).(j) in
      Printf.printf "%d" b;
      Printf.printf " "
    done;
    Printf.printf "\n"
  done
end
 