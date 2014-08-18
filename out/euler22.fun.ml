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

let rec score =
  (fun () -> (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
  (fun len ->
      (Scanf.scanf "%[\n \010]" (fun _ -> let sum = 0 in
      let b = 1 in
      let d = len in
      let rec a i sum len =
        (if (i <= d)
         then Scanf.scanf "%c"
         (fun c ->
             let sum = (sum + (((int_of_char (c)) - (int_of_char ('A'))) + 1)) in
             (* 		print c print " " print sum print " "  *)
             (a (i + 1) sum len))
         else sum) in
        (a b sum len)))))));;
let rec main =
  let sum = 0 in
  Scanf.scanf "%d"
  (fun n ->
      let f = 1 in
      let g = n in
      let rec e i n sum =
        (if (i <= g)
         then let sum = (sum + (i * (score ()))) in
         (e (i + 1) n sum)
         else begin
                (Printf.printf "%d" sum);
                (Printf.printf "%s" "\n")
                end
         ) in
        (e f n sum));;
