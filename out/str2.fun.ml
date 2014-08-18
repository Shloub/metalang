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
  begin
    (Printf.printf "%s" "ma petite chaine");
    (Printf.printf "%s" " en or");
    ()
    end
  ;;
