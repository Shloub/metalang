let f tuple0 =
  let (a, b) = tuple0 in
  (a + 1, b + 1)

let () =
begin
  let t = f (0, 1) in
  let (a, b) = t in
  Printf.printf "%d -- %d--\n" a b
end
 