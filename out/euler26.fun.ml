let periode restes len a b =
  let rec c a len =
    if a <> 0
    then let chiffre = a / b in
    let reste = a mod b in
    let rec d i =
      if i <= len - 1
      then if restes.(i) = reste
           then len - i
           else d (i + 1)
      else ( restes.(len) <- reste;
             let len = len + 1 in
             let a = reste * 10 in
             c a len) in
      d 0
    else 0 in
    c a len
let main =
  let t = Array.init 1000 (fun j -> 0) in
  let m = 0 in
  let mi = 0 in
  let rec e i m mi =
    if i <= 1000
    then let p = periode t 0 1 i in
    if p > m
    then let mi = i in
    let m = p in
    e (i + 1) m mi
    else e (i + 1) m mi
    else Printf.printf "%d\n%d\n" mi m in
    e 1 m mi

