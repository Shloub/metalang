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
  ((fun i ->
       (* while i < 10 do  *)
       (Printf.printf "%d" i;
       ((fun i ->
            (*   end  *)
            (Printf.printf "%d" i;
            ())) (i + 1)))) 4);;

