let rec exp_ =
  (fun a b ->
      (if (b = 0)
       then 1
       else let c = (fun () -> ()) in
       (if ((b mod 2) = 0)
        then let o = (exp_ a (b / 2)) in
        (o * o)
        else (a * (exp_ a (b - 1))))));;
let main =
  let a = 0 in
  let b = 0 in
  Scanf.scanf "%d"
  (fun e ->
      let a = e in
      (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
      (fun d ->
          let b = d in
          (Printf.printf "%d" (exp_ a b))))));;

