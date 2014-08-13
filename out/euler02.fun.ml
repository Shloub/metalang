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
  let a = 1 in
  let b = 2 in
  let sum = 0 in
  let rec e sum b a =
    (if (a < 4000000)
     then let f = (fun sum b a ->
                      let c = a in
                      let a = b in
                      let b = (b + c) in
                      (e sum b a)) in
     (if ((a mod 2) = 0)
      then let sum = (sum + a) in
      (f sum b a)
      else (f sum b a))
     else begin
            (Printf.printf "%d" sum);
            (Printf.printf "%s" "\n")
            end
     ) in
    (e sum b a);;

