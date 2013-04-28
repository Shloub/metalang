(* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
*)
let rec find0 len tab cache x y =
  (*
	Cette fonction est récursive
	*)
  if y = (len - 1) then
    tab.(y).(x)
  else if x > y then
    100000
  else if cache.(y).(x) <> 0 then
    cache.(y).(x)
  else
    begin
      let result = ref( 0 ) in
      let out0 = find0 len tab cache x (y + 1) in
      let out1 = find0 len tab cache (x + 1) (y + 1) in
      if out0 < out1 then
        result := out0 + tab.(y).(x)
      else
        result := out1 + tab.(y).(x);
      cache.(y).(y) <- (!result);
      (!result)
    end

let rec find len tab =
  let tab2 = Array.init (len) (fun i ->
    let be = i + 1 in
    let tab3 = Array.init (be) (fun j ->
      0) in
    tab3) in
  find0 len tab tab2 0 0

let () =
begin
  let len = ref( 0 ) in
  Scanf.scanf "%d" (fun value -> len := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let tab = Array.init ((!len)) (fun i ->
    let bf = i + 1 in
    let tab2 = Array.init (bf) (fun j ->
      let tmp = ref( 0 ) in
      Scanf.scanf "%d" (fun value -> tmp := value);
      Scanf.scanf "%[\n \010]" (fun _ -> ());
      (!tmp)) in
    tab2) in
  let bg = find (!len) tab in
  Printf.printf "%d" bg;
  for i = 0 to (!len) - 1 do
    for j = 0 to i do
      let bh = tab.(i).(j) in
      Printf.printf "%d" bh
    done;
    Printf.printf "%s" "\n"
  done
end
 