(* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
*)
let rec find0 len tab cache x y =
  (*
	Cette fonction est récursive
	*)
  if y = len - 1 then
    tab.(y).(x)
  else
    if x > y then
      - 10000
    else
      if cache.(y).(x) <> 0 then
        cache.(y).(x)
      else
        begin
           let result = ref( 0 ) in
           let out0 = find0 len tab cache x (y + 1) in
           let out1 = find0 len tab cache (x + 1) (y + 1) in
           if out0 > out1 then
             result := out0 + tab.(y).(x)
           else
             result := out1 + tab.(y).(x);
           cache.(y).(x) <- (!result);
           (!result)
        end
let find len tab =
  let tab2 = Array.init len (fun i ->
    let tab3 = Array.init (i + 1) (fun j ->
      0) in
    tab3) in
  find0 len tab tab2 0 0
let () =
 let len = 0 in
  let len = Scanf.scanf "%d " (fun len -> len) in
  let tab = Array.init len (fun i ->
    let tab2 = Array.init (i + 1) (fun j ->
      let tmp = ref( 0 ) in
      Scanf.scanf "%d " (fun c -> tmp := c);
      (!tmp)) in
    tab2) in
  Printf.printf "%d\n" (find len tab);
  for k = 0 to len - 1 do
    for l = 0 to k do
      Printf.printf "%d " tab.(k).(l)
    done;
    Printf.printf "\n"
  done 
 