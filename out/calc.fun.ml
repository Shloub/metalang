let fibo a b i =
  let out_ = 0 in
  let a2 = a in
  let b2 = b in
  let d = (i + 1) in
  let rec c j a2 b2 out_ =
    (if (j <= d)
     then (
            (Printf.printf "%d" j);
            let out_ = (out_ + a2) in
            let tmp = b2 in
            let b2 = (b2 + a2) in
            let a2 = tmp in
            (c (j + 1) a2 b2 out_)
            )
     
     else out_) in
    (c 0 a2 b2 out_)
let main =
  (Printf.printf "%d" (fibo 1 2 4))

