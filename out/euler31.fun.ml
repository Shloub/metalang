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

let rec result sum t maxIndex cache =
  let a () = () in
  (if (cache.(sum).(maxIndex) <> 0)
   then cache.(sum).(maxIndex)
   else let b () = (a ()) in
   (if ((sum = 0) || (maxIndex = 0))
    then 1
    else let out0 = 0 in
    let div = (sum / t.(maxIndex)) in
    let d = 0 in
    let e = div in
    let rec c i out0 =
      (if (i <= e)
       then let out0 = (out0 + (result (sum - (i * t.(maxIndex))) t (maxIndex - 1) cache)) in
       (c (i + 1) out0)
       else (
              cache.(sum).(maxIndex) <- out0;
              out0
              )
       ) in
      (c d out0)))
let main =
  let t = (Array.init_withenv 8 (fun  i () -> let f = 0 in
  ((), f)) ()) in
  (
    t.(0) <- 1;
    t.(1) <- 2;
    t.(2) <- 5;
    t.(3) <- 10;
    t.(4) <- 20;
    t.(5) <- 50;
    t.(6) <- 100;
    t.(7) <- 200;
    let cache = (Array.init_withenv 201 (fun  j () -> let o = (Array.init_withenv 8 (fun  k () -> let h = 0 in
    ((), h)) ()) in
    let g = o in
    ((), g)) ()) in
    (Printf.printf "%d" (result 200 t 7 cache))
    )
  

