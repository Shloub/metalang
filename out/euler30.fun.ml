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

let main =
  (* 
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
 *)
  ((fun  (h, p) -> (
                     h;
                     let sum = 0 in
                     let bc = 0 in
                     let bd = 9 in
                     let rec j a sum =
                       (if (a <= bd)
                        then let ba = 0 in
                        let bb = 9 in
                        let rec k b sum =
                          (if (b <= bb)
                           then let y = 0 in
                           let z = 9 in
                           let rec l c sum =
                             (if (c <= z)
                              then let w = 0 in
                              let x = 9 in
                              let rec m d sum =
                                (if (d <= x)
                                 then let u = 0 in
                                 let v = 9 in
                                 let rec n e sum =
                                   (if (e <= v)
                                    then let q = 0 in
                                    let t = 9 in
                                    let rec o f sum =
                                      (if (f <= t)
                                       then let s = (((((p.(a) + p.(b)) + p.(c)) + p.(d)) + p.(e)) + p.(f)) in
                                       let r = (((((a + (b * 10)) + (c * 100)) + (d * 1000)) + (e * 10000)) + (f * 100000)) in
                                       let sum = (if ((s = r) && (r <> 1))
                                                  then (
                                                         (Printf.printf "%d%d%d%d%d%d %d\n" f e d c b a r);
                                                         let sum = (sum + r) in
                                                         sum
                                                         )
                                                  
                                                  else sum) in
                                       (o (f + 1) sum)
                                       else (n (e + 1) sum)) in
                                      (o q sum)
                                    else (m (d + 1) sum)) in
                                   (n u sum)
                                 else (l (c + 1) sum)) in
                                (m w sum)
                              else (k (b + 1) sum)) in
                             (l y sum)
                           else (j (a + 1) sum)) in
                          (k ba sum)
                        else (Printf.printf "%d" sum)) in
                       (j bc sum)
                     )
  ) (Array.init_withenv 10 (fun  i () -> let g = ((((i * i) * i) * i) * i) in
  ((), g)) ()))

