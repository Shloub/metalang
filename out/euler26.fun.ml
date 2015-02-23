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

let periode restes len a b =
  let rec c a len =
    (if (a <> 0)
     then let chiffre = (a / b) in
     let reste = (a mod b) in
     let e = (len - 1) in
     let rec d i =
       (if (i <= e)
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
       (d 0)
     else 0) in
    (c a len)
let main =
  ((fun  (g, t) -> (
                     g;
                     let m = 0 in
                     let mi = 0 in
                     let rec h i m mi =
                       (if (i <= 1000)
                        then let p = (periode t 0 1 i) in
                        (if (p > m)
                         then let mi = i in
                         let m = p in
                         (h (i + 1) m mi)
                         else (h (i + 1) m mi))
                        else (
                               (Printf.printf "%d\n%d\n" mi m)
                               )
                        ) in
                       (h 1 m mi)
                     )
  ) (Array.init_withenv 1000 (fun  j () -> let f = 0 in
  ((), f)) ()))

