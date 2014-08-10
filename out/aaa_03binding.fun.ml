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
      ((fun j ->
           ((fun c ->
                (if ((j mod 2) = 1)
                 then 0
                 else (c j i))) (fun j i ->
                                    j))) (i * 4)));;
let rec h =
  (fun i ->
      (Printf.printf "%d" i;
      (Printf.printf "%s" "\n";
      ())));;
let rec main =
  begin
    (h 14);
    ((fun a ->
         ((fun b ->
              (Printf.printf "%d" (a + b);
              (*  main  *)
              begin
                (h 15);
                ((fun a ->
                     ((fun b ->
                          (Printf.printf "%d" (a + b);
                          ())) 1)) 2)
                end
              )) 5)) 4)
    end
  ;;

