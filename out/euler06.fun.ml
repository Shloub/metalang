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
  let lim = 100 in
  let sum = ((lim * (lim + 1)) / 2) in
  let carressum = (sum * sum) in
  let sumcarres = (((lim * (lim + 1)) * ((2 * lim) + 1)) / 6) in
  (Printf.printf "%d" (carressum - sumcarres));;

