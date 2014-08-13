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
  let sum = 0 in
  let c = 0 in
  let d = 999 in
  let rec a i sum =
    (if (i <= d)
     then let b = (fun sum ->
                      (a (i + 1) sum)) in
     (if (((i mod 3) = 0) || ((i mod 5) = 0))
      then let sum = (sum + i) in
      (b sum)
      else (b sum))
     else begin
            (Printf.printf "%d" sum);
            (Printf.printf "%s" "\n")
            end
     ) in
    (a c sum);;

