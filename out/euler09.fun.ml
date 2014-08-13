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
  (* 
	a + b + c = 1000 && a * a + b * b = c * c
	 *)
  let i = 1 in
  let j = 1000 in
  let rec d a =
    (if (a <= j)
     then let g = (a + 1) in
     let h = 1000 in
     let rec e b =
       (if (b <= h)
        then let c = ((1000 - a) - b) in
        let a2b2 = ((a * a) + (b * b)) in
        let cc = (c * c) in
        let f = (fun cc a2b2 c ->
                    (e (b + 1))) in
        (if ((cc = a2b2) && (c > a))
         then begin
                (Printf.printf "%d" a);
                (Printf.printf "%s" "\n");
                (Printf.printf "%d" b);
                (Printf.printf "%s" "\n");
                (Printf.printf "%d" c);
                (Printf.printf "%s" "\n");
                (Printf.printf "%d" ((a * b) * c));
                (Printf.printf "%s" "\n");
                (f cc a2b2 c)
                end
         
         else (f cc a2b2 c))
        else (d (a + 1))) in
       (e g)
     else ()) in
    (d i);;

