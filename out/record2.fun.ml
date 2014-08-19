type toto = {mutable foo : int; mutable bar : int; mutable blah : int;}
let mktoto v1 =
  let t = {foo=v1;
  bar=0;
  blah=0} in
  t
let result t =
  (
    t.blah <- (t.blah + 1);
    ((t.foo + (t.blah * t.bar)) + (t.bar * t.foo))
    )
  
let main =
  let t = (mktoto 4) in
  Scanf.scanf "%d"
  (fun  b -> (
               t.bar <- b;
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               Scanf.scanf "%d"
               (fun  a -> (
                            t.blah <- a;
                            (Printf.printf "%d" (result t))
                            )
               )
               )
  )

