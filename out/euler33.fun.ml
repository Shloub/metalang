let rec pgcd a b =
  let c = ((min (a) (b))) in
  let d = ((max (a) (b))) in
  let reste = (d mod c) in
  let g () = () in
  (if (reste = 0)
   then c
   else (pgcd c reste))
let main =
  let top = 1 in
  let bottom = 1 in
  let s = 1 in
  let t = 9 in
  let rec h i bottom top =
    (if (i <= t)
     then let q = 1 in
     let r = 9 in
     let rec l j bottom top =
       (if (j <= r)
        then let n = 1 in
        let o = 9 in
        let rec m k bottom top =
          (if (k <= o)
           then ((fun  (bottom, top) -> (m (k + 1) bottom top)) (if ((i <> j) && (j <> k))
                                                                 then let a = ((i * 10) + j) in
                                                                 let b = ((j * 10) + k) in
                                                                 ((fun  (bottom, top) -> (bottom, top)) (
                                                                 if ((a * k) = (i * b))
                                                                 then 
                                                                 (
                                                                   (Printf.printf "%d/%d\n" a b);
                                                                   let top = (top * a) in
                                                                   let bottom = (bottom * b) in
                                                                   (bottom, top)
                                                                   )
                                                                 
                                                                 else (bottom, top)))
                                                                 else (bottom, top)))
           else (l (j + 1) bottom top)) in
          (m n bottom top)
        else (h (i + 1) bottom top)) in
       (l q bottom top)
     else (
            (Printf.printf "%d/%d\n" top bottom);
            let p = (pgcd top bottom) in
            (
              (Printf.printf "pgcd=%d\n%d\n" p (bottom / p))
              )
            
            )
     ) in
    (h s bottom top)

