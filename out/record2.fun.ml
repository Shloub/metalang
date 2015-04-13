type toto = {mutable foo : int; mutable bar : int; mutable blah : int;}
let mktoto v1 =
  {foo=v1;
  bar=0;
  blah=0}
let result t =
  (
    t.blah <- (t.blah + 1);
    ((t.foo + (t.blah * t.bar)) + (t.bar * t.foo))
    )
  
let main =
  let t = (mktoto 4) in
  Scanf.scanf "%d"
  (fun  a -> (
               t.bar <- a;
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               Scanf.scanf "%d"
               (fun  b -> (
                            t.blah <- b;
                            (Printf.printf "%d" (result t))
                            )
               )
               )
  )

