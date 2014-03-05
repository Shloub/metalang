exception Found_1 of bool

let rec devine_ nombre tab len =
  try
  let min_ = ref( tab.(0) ) in
  let max_ = ref( tab.(1) ) in
  for i = 2 to len - 1 do
    Printf.printf "%d" i;
    Printf.printf " => ";
    let a = tab.(i) in
    Printf.printf "%d" a;
    Printf.printf "\n";
    if tab.(i) > (!max_) or tab.(i) < (!min_) then
      raise (Found_1(false));
    if tab.(i) < nombre then
      min_ := tab.(i);
    if tab.(i) > nombre then
      max_ := tab.(i);
    if tab.(i) = nombre && len <> i + 1 then
      raise (Found_1(false))
  done;
  raise (Found_1(true))
  with Found_1 (out) -> out

let () =
begin
  let nombre = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let len = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Printf.printf "%d" nombre;
  Printf.printf " ";
  Printf.printf "%d" len;
  Printf.printf "\n";
  let tab = Array.init len (fun _i ->
    let tmp = Scanf.scanf "%d" (fun x -> x) in
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    Printf.printf "%d" tmp;
    Printf.printf " ";
    tmp) in
  Printf.printf "\n";
  let b = devine_ nombre tab len in
  if b then
    Printf.printf "True"
  else
    Printf.printf "False"
end
 