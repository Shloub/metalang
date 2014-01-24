let rec read_int_line n =
  let tab = Array.init (n) (fun i ->
    let t = Scanf.scanf "%d" (fun x -> x) in
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    t) in
  tab

let () =
begin
  let l0 = read_int_line 1 in
  let len = l0.(0) in
  Printf.printf "%d" len;
  Printf.printf "%s" "=len\n";
  let tab1 = read_int_line len in
  for i = 0 to len - 1 do
    Printf.printf "%d" i;
    Printf.printf "%s" "=>";
    let a = tab1.(i) in
    Printf.printf "%d" a;
    Printf.printf "%s" "\n"
  done;
  let tab2 = read_int_line len in
  for i = 0 to len - 1 do
    Printf.printf "%d" i;
    Printf.printf "%s" "=>";
    let b = tab2.(i) in
    Printf.printf "%d" b;
    Printf.printf "%s" "\n"
  done
end
 