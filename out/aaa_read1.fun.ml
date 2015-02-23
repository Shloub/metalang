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
                       (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                       let rec e i =
                         (if (i <= 11)
                          then (
                                 (Printf.printf "%c" str.(i));
                                 (e (i + 1))
                                 )
                          
                          else ()) in
                         (e 0)
                       )
  ) (Array.init_withenv 12 (fun  a d -> Scanf.scanf "%c"
  (fun  b -> let c = b in
  ((), c))) ()))

