let main =
  (* 
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17
Find the sum of all 0 to 9 pandigital numbers with this property.

d4 % 2 == 0
(d3 + d4 + d5) % 3 == 0
d6 = 5 ou d6 = 0
(d5 * 100 + d6 * 10 + d7  ) % 7 == 0
(d6 * 100 + d7 * 10 + d8  ) % 11 == 0
(d7 * 100 + d8 * 10 + d9  ) % 13 == 0
(d8 * 100 + d9 * 10 + d10 ) % 17 == 0


d4 % 2 == 0
d6 = 5 ou d6 = 0

(d3 + d4 + d5) % 3 == 0
(d5 * 2 + d6 * 3 + d7) % 7 == 0
 *)
  let allowed = (Array.init 10 (fun  i -> true)) in
  let rec a i6 =
    (if (i6 <= 1)
     then let d6 = (i6 * 5) in
     (if allowed.(d6)
      then (
             allowed.(d6) <- false;
             let rec b d7 =
               (if (d7 <= 9)
                then (if allowed.(d7)
                      then (
                             allowed.(d7) <- false;
                             let rec c d8 =
                               (if (d8 <= 9)
                                then (if allowed.(d8)
                                      then (
                                             allowed.(d8) <- false;
                                             let rec d d9 =
                                               (if (d9 <= 9)
                                                then (if allowed.(d9)
                                                      then (
                                                             allowed.(d9) <- false;
                                                             let rec e d10 =
                                                               (if (d10 <= 9)
                                                                then (if (((allowed.(d10) && (((((d6 * 100) + (d7 * 10)) + d8) mod 11) = 0)) && (((((d7 * 100) + (d8 * 10)) + d9) mod 13) = 0)) && (((((d8 * 100) + (d9 * 10)) + d10) mod 17) = 0))
                                                                      then (
                                                                             allowed.(d10) <- false;
                                                                             let rec f d5 =
                                                                               (if (d5 <= 9)
                                                                                then (
                                                                                if allowed.(d5)
                                                                                then 
                                                                                (
                                                                                allowed.(d5) <- false;
                                                                                (if (((((d5 * 100) + (d6 * 10)) + d7) mod 7) = 0)
                                                                                then 
                                                                                let rec g i4 =
                                                                                (if (i4 <= 4)
                                                                                then let d4 = (i4 * 2) in
                                                                                (if allowed.(d4)
                                                                                then 
                                                                                (
                                                                                allowed.(d4) <- false;
                                                                                let rec h d3 =
                                                                                (if (d3 <= 9)
                                                                                then (
                                                                                if allowed.(d3)
                                                                                then 
                                                                                (
                                                                                allowed.(d3) <- false;
                                                                                (if ((((d3 + d4) + d5) mod 3) = 0)
                                                                                then 
                                                                                let rec j d2 =
                                                                                (if (d2 <= 9)
                                                                                then (
                                                                                if allowed.(d2)
                                                                                then 
                                                                                (
                                                                                allowed.(d2) <- false;
                                                                                let rec k d1 =
                                                                                (if (d1 <= 9)
                                                                                then (
                                                                                if allowed.(d1)
                                                                                then 
                                                                                (
                                                                                allowed.(d1) <- false;
                                                                                (Printf.printf "%d%d%d%d%d%d%d%d%d%d + " d1 d2 d3 d4 d5 d6 d7 d8 d9 d10);
                                                                                allowed.(d1) <- true;
                                                                                (k (d1 + 1))
                                                                                )
                                                                                
                                                                                else (k (d1 + 1)))
                                                                                else 
                                                                                (
                                                                                allowed.(d2) <- true;
                                                                                (j (d2 + 1))
                                                                                )
                                                                                ) in
                                                                                (k 0)
                                                                                )
                                                                                
                                                                                else (j (d2 + 1)))
                                                                                else ()) in
                                                                                (j 0)
                                                                                else ());
                                                                                allowed.(d3) <- true;
                                                                                (h (d3 + 1))
                                                                                )
                                                                                
                                                                                else (h (d3 + 1)))
                                                                                else 
                                                                                (
                                                                                allowed.(d4) <- true;
                                                                                (g (i4 + 1))
                                                                                )
                                                                                ) in
                                                                                (h 0)
                                                                                )
                                                                                
                                                                                else (g (i4 + 1)))
                                                                                else ()) in
                                                                                (g 0)
                                                                                else ());
                                                                                allowed.(d5) <- true;
                                                                                (f (d5 + 1))
                                                                                )
                                                                                
                                                                                else (f (d5 + 1)))
                                                                                else 
                                                                                (
                                                                                allowed.(d10) <- true;
                                                                                (e (d10 + 1))
                                                                                )
                                                                                ) in
                                                                               (f 0)
                                                                             )
                                                                      
                                                                      else (e (d10 + 1)))
                                                                else (
                                                                       allowed.(d9) <- true;
                                                                       (d (d9 + 1))
                                                                       )
                                                                ) in
                                                               (e 1)
                                                             )
                                                      
                                                      else (d (d9 + 1)))
                                                else (
                                                       allowed.(d8) <- true;
                                                       (c (d8 + 1))
                                                       )
                                                ) in
                                               (d 0)
                                             )
                                      
                                      else (c (d8 + 1)))
                                else (
                                       allowed.(d7) <- true;
                                       (b (d7 + 1))
                                       )
                                ) in
                               (c 0)
                             )
                      
                      else (b (d7 + 1)))
                else (
                       allowed.(d6) <- true;
                       (a (i6 + 1))
                       )
                ) in
               (b 0)
             )
      
      else (a (i6 + 1)))
     else (Printf.printf "%d\n" 0)) in
    (a 0)

