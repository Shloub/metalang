let rec read_int_line n =
  let tab = Array.init (n) (fun i ->
    let t = Scanf.scanf "%d" (fun x -> x) in
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    t) in
  tab

let rec read_int_matrix x y =
  let tab = Array.init (y) (fun z ->
    let out_ = read_int_line x in
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    out_) in
  tab

let () =
begin
  let l0 = ref( read_int_line 1 ) in
  let len = ref( (!l0).(0) ) in
  Printf.printf "%d" (!len);
  Printf.printf "%s" "=len\n";
  let tab1 = read_int_line (!len) in
  for i = 0 to (!len) - 1 do
    Printf.printf "%d" i;
    Printf.printf "%s" "=>";
    let a = tab1.(i) in
    Printf.printf "%d" a;
    Printf.printf "%s" "\n"
  done;
  l0 := read_int_line 1;
  len := (!l0).(0);
  let tab2 = read_int_matrix (!len) ((!len) - 1) in
  for i = 0 to (!len) - 2 do
    for j = 0 to (!len) - 1 do
      let b = tab2.(i).(j) in
      Printf.printf "%d" b;
      Printf.printf "%s" " "
    done;
    Printf.printf "%s" "\n"
  done
end
 