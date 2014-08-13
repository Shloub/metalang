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

let rec next_ =
  (fun n ->
      let e = (fun n ->
                  ()) in
      (if ((n mod 2) = 0)
       then (n / 2)
       else ((3 * n) + 1)));;
let rec find =
  (fun n m ->
      let b = (fun n m ->
                  ()) in
      (if (n = 1)
       then 1
       else let c = (fun n m ->
                        (b n m)) in
       (if (n >= 1000000)
        then (1 + (find (next_ n) m))
        else let d = (fun n m ->
                         (c n m)) in
        (if (m.(n) <> 0)
         then m.(n)
         else (m.(n) <- (1 + (find (next_ n) m)); m.(n))))));;
let rec main =
  let a = 1000000 in
  let m = (Array.init_withenv a (fun j a ->
                                    let f = 0 in
                                    (a, f)) a) in
  let max_ = 0 in
  let maxi = 0 in
  let k = 1 in
  let l = 999 in
  let rec g i maxi max_ a =
    (if (i <= l)
     then (*  normalement on met 999999 mais ça dépasse les int32...  *)
     let n2 = (find i m) in
     let h = (fun n2 maxi max_ a ->
                 (g (i + 1) maxi max_ a)) in
     (if (n2 > max_)
      then let max_ = n2 in
      let maxi = i in
      (h n2 maxi max_ a)
      else (h n2 maxi max_ a))
     else begin
            (Printf.printf "%d" max_);
            (Printf.printf "%s" "\n");
            (Printf.printf "%d" maxi);
            (Printf.printf "%s" "\n")
            end
     ) in
    (g k maxi max_ a);;

