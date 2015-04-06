type toto = {mutable foo : int; mutable bar : int;}
let main =
  let param = {foo=0;
  bar=0} in
  Scanf.scanf "%d"
  (fun  a -> (
               param.bar <- a;
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               Scanf.scanf "%d"
               (fun  b -> (
                            param.foo <- b;
                            (Printf.printf "%d" (param.bar + (param.foo * param.bar)))
                            )
               )
               )
  )

