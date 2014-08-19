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
  let d = 0 in
  let e = (size - 1) in
  let rec c i =
    (if (i <= e)
     then (if ((n mod t.(i)) = 0)
           then true
           else (c (i + 1)))
     else false) in
    (c d)
let find n t used nth =
  let rec b n used =
    (if (used <> nth)
     then ((fun  (n, used) -> (b n used)) (if (divisible n t used)
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
    (b n used)
let main =
  let n = 10001 in
  let t = (Array.init_withenv n (fun  i () -> let f = 2 in
  ((), f)) ()) in
  (
    (Printf.printf "%d" (find 3 t 1 n));
    (Printf.printf "%s" "\n")
    )
  

