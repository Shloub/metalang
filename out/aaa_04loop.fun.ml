let h i =
  (*   for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end  *)
  let j = (i - 2) in
  let rec a j =
    (if (j <= (i + 2))
     then (if ((i mod j) = 5)
           then true
           else let j = (j + 1) in
           (a j))
     else false) in
    (a j)
let main =
  let j = 0 in
  let d = 0 in
  let e = 10 in
  let rec c k j =
    (if (k <= e)
     then let j = (j + k) in
     (
       (Printf.printf "%d\n" j);
       (c (k + 1) j)
       )
     
     else let i = 4 in
     let rec b i j =
       (if (i < 10)
        then (
               (Printf.printf "%d" i);
               let i = (i + 1) in
               let j = (j + i) in
               (b i j)
               )
        
        else (
               (Printf.printf "%d%dFIN TEST\n" j i)
               )
        ) in
       (b i j)) in
    (c d j)

