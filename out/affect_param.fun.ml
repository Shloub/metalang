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

let rec foo =
  (fun a ->
      ((fun a ->
           ()) 4));;
let rec main =
  ((fun a ->
       begin
         (foo a);
         (Printf.printf "%d" a;
         (Printf.printf "%s" "\n";
         ()))
         end
       ) 0);;

