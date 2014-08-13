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

let rec main =
  let i = 0 in
  let i = (i - 1) in
  begin
    (Printf.printf "%d" i);
    (Printf.printf "%s" "\n");
    let i = (i + 55) in
    begin
      (Printf.printf "%d" i);
      (Printf.printf "%s" "\n");
      let i = (i * 13) in
      begin
        (Printf.printf "%d" i);
        (Printf.printf "%s" "\n");
        let i = (i / 2) in
        begin
          (Printf.printf "%d" i);
          (Printf.printf "%s" "\n");
          let i = (i + 1) in
          begin
            (Printf.printf "%d" i);
            (Printf.printf "%s" "\n");
            let i = (i / 3) in
            begin
              (Printf.printf "%d" i);
              (Printf.printf "%s" "\n");
              let i = (i - 1) in
              begin
                (Printf.printf "%d" i);
                (Printf.printf "%s" "\n");
                (* 
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
 *)
                begin
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
                  end
                
                end
              
              end
            
            end
          
          end
        
        end
      
      end
    
    end
  ;;

