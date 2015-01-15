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

let main =
  (* 
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
 *)
  let p = (Array.init_withenv 10 (fun  i () -> let g = ((((i * i) * i) * i) * i) in
  ((), g)) ()) in
  let sum = 0 in
  let bb = 0 in
  let bc = 9 in
  let rec h a sum =
    (if (a <= bc)
     then let z = 0 in
     let ba = 9 in
     let rec j b sum =
       (if (b <= ba)
        then let x = 0 in
        let y = 9 in
        let rec k c sum =
          (if (c <= y)
           then let v = 0 in
           let w = 9 in
           let rec l d sum =
             (if (d <= w)
              then let t = 0 in
              let u = 9 in
              let rec m e sum =
                (if (e <= u)
                 then let o = 0 in
                 let q = 9 in
                 let rec n f sum =
                   (if (f <= q)
                    then let s = (((((p.(a) + p.(b)) + p.(c)) + p.(d)) + p.(e)) + p.(f)) in
                    let r = (((((a + (b * 10)) + (c * 100)) + (d * 1000)) + (e * 10000)) + (f * 100000)) in
                    let sum = (if ((s = r) && (r <> 1))
                               then (
                                      (Printf.printf "%d%d%d%d%d%d %d\n" f e d c b a r);
                                      let sum = (sum + r) in
                                      sum
                                      )
                               
                               else sum) in
                    (n (f + 1) sum)
                    else (m (e + 1) sum)) in
                   (n o sum)
                 else (l (d + 1) sum)) in
                (m t sum)
              else (k (c + 1) sum)) in
             (l v sum)
           else (j (b + 1) sum)) in
          (k x sum)
        else (h (a + 1) sum)) in
       (j z sum)
     else (Printf.printf "%d" sum)) in
    (h bb sum)

