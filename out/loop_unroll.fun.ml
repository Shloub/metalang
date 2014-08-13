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
  let j = 0 in
  let j = 0 in
  begin
    (Printf.printf "%d" j);
    (Printf.printf "%s" "\n");
    let j = 1 in
    begin
      (Printf.printf "%d" j);
      (Printf.printf "%s" "\n");
      let j = 2 in
      begin
        (Printf.printf "%d" j);
        (Printf.printf "%s" "\n");
        let j = 3 in
        begin
          (Printf.printf "%d" j);
          (Printf.printf "%s" "\n");
          let j = 4 in
          begin
            (Printf.printf "%d" j);
            (Printf.printf "%s" "\n")
            end
          
          end
        
        end
      
      end
    
    end
  ;;

