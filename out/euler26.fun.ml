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

let periode restes len a b =
  let rec d a len =
    (if (a <> 0)
     then let chiffre = (a / b) in
     let reste = (a mod b) in
     let f = 0 in
     let g = (len - 1) in
     let rec e i =
       (if (i <= g)
        then (if (restes.(i) = reste)
              then (len - i)
              else (e (i + 1)))
        else (
               restes.(len) <- reste;
               let len = (len + 1) in
               let a = (reste * 10) in
               (d a len)
               )
        ) in
       (e f)
     else 0) in
    (d a len)
let main =
  let t = (Array.init_withenv 1000 (fun  j () -> let h = 0 in
  ((), h)) ()) in
  let m = 0 in
  let mi = 0 in
  let l = 1 in
  let n = 1000 in
  let rec k i m mi =
    (if (i <= n)
     then let p = (periode t 0 1 i) in
     ((fun  (m, mi) -> (k (i + 1) m mi)) (if (p > m)
                                          then let mi = i in
                                          let m = p in
                                          (m, mi)
                                          else (m, mi)))
     else (
            (Printf.printf "%d\n%d\n" mi m)
            )
     ) in
    (k l m mi)

