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

let divisible n t size =
  let c = 0 in
  let d = (size - 1) in
  let rec b i =
    (if (i <= d)
     then (if ((n mod t.(i)) = 0)
           then true
           else (b (i + 1)))
     else false) in
    (b c)
let find n t used nth =
  let rec a n used =
    (if (used <> nth)
     then ((fun  (n, used) -> (a n used)) (if (divisible n t used)
                                           then let n = (n + 1) in
                                           (n, used)
                                           else (
                                                  t.(used) <- n;
                                                  let n = (n + 1) in
                                                  let used = (used + 1) in
                                                  (n, used)
                                                  )
                                           ))
     else t.((used - 1))) in
    (a n used)
let main =
  let n = 10001 in
  let t = (Array.init_withenv n (fun  i () -> let e = 2 in
  ((), e)) ()) in
  (
    (Printf.printf "%d\n" (find 3 t 1 n))
    )
  

