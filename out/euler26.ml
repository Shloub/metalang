exception Found_1 of int

let periode restes len a b =
  let len = ref len in
  let a = ref a in
  try
  while (!a) <> 0
  do
      let _chiffre = (!a) / b in
      let reste = (!a) mod b in
      for i = 0 to (!len) - 1 do
        if restes.(i) = reste then
          raise (Found_1((!len) - i))
      done;
      restes.((!len)) <- reste;
      len := (!len) + 1;
      a := reste * 10
  done;
  raise (Found_1(0))
  with Found_1 (out) -> out

let () =
begin
  let c = 1000 in
  let t = Array.init c (fun _j ->
    0) in
  let m = ref( 0 ) in
  let mi = ref( 0 ) in
  for i = 1 to 1000 do
    let p = periode t 0 1 i in
    if p > (!m) then
      begin
        mi := i;
        m := p
      end
  done;
  Printf.printf "%d" (!mi);
  Printf.printf "\n";
  Printf.printf "%d" (!m);
  Printf.printf "\n"
end
 