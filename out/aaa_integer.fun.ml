let main =
  let i = 0 in
  let i = (i - 1) in
  (
    (Printf.printf "%d" i);
    (Printf.printf "%s" "\n");
    let i = (i + 55) in
    (
      (Printf.printf "%d" i);
      (Printf.printf "%s" "\n");
      let i = (i * 13) in
      (
        (Printf.printf "%d" i);
        (Printf.printf "%s" "\n");
        let i = (i / 2) in
        (
          (Printf.printf "%d" i);
          (Printf.printf "%s" "\n");
          let i = (i + 1) in
          (
            (Printf.printf "%d" i);
            (Printf.printf "%s" "\n");
            let i = (i / 3) in
            (
              (Printf.printf "%d" i);
              (Printf.printf "%s" "\n");
              let i = (i - 1) in
              (
                (Printf.printf "%d" i);
                (Printf.printf "%s" "\n");
                (* 
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
 *)
                (
                  (Printf.printf "%d" (117 / 17));
                  (Printf.printf "%s" "\n");
                  (Printf.printf "%d" (117 / (- 17)));
                  (Printf.printf "%s" "\n");
                  (Printf.printf "%d" ((- 117) / 17));
                  (Printf.printf "%s" "\n");
                  (Printf.printf "%d" ((- 117) / (- 17)));
                  (Printf.printf "%s" "\n");
                  (Printf.printf "%d" (117 mod 17));
                  (Printf.printf "%s" "\n");
                  (Printf.printf "%d" (117 mod (- 17)));
                  (Printf.printf "%s" "\n");
                  (Printf.printf "%d" ((- 117) mod 17));
                  (Printf.printf "%s" "\n");
                  (Printf.printf "%d" ((- 117) mod (- 17)));
                  (Printf.printf "%s" "\n")
                  )
                
                )
              
              )
            
            )
          
          )
        
        )
      
      )
    
    )
  

