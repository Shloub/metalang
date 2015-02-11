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

let main =
  let str = (Array.init_withenv 12 (fun  a () -> Scanf.scanf "%c"
  (fun  b -> let c = b in
  ((), c))) ()) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let e = 0 in
    let f = 11 in
    let rec d i =
      (if (i <= f)
       then (
              (Printf.printf "%c" str.(i));
              (d (i + 1))
              )
       
       else ()) in
      (d e)
    )
  

