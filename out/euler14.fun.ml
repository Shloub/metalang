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

let next0 n =
  (if ((n mod 2) = 0)
   then (n / 2)
   else ((3 * n) + 1))
let rec find n m =
  (if (n = 1)
   then 1
   else (if (n >= 1000000)
         then (1 + (find (next0 n) m))
         else (if (m.(n) <> 0)
               then m.(n)
               else (
                      m.(n) <- (1 + (find (next0 n) m));
                      m.(n)
                      )
               )))
let main =
  ((fun  (b, m) -> (
                     b;
                     let max0 = 0 in
                     let maxi = 0 in
                     let rec c i max0 maxi =
                       (if (i <= 999)
                        then (*  normalement on met 999999 mais ça dépasse les int32...  *)
                        let n2 = (find i m) in
                        (if (n2 > max0)
                         then let max0 = n2 in
                         let maxi = i in
                         (c (i + 1) max0 maxi)
                         else (c (i + 1) max0 maxi))
                        else (
                               (Printf.printf "%d\n%d\n" max0 maxi)
                               )
                        ) in
                       (c 1 max0 maxi)
                     )
  ) (Array.init_withenv 1000000 (fun  j () -> let a = 0 in
  ((), a)) ()))

