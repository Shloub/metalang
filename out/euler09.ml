
let () =
 (*
	a + b + c = 1000 && a * a + b * b = c * c
	*)
  for a = 1 to 1000 do
    for b = a + 1 to 1000 do
      let c = 1000 - a - b in
      let a2b2 = a * a + b * b in
      let cc = c * c in
      if cc = a2b2 && c > a then
        Printf.printf "%d\n%d\n%d\n%d\n" a b c (a * b * c)
    done
  done 
 