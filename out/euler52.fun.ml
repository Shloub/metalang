let rec chiffre_sort a =
  if a < 10
  then a
  else let b = chiffre_sort (a / 10) in
  let c = a mod 10 in
  let d = b mod 10 in
  let e = b / 10 in
  if c < d
  then c + b * 10
  else d + chiffre_sort (c + e * 10) * 10
let same_numbers a b c d e f =
  let ca = chiffre_sort a in
  ca = chiffre_sort b && ca = chiffre_sort c && ca = chiffre_sort d && ca = chiffre_sort e && ca = chiffre_sort f
let main =
  let num = 142857 in
  if same_numbers num (num * 2) (num * 3) (num * 4) (num * 6) (num * 5)
  then Printf.printf "%d %d %d %d %d %d\n" num (num * 2) (num * 3) (num * 4) (num * 5) (num * 6)
  else ()

