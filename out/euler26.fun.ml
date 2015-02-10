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
  let rec c a len =
    (if (a <> 0)
     then let chiffre = (a / b) in
     let reste = (a mod b) in
     let e = 0 in
     let f = (len - 1) in
     let rec d i =
       (if (i <= f)
        then (if (restes.(i) = reste)
              then (len - i)
              else (d (i + 1)))
        else (
               restes.(len) <- reste;
               let len = (len + 1) in
               let a = (reste * 10) in
               (c a len)
               )
        ) in
       (d e)
     else 0) in
    (c a len)
let main =
  let t = (Array.init_withenv 1000 (fun  j () -> let g = 0 in
  ((), g)) ()) in
  let m = 0 in
  let mi = 0 in
  let k = 1 in
  let l = 1000 in
  let rec h i m mi =
    (if (i <= l)
     then let p = (periode t 0 1 i) in
     ((fun  (m, mi) -> (h (i + 1) m mi)) (if (p > m)
                                          then let mi = i in
                                          let m = p in
                                          (m, mi)
                                          else (m, mi)))
     else (
            (Printf.printf "%d\n%d\n" mi m)
            )
     ) in
    (h k m mi)

