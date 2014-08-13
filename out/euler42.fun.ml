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

let rec isqrt =
  (fun c ->
      ((int_of_float (sqrt (float_of_int ( c))))));;
let rec is_triangular =
  (fun n ->
      (* 
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
    *)
      let a = (isqrt (n * 2)) in
      ((a * (a + 1)) = (n * 2)));;
let rec score =
  (fun () -> (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
  (fun len ->
      (Scanf.scanf "%[\n \010]" (fun _ -> let sum = 0 in
      let e = 1 in
      let f = len in
      let rec d i sum len =
        (if (i <= f)
         then Scanf.scanf "%c"
         (fun c ->
             let sum = (sum + (((int_of_char (c)) - (int_of_char ('A'))) + 1)) in
             (* 		print c print " " print sum print " "  *)
             (d (i + 1) sum len))
         else let b = (fun sum len ->
                          ()) in
         (if (is_triangular sum)
          then 1
          else 0)) in
        (d e sum len)))))));;
let rec main =
  let m = 1 in
  let o = 55 in
  let rec k i =
    (if (i <= o)
     then let l = (fun () -> (k (i + 1))) in
     (if (is_triangular i)
      then begin
             (Printf.printf "%d" i);
             (Printf.printf "%s" " ");
             (l ())
             end
      
      else (l ()))
     else begin
            (Printf.printf "%s" "\n");
            let sum = 0 in
            Scanf.scanf "%d"
            (fun n ->
                let h = 1 in
                let j = n in
                let rec g i n sum =
                  (if (i <= j)
                   then let sum = (sum + (score ())) in
                   (g (i + 1) n sum)
                   else begin
                          (Printf.printf "%d" sum);
                          (Printf.printf "%s" "\n")
                          end
                   ) in
                  (g h n sum))
            end
     ) in
    (k m);;

