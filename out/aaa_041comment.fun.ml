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
  let i = 4 in
  (* while i < 10 do  *)
  begin
    (Printf.printf "%d" i);
    let i = (i + 1) in
    (*   end  *)
    (Printf.printf "%d" i)
    end
  ;;

