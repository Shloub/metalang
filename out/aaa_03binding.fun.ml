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

let rec g =
  (fun i ->
      let j = (i * 4) in
      let c = (fun j i ->
                  j) in
      (if ((j mod 2) = 1)
       then 0
       else (c j i)));;
let rec h =
  (fun i ->
      begin
        (Printf.printf "%d" i);
        (Printf.printf "%s" "\n")
        end
      );;
let rec main =
  begin
    (h 14);
    let a = 4 in
    let b = 5 in
    begin
      (Printf.printf "%d" (a + b));
      (*  main  *)
      begin
        (h 15);
        let a = 2 in
        let b = 1 in
        (Printf.printf "%d" (a + b))
        end
      
      end
    
    end
  ;;

