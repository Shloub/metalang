let eratostene t max0 =
  let sum = 0 in
  let c = (max0 - 1) in
  let rec a i sum =
    (if (i <= c)
     then (if (t.(i) = i)
           then let sum = (sum + i) in
           (if ((max0 / i) > i)
            then let j = (i * i) in
            let rec b j =
              (if ((j < max0) && (j > 0))
               then (
                      t.(j) <- 0;
                      let j = (j + i) in
                      (b j)
                      )
               
               else (a (i + 1) sum)) in
              (b j)
            else (a (i + 1) sum))
           else (a (i + 1) sum))
     else sum) in
    (a 2 sum)
let main =
  let n = 100000 in
  (*  normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages  *)
  let t = (Array.init n (fun  i -> i)) in
  (
    t.(1) <- 0;
    (Printf.printf "%d\n" (eratostene t n))
    )
  

