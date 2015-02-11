type toto = {mutable foo : (int * int); mutable bar : int;}
let main =
  let bar_ = (Scanf.scanf "%d " (fun x -> x)) in
  Scanf.scanf "%d"
  (fun  c -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               Scanf.scanf "%d"
               (fun  d -> (
                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                            let t = {foo=(c, d);
                            bar=bar_} in
                            ((fun  (a, b) -> (
                                               (Printf.printf "%d %d %d\n" a b t.bar)
                                               )
                            ) t.foo)
                            )
               )
               )
  )

