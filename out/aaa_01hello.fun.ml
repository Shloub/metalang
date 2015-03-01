let main =
  (
    (Printf.printf "Hello World");
    let a = 5 in
    (
      (Printf.printf "%d \n%dfoo" ((4 + 6) * 2) a);
      let b = (((((1 + ((((1 + 1) * 2) * (3 + 8)) / 4)) - (1 - 2)) - 3) = 12) && true) in
      (
        (if b
         then (Printf.printf "True")
         else (Printf.printf "False"));
        (Printf.printf "\n");
        let c = ((((3 * ((4 + 5) + 6)) * 2) = 45) = false) in
        (
          (if c
           then (Printf.printf "True")
           else (Printf.printf "False"));
          (Printf.printf "%d%d" (((4 + 1) / 3) / (2 + 1)) (((4 * 1) / 3) / (2 * 1)));
          let d = (not ((not (a = 0)) && (not (a = 4)))) in
          (
            (if d
             then (Printf.printf "True")
             else (Printf.printf "False"));
            let e = ((true && (not false)) && (not (true && false))) in
            (
              (if e
               then (Printf.printf "True")
               else (Printf.printf "False"));
              (Printf.printf "\n")
              )
            
            )
          
          )
        
        )
      
      )
    
    )
  

