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

let eratostene =
  (fun t max_ ->
      let sum = 0 in
      let d = 2 in
      let e = (max_ - 1) in
      let rec a i sum =
        (if (i <= e)
         then let sum = (if (t.(i) = i)
                         then let sum = (sum + i) in
                         let j = (i * i) in
                         (* 
			detect overflow
			 *)
                         let j = (if ((j / i) = i)
                                  then let rec c j =
                                         (if ((j < max_) && (j > 0))
                                          then (
                                                 t.(j) <- 0;
                                                 let j = (j + i) in
                                                 (c j)
                                                 )
                                          
                                          else j) in
                                         (c j)
                                  else j) in
                         sum
                         else sum) in
         (a (i + 1) sum)
         else sum) in
        (a d sum));;
let main =
  let n = 100000 in
  (*  normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages  *)
  let t = (Array.init_withenv n (fun i ->
                                    (fun () -> let f = i in
                                    ((), f))) ()) in
  (
    t.(1) <- 0;
    (Printf.printf "%d" (eratostene t n));
    (Printf.printf "%s" "\n")
    )
  ;;

