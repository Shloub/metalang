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

let next_ n =
  let e () = () in
  (if ((n mod 2) = 0)
   then (n / 2)
   else ((3 * n) + 1))
let rec find n m =
  let b () = () in
  (if (n = 1)
   then 1
   else let c () = (b ()) in
   (if (n >= 1000000)
    then (1 + (find (next_ n) m))
    else let d () = (c ()) in
    (if (m.(n) <> 0)
     then m.(n)
     else (
            m.(n) <- (1 + (find (next_ n) m));
            m.(n)
            )
     )))
let main =
  let a = 1000000 in
  let m = (Array.init_withenv a (fun  j () -> let f = 0 in
  ((), f)) ()) in
  let max_ = 0 in
  let maxi = 0 in
  let h = 1 in
  let k = 999 in
  let rec g i max_ maxi =
    (if (i <= k)
     then (*  normalement on met 999999 mais ça dépasse les int32...  *)
     let n2 = (find i m) in
     ((fun  (max_, maxi) -> (g (i + 1) max_ maxi)) (if (n2 > max_)
                                                    then let max_ = n2 in
                                                    let maxi = i in
                                                    (max_, maxi)
                                                    else (max_, maxi)))
     else (
            (Printf.printf "%d" max_);
            (Printf.printf "%s" "\n");
            (Printf.printf "%d" maxi);
            (Printf.printf "%s" "\n")
            )
     ) in
    (g h max_ maxi)

