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

let divisible n t size =
  let c = (size - 1) in
  let rec b i =
    (if (i <= c)
     then (if ((n mod t.(i)) = 0)
           then true
           else (b (i + 1)))
     else false) in
    (b 0)
let find n t used nth =
  let rec a n used =
    (if (used <> nth)
     then (if (divisible n t used)
           then let n = (n + 1) in
           (a n used)
           else (
                  t.(used) <- n;
                  let n = (n + 1) in
                  let used = (used + 1) in
                  (a n used)
                  )
           )
     else t.((used - 1))) in
    (a n used)
let main =
  let n = 10001 in
  ((fun  (e, t) -> (
                     e;
                     (Printf.printf "%d\n" (find 3 t 1 n))
                     )
  ) (Array.init_withenv n (fun  i () -> let d = 2 in
  ((), d)) ()))

