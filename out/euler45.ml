let triangle n =
  if n mod 2 = 0 then
    (n / 2) * (n + 1)
  else
    n * ((n + 1) / 2)

let penta n =
  if n mod 2 = 0 then
    (n / 2) * (3 * n - 1)
  else
    ((3 * n - 1) / 2) * n

let hexa n =
  n * (2 * n - 1)

let rec findPenta2 n a b =
  if b = a + 1 then
    penta a = n || penta b = n
  else
    begin
      let c = (a + b) / 2 in
      let p = penta c in
      if p = n then
        true
      else if p < n then
        findPenta2 n c b
      else
        findPenta2 n a c
    end

let rec findHexa2 n a b =
  if b = a + 1 then
    hexa a = n || hexa b = n
  else
    begin
      let c = (a + b) / 2 in
      let p = hexa c in
      if p = n then
        true
      else if p < n then
        findHexa2 n c b
      else
        findHexa2 n a c
    end

let () =
begin
  for n = 285 to 55385 do
    let t = triangle n in
    if findPenta2 t (n / 5) n && findHexa2 t (n / 5) (n / 2 + 10) then
      Printf.printf "%d\n%d\n" n t
  done
end
 