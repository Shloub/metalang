let h =
  (fun i ->
      (*   for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end  *)
      let j = (i - 2) in
      let rec b j =
        (if (j <= (i + 2))
         then (if ((i mod j) = 5)
               then true
               else let j = (j + 1) in
               (b j))
         else false) in
        (b j));;
let main =
  let j = 0 in
  let f = 0 in
  let g = 10 in
  let rec e k j =
    (if (k <= g)
     then let j = (j + k) in
     (
       (Printf.printf "%d" j);
       (Printf.printf "%s" "\n");
       (e (k + 1) j)
       )
     
     else let i = 4 in
     let rec d i j =
       (if (i < 10)
        then (
               (Printf.printf "%d" i);
               let i = (i + 1) in
               let j = (j + i) in
               (d i j)
               )
        
        else (
               (Printf.printf "%d" j);
               (Printf.printf "%d" i);
               (Printf.printf "%s" "FIN TEST\n")
               )
        ) in
       (d i j)) in
    (e f j);;

