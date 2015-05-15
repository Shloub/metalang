let rec pgcd a b =
  let c = ((min (a) (b))) in
  let d = ((max (a) (b))) in
  let reste = d mod c in
  if reste = 0
  then c
  else pgcd c reste
let main =
  let top = 1 in
  let bottom = 1 in
  let rec e i bottom top =
    if i <= 9
    then let rec f j bottom top =
           if j <= 9
           then let rec g k bottom top =
                  if k <= 9
                  then if i <> j && j <> k
                       then let a = i * 10 + j in
                       let b = j * 10 + k in
                       if a * k = i * b
                       then ( Printf.printf "%d/%d\n" a b;
                              let top = top * a in
                              let bottom = bottom * b in
                              g (k + 1) bottom top)
                       else g (k + 1) bottom top
                       else g (k + 1) bottom top
                  else f (j + 1) bottom top in
                  g 1 bottom top
           else e (i + 1) bottom top in
           f 1 bottom top
    else ( Printf.printf "%d/%d\n" top bottom;
           let p = pgcd top bottom in
           Printf.printf "pgcd=%d\n%d\n" p (bottom / p)) in
    e 1 bottom top

