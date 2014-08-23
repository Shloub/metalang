let min2 a b =
  (min a b)
let main =
  let e = 2 in
  let f = 3 in
  let g = 4 in
  (
    (Printf.printf "%d " (min2 (min2 e f) g));
    let i = 2 in
    let j = 4 in
    let k = 3 in
    (
      (Printf.printf "%d " (min2 (min2 i j) k));
      let m = 3 in
      let n = 2 in
      let o = 4 in
      (
        (Printf.printf "%d " (min2 (min2 m n) o));
        let q = 3 in
        let r = 4 in
        let s = 2 in
        (
          (Printf.printf "%d " (min2 (min2 q r) s));
          let u = 4 in
          let v = 2 in
          let w = 3 in
          (
            (Printf.printf "%d " (min2 (min2 u v) w));
            let y = 4 in
            let z = 3 in
            let ba = 2 in
            (
              (Printf.printf "%d\n" (min2 (min2 y z) ba))
              )
            
            )
          
          )
        
        )
      
      )
    
    )
  

