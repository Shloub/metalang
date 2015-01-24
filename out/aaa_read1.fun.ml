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
  let str = (Array.init_withenv 12 (fun  d () -> Scanf.scanf "%c"
  (fun  e -> let f = e in
  ((), f))) ()) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let h = 0 in
    let j = 11 in
    let rec g i =
      (if (i <= j)
       then (
              (Printf.printf "%c" str.(i));
              (g (i + 1))
              )
       
       else ()) in
      (g h)
    )
  

