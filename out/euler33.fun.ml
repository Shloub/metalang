let rec pgcd a b =
  let c = ((min (a) (b))) in
  let d = ((max (a) (b))) in
  let reste = (d mod c) in
  let e () = () in
  (if (reste = 0)
   then c
   else (pgcd c reste))
let main =
  let top = 1 in
  let bottom = 1 in
  let q = 1 in
  let r = 9 in
  let rec f i bottom top =
    (if (i <= r)
     then let n = 1 in
     let o = 9 in
     let rec g j bottom top =
       (if (j <= o)
        then let l = 1 in
        let m = 9 in
        let rec h k bottom top =
          (if (k <= m)
           then ((fun  (bottom, top) -> (h (k + 1) bottom top)) (if ((i <> j) && (j <> k))
                                                                 then let a = ((i * 10) + j) in
                                                                 let b = ((j * 10) + k) in
                                                                 ((fun  (bottom, top) -> (bottom, top)) (
                                                                 if ((a * k) = (i * b))
                                                                 then (
                                                                        (Printf.printf "%d/%d\n" a b);
                                                                        let top = (top * a) in
                                                                        let bottom = (bottom * b) in
                                                                        (bottom, top)
                                                                        )
                                                                 
                                                                 else (bottom, top)))
                                                                 else (bottom, top)))
           else (g (j + 1) bottom top)) in
          (h l bottom top)
        else (f (i + 1) bottom top)) in
       (g n bottom top)
     else (
            (Printf.printf "%d/%d\n" top bottom);
            let p = (pgcd top bottom) in
            (
              (Printf.printf "pgcd=%d\n%d\n" p (bottom / p))
              )
            
            )
     ) in
    (f q bottom top)

