module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let main =
  ((fun  (d, str) -> (
                       d;
                       (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                       let f = 0 in
                       let g = 11 in
                       let rec e i =
                         (if (i <= g)
                          then (
                                 (Printf.printf "%c" str.(i));
                                 (e (i + 1))
                                 )
                          
                          else ()) in
                         (e f)
                       )
  ) (Array.init_withenv 12 (fun  a () -> Scanf.scanf "%c"
  (fun  b -> let c = b in
  ((), c))) ()))

