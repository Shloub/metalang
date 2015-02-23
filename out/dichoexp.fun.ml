let rec exp0 a b =
  (if (b = 0)
   then 1
   else (if ((b mod 2) = 0)
         then let o = (exp0 a (b / 2)) in
         (o * o)
         else (a * (exp0 a (b - 1)))))
let main =
  let a = 0 in
  let b = 0 in
  Scanf.scanf "%d"
  (fun  d -> let a = d in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    Scanf.scanf "%d"
    (fun  c -> let b = c in
    (Printf.printf "%d" (exp0 a b)))
    )
  )

