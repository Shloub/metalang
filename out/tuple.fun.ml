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
  (fun tuple_ ->
      ((fun (a, b) ->
           ((a + 1), (b + 1))) tuple_));;
let rec main =
  ((fun t ->
       ((fun (a, b) ->
            (Printf.printf "%d" a;
            (Printf.printf "%s" " -- ";
            (Printf.printf "%d" b;
            (Printf.printf "%s" "--\n";
            ()))))) t)) (f (0, 1)));;

