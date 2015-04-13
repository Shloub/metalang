let montagnes0 tab len =
  let max0 = 1 in
  let j = 1 in
  let i = (len - 2) in
  let rec a i j max0 =
    (if (i >= 0)
     then let x = tab.(i) in
     let rec b j =
       (if ((j >= 0) && (x > tab.((len - j))))
        then let j = (j - 1) in
        (b j)
        else let j = (j + 1) in
        (
          tab.((len - j)) <- x;
          let max0 = (if (j > max0)
                      then j
                      else max0) in
          let i = (i - 1) in
          (a i j max0)
          )
        ) in
       (b j)
     else max0) in
    (a i j max0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  c -> let len = c in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init len (fun  i -> let x = 0 in
    Scanf.scanf "%d"
    (fun  d -> let x = d in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      x
      )
    ))) in
    (Printf.printf "%d" (montagnes0 tab len))
    )
  )

