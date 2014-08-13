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

let rec f =
  (fun i ->
      let a = (fun i ->
                  false) in
      (if (i = 0)
       then true
       else (a i)));;
let rec main =
  let b = (fun () -> (Printf.printf "%s" "small test end\n")) in
  (if (f 4)
   then begin
          (Printf.printf "%s" "true <-\n ->\n");
          (b ())
          end
   
   else begin
          (Printf.printf "%s" "false <-\n ->\n");
          (b ())
          end
   );;

