module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let next0 n =
  let d () = () in
  (if ((n mod 2) = 0)
   then (n / 2)
   else ((3 * n) + 1))
let rec find n m =
  let a () = () in
  (if (n = 1)
   then 1
   else let b () = (a ()) in
   (if (n >= 1000000)
    then (1 + (find (next0 n) m))
    else let c () = (b ()) in
    (if (m.(n) <> 0)
     then m.(n)
     else (
            m.(n) <- (1 + (find (next0 n) m));
            m.(n)
            )
     )))
let main =
  let m = (Array.init_withenv 1000000 (fun  j () -> let e = 0 in
  ((), e)) ()) in
  let max0 = 0 in
  let maxi = 0 in
  let g = 1 in
  let h = 999 in
  let rec f i max0 maxi =
    (if (i <= h)
     then (*  normalement on met 999999 mais ça dépasse les int32...  *)
     let n2 = (find i m) in
     ((fun  (max0, maxi) -> (f (i + 1) max0 maxi)) (if (n2 > max0)
                                                    then let max0 = n2 in
                                                    let maxi = i in
                                                    (max0, maxi)
                                                    else (max0, maxi)))
     else (
            (Printf.printf "%d\n%d\n" max0 maxi)
            )
     ) in
    (f g max0 maxi)

