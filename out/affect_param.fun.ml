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
      let a = 4 in
      ());;
let rec main =
  let a = 0 in
  begin
    (foo a);
    (Printf.printf "%d" a);
    (Printf.printf "%s" "\n")
    end
  ;;

