let rec okdigits ok n =
  if n = 0
  then true
  else let digit = n mod 10 in
  if ok.(digit)
  then ( ok.(digit) <- false;
         let o = okdigits ok (n / 10) in
         ( ok.(digit) <- true;
           o))
  else false
let main =
  let count = 0 in
  let allowed = Array.init 10 (fun i -> i <> 0) in
  let counted = Array.init 100000 (fun j -> false) in
  let rec f e count =
    if e <= 9
    then ( allowed.(e) <- false;
           let rec g b count =
             if b <= 9
             then if allowed.(b)
                  then ( allowed.(b) <- false;
                         let be = b * e mod 10 in
                         let count = if allowed.(be)
                                     then ( allowed.(be) <- false;
                                            let rec h a count =
                                              if a <= 9
                                              then if allowed.(a)
                                                   then ( allowed.(a) <- false;
                                                          let rec k c count =
                                                            if c <= 9
                                                            then if allowed.(c)
                                                                 then ( allowed.(c) <- false;
                                                                        let rec l d count =
                                                                          if d <= 9
                                                                          then if allowed.(d)
                                                                               then ( 
                                                                               allowed.(d) <- false;
                                                                               (*  2 * 3 digits  *)
                                                                               let product = (a * 10 + b) * (c * 100 + d * 10 + e) in
                                                                               let count = 
                                                                               if not counted.(product) && okdigits allowed (product / 10)
                                                                               then ( 
                                                                               counted.(product) <- true;
                                                                               let count = count + product in
                                                                               ( 
                                                                               Printf.printf "%d " product;
                                                                               count))
                                                                               else count in
                                                                               (*  1  * 4 digits  *)
                                                                               let product2 = b * (a * 1000 + c * 100 + d * 10 + e) in
                                                                               let count = 
                                                                               if not counted.(product2) && okdigits allowed (product2 / 10)
                                                                               then ( 
                                                                               counted.(product2) <- true;
                                                                               let count = count + product2 in
                                                                               ( 
                                                                               Printf.printf "%d " product2;
                                                                               count))
                                                                               else count in
                                                                               ( 
                                                                               allowed.(d) <- true;
                                                                               l (d + 1) count))
                                                                               else l (d + 1) count
                                                                          else ( 
                                                                          allowed.(c) <- true;
                                                                          k (c + 1) count) in
                                                                          l 1 count)
                                                                 else k (c + 1) count
                                                            else ( allowed.(a) <- true;
                                                                   h (a + 1) count) in
                                                            k 1 count)
                                                   else h (a + 1) count
                                              else ( allowed.(be) <- true;
                                                     count) in
                                              h 1 count)
                                     else count in
                         ( allowed.(b) <- true;
                           g (b + 1) count))
                  else g (b + 1) count
             else ( allowed.(e) <- true;
                    f (e + 1) count) in
             g 1 count)
    else Printf.printf "%d\n" count in
    f 1 count

