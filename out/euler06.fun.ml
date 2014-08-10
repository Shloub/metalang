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
  ((fun lim ->
       ((fun sum ->
            ((fun carressum ->
                 ((fun sumcarres ->
                      (Printf.printf "%d" (carressum - sumcarres);
                      ())) (((lim * (lim + 1)) * ((2 * lim) + 1)) / 6))) (sum * sum))) ((lim * (lim + 1)) / 2))) 100);;

