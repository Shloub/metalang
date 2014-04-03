
let () =
begin
  let lim = 100 in
  let sum = (lim * (lim + 1)) / 2 in
  let carressum = sum * sum in
  let sumcarres = (lim * (lim + 1) * (2 * lim + 1)) / 6 in
  let a = carressum - sumcarres in
  Printf.printf "%d" a
end
 