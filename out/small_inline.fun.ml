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
  ((fun  (b, t) -> (
                     (Printf.printf "%d - %d\n" t.(0) t.(1))
                     )
  ) (Array.init_withenv 2 (fun  d b -> Scanf.scanf "%d"
  (fun  out0 -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  let a = out0 in
                  ((), a)
                  )
  )) ()))

