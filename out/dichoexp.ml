let rec exp0 a b =
  if b = 0 then
    1
  else if b mod 2 = 0 then
    begin
      let o = exp0 a (b / 2) in
      o * o
    end
  else
    a * exp0 a (b - 1)

let () =
begin
  let a = 0 in
  let b = 0 in
  let a, b = Scanf.scanf "%d %d" (fun a b -> a, b) in
  Printf.printf "%d" (exp0 a b)
end
 