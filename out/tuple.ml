let rec f tuple_ =
  let (a, b) = tuple_ in
  (a + 1, b + 1)

let () =
begin
  let _t = f ((0, 1)) in ()
end
 