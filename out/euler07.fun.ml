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

let rec divisible =
  (fun n t size ->
      let f = 0 in
      let g = (size - 1) in
      let rec d i n t size =
        (if (i <= g)
         then let e = (fun n t size ->
                          (d (i + 1) n t size)) in
         (if ((n mod t.(i)) = 0)
          then true
          else (e n t size))
         else false) in
        (d f n t size));;
let rec find =
  (fun n t used nth ->
      let rec b n t used nth =
        (if (used <> nth)
         then let c = (fun n t used nth ->
                          (b n t used nth)) in
         (if (divisible n t used)
          then let n = (n + 1) in
          (c n t used nth)
          else (t.(used) <- n; let n = (n + 1) in
          let used = (used + 1) in
          (c n t used nth)))
         else t.((used - 1))) in
        (b n t used nth));;
let rec main =
  let n = 10001 in
  let t = (Array.init_withenv n (fun i n ->
                                    let h = 2 in
                                    (n, h)) n) in
  begin
    (Printf.printf "%d" (find 3 t 1 n));
    (Printf.printf "%s" "\n")
    end
  ;;

