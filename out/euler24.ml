let fact n =
  let prod = ref( 1 ) in
  for i = 2 to n do
    prod := (!prod) * i
  done;
  (!prod)

let show lim nth =
  let nth = ref nth in
  let _t = Array.init lim (fun i ->
    i) in
  let pris = Array.make lim false in
  for k = 1 to lim - 1 do
    let n = fact (lim - k) in
    let nchiffre = ref( (!nth) / n ) in
    nth := (!nth) mod n;
    for l = 0 to lim - 1 do
      if not pris.(l) then
        begin
          if (!nchiffre) = 0 then
            begin
              Printf.printf "%d" l;
              pris.(l) <- true
            end;
          nchiffre := (!nchiffre) - 1
        end
    done
  done;
  for m = 0 to lim - 1 do
    if not pris.(m) then
      Printf.printf "%d" m
  done;
  Printf.printf "\n"

let () =
begin
  show 10 999999
end
 