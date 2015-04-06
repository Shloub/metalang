type toto = {mutable foo : int; mutable bar : int; mutable blah : int;}
let mktoto v1 =
  let t = {foo=v1;
  bar=v1;
  blah=v1} in
  t
let mktoto2 v1 =
  let t = {foo=(v1 + 3);
  bar=(v1 + 2);
  blah=(v1 + 1)} in
  t
let result t_ t2_ =
  let t = t_ in
  let t2 = t2_ in
  let t3 = {foo=0;
  bar=0;
  blah=0} in
  let t3 = t2 in
  let t = t2 in
  let t2 = t3 in
  (
    t.blah <- (t.blah + 1);
    let len = 1 in
    let cache0 = (Array.init len (fun  i -> (- i))) in
    let cache1 = (Array.init len (fun  j -> j)) in
    let cache2 = cache0 in
    let cache0 = cache1 in
    let cache2 = cache0 in
    ((t.foo + (t.blah * t.bar)) + (t.bar * t.foo))
    )
  
let main =
  let t = (mktoto 4) in
  let t2 = (mktoto 5) in
  Scanf.scanf "%d"
  (fun  a -> (
               t.bar <- a;
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               Scanf.scanf "%d"
               (fun  b -> (
                            t.blah <- b;
                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                            Scanf.scanf "%d"
                            (fun  c -> (
                                         t2.bar <- c;
                                         (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                         Scanf.scanf "%d"
                                         (fun  d -> (
                                                      t2.blah <- d;
                                                      (Printf.printf "%d%d" (result t t2) t.blah)
                                                      )
                                         )
                                         )
                            )
                            )
               )
               )
  )

