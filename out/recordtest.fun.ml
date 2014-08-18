type toto = {mutable foo : int; mutable bar : int;};;
let main =
  let param = {foo=0;
  bar=0} in
  Scanf.scanf "%d"
  (fun b ->
      (
        param.bar <- b;
        (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
        (fun a ->
            (
              param.foo <- a;
              (Printf.printf "%d" (param.bar + (param.foo * param.bar)))
              )
            )))
        )
      );;

