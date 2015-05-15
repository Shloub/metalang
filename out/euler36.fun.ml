module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let palindrome2 pow2 n =
  let t = Array.init 20 (fun i -> n / pow2.(i) mod 2 = 1) in
  let nnum = 0 in
  let rec e j nnum =
    if j <= 19
    then if t.(j)
         then let nnum = j in
         e (j + 1) nnum
         else e (j + 1) nnum
    else let rec f k =
           if k <= nnum / 2
           then if t.(k) <> t.(nnum - k)
                then false
                else f (k + 1)
           else true in
           f 0 in
    e 1 nnum
let main =
  let p = 1 in
  (fun (p, pow2) ->let sum = 0 in
                   let rec h d sum =
                     if d <= 9
                     then let sum = if palindrome2 pow2 d
                                    then ( Printf.printf "%d\n" d;
                                           sum + d)
                                    else sum in
                     if palindrome2 pow2 (d * 10 + d)
                     then ( Printf.printf "%d\n" (d * 10 + d);
                            let sum = sum + d * 10 + d in
                            h (d + 1) sum)
                     else h (d + 1) sum
                     else let rec l a0 sum =
                            if a0 <= 4
                            then let a = a0 * 2 + 1 in
                            let rec m b sum =
                              if b <= 9
                              then let rec o c sum =
                                     if c <= 9
                                     then let num0 = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a in
                                     let sum = if palindrome2 pow2 num0
                                               then ( Printf.printf "%d\n" num0;
                                                      sum + num0)
                                               else sum in
                                     let num1 = a * 10000 + b * 1000 + c * 100 + b * 10 + a in
                                     if palindrome2 pow2 num1
                                     then ( Printf.printf "%d\n" num1;
                                            let sum = sum + num1 in
                                            o (c + 1) sum)
                                     else o (c + 1) sum
                                     else let num2 = a * 100 + b * 10 + a in
                                     let sum = if palindrome2 pow2 num2
                                               then ( Printf.printf "%d\n" num2;
                                                      sum + num2)
                                               else sum in
                                     let num3 = a * 1000 + b * 100 + b * 10 + a in
                                     if palindrome2 pow2 num3
                                     then ( Printf.printf "%d\n" num3;
                                            let sum = sum + num3 in
                                            m (b + 1) sum)
                                     else m (b + 1) sum in
                                     o 0 sum
                              else l (a0 + 1) sum in
                              m 0 sum
                            else Printf.printf "sum=%d\n" sum in
                            l 0 sum in
                     h 1 sum) (Array.init_withenv 20 (fun i p -> let p = p * 2 in
  let g = p / 2 in
  p, g) p)

