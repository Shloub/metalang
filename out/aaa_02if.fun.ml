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
      ((fun a ->
           (if (i = 0)
            then true
            else (a i))) (fun i ->
                             false)));;
let rec main =
  ((fun b ->
       (if (f 4)
        then (Printf.printf "%s" "true <-\n ->\n";
        (b ()))
        else (Printf.printf "%s" "false <-\n ->\n";
        (b ())))) (fun () -> (Printf.printf "%s" "small test end\n";
  ())));;

