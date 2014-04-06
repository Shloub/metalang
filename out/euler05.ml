let max2 a b =
  if a > b then
    a
  else
    b

let primesfactors n =
  let n = ref n in
  let c = (!n) + 1 in
  let tab = Array.init c (fun _i ->
    0) in
  let d = ref( 2 ) in
  while (!n) <> 1 && (!d) * (!d) <= (!n)
  do
      if ((!n) mod (!d)) = 0 then
        begin
          tab.((!d)) <- tab.((!d)) + 1;
          n := (!n) / (!d)
        end
      else
        d := (!d) + 1
  done;
  tab.((!n)) <- tab.((!n)) + 1;
  tab

let () =
begin
  let lim = 20 in
  let e = lim + 1 in
  let o = Array.init e (fun _m ->
    0) in
  for i = 1 to lim do
    let t = primesfactors i in
    for j = 1 to i do
      o.(j) <- max2 o.(j) t.(j)
    done
  done;
  let product = ref( 1 ) in
  for k = 1 to lim do
    for _l = 1 to o.(k) do
      product := (!product) * k
    done
  done;
  Printf.printf "%d" (!product);
  Printf.printf "\n"
end
 