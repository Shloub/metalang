type toto = {mutable foo : (int * int); mutable bar : int;}
let main =
  let bar_ = (Scanf.scanf "%d " (fun x -> x)) in
  Scanf.scanf "%d"
  (fun  e -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               Scanf.scanf "%d"
               (fun  f -> (
                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                            let t = {foo=(e, f);
                            bar=bar_} in
                            ((fun  (a, b) -> (
                                               (Printf.printf "%d %d %d\n" a b t.bar)
                                               )
                            ) t.foo)
                            )
               )
               )
  )

