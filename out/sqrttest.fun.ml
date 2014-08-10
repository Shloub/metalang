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

let rec isqrt =
  (fun c ->
      ((int_of_float (sqrt (float_of_int ( c))))));;
let rec main =
  (Printf.printf "%d" (isqrt 4);
  (Printf.printf "%s" " ";
  (Printf.printf "%d" (isqrt 16);
  (Printf.printf "%s" " ";
  (Printf.printf "%d" (isqrt 20);
  (Printf.printf "%s" " ";
  (Printf.printf "%d" (isqrt 1000);
  (Printf.printf "%s" " ";
  (Printf.printf "%d" (isqrt 500);
  (Printf.printf "%s" " ";
  (Printf.printf "%d" (isqrt 10);
  (Printf.printf "%s" " ";
  ()))))))))))));;

