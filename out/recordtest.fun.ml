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

type toto = {mutable foo : int; mutable bar : int;};;
let rec main =
  let param = {foo=0;
  bar=0} in
  Scanf.scanf "%d"
  (fun b ->
      (param.bar <- b; (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
      (fun a ->
          (param.foo <- a; (Printf.printf "%d" (param.bar + (param.foo * param.bar)))))))));;

