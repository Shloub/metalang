let summax lst len =
  let current = 0 in
  let max0 = 0 in
  let rec a i current max0 =
    (if (i <= (len - 1))
     then let current = (current + lst.(i)) in
     let current = (if (current < 0)
                    then let current = 0 in
                    current
                    else current) in
     (if (max0 < current)
      then let max0 = current in
      (a (i + 1) current max0)
      else (a (i + 1) current max0))
     else max0) in
    (a 0 current max0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  e -> let len = e in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init len (fun  i -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  d -> let tmp = d in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      tmp
      )
    ))) in
    let result = (summax tab len) in
    (Printf.printf "%d" result)
    )
  )

