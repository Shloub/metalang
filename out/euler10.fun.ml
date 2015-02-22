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

let eratostene t max0 =
  let sum = 0 in
  let c = 2 in
  let d = (max0 - 1) in
  let rec a i sum =
    (if (i <= d)
     then let sum = (if (t.(i) = i)
                     then let sum = (sum + i) in
                     (
                       (if ((max0 / i) > i)
                        then let j = (i * i) in
                        let rec b j =
                          (if ((j < max0) && (j > 0))
                           then (
                                  t.(j) <- 0;
                                  let j = (j + i) in
                                  (b j)
                                  )
                           
                           else ()) in
                          (b j)
                        else ());
                       sum
                       )
                     
                     else sum) in
     (a (i + 1) sum)
     else sum) in
    (a c sum)
let main =
  let n = 100000 in
  (*  normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages  *)
  ((fun  (f, t) -> (
                     f;
                     t.(1) <- 0;
                     (Printf.printf "%d\n" (eratostene t n))
                     )
  ) (Array.init_withenv n (fun  i () -> let e = i in
  ((), e)) ()))

