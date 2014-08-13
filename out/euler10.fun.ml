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

let rec eratostene =
  (fun t max_ ->
      let sum = 0 in
      let f = 2 in
      let g = (max_ - 1) in
      let rec a i sum t max_ =
        (if (i <= g)
         then let b = (fun sum t max_ ->
                          (a (i + 1) sum t max_)) in
         (if (t.(i) = i)
          then let sum = (sum + i) in
          let j = (i * i) in
          (* 
			detect overflow
			 *)
          let c = (fun j sum t max_ ->
                      (b sum t max_)) in
          (if ((j / i) = i)
           then let rec e j sum t max_ =
                  (if ((j < max_) && (j > 0))
                   then (t.(j) <- 0; let j = (j + i) in
                   (e j sum t max_))
                   else (c j sum t max_)) in
                  (e j sum t max_)
           else (c j sum t max_))
          else (b sum t max_))
         else sum) in
        (a f sum t max_));;
let rec main =
  let n = 100000 in
  (*  normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages  *)
  let t = (Array.init_withenv n (fun i n ->
                                    let h = i in
                                    (n, h)) n) in
  (t.(1) <- 0; begin
                 (Printf.printf "%d" (eratostene t n));
                 (Printf.printf "%s" "\n")
                 end
  );;

