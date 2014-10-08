let f tuple0 =
  ((fun  (a, b) -> ((a + 1), (b + 1))) tuple0)
let main =
  let t = (f (0, 1)) in
  ((fun  (a, b) -> (
                     (Printf.printf "%d -- %d--\n" a b)
                     )
  ) t)

