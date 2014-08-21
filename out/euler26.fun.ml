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
  let rec e a len =
    (if (a <> 0)
     then let chiffre = (a / b) in
     let reste = (a mod b) in
     let g = 0 in
     let h = (len - 1) in
     let rec f i =
       (if (i <= h)
        then (if (restes.(i) = reste)
              then (len - i)
              else (f (i + 1)))
        else (
               restes.(len) <- reste;
               let len = (len + 1) in
               let a = (reste * 10) in
               (e a len)
               )
        ) in
       (f g)
     else 0) in
    (e a len)
let main =
  let c = 1000 in
  let t = (Array.init_withenv c (fun  j () -> let k = 0 in
  ((), k)) ()) in
  let m = 0 in
  let mi = 0 in
  let n = 1 in
  let o = 1000 in
  let rec l i m mi =
    (if (i <= o)
     then let p = (periode t 0 1 i) in
     ((fun  (m, mi) -> (l (i + 1) m mi)) (if (p > m)
                                          then let mi = i in
                                          let m = p in
                                          (m, mi)
                                          else (m, mi)))
     else (
            (Printf.printf "%d\n%d\n" mi m)
            )
     ) in
    (l n m mi)

