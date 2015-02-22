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
    ((fun  (b, cache0) -> (
                            b;
                            ((fun  (d, cache1) -> (
                                                    d;
                                                    let cache2 = cache0 in
                                                    let cache0 = cache1 in
                                                    let cache2 = cache0 in
                                                    ((t.foo + (t.blah * t.bar)) + (t.bar * t.foo))
                                                    )
                            ) (Array.init_withenv len (fun  j () -> let c = j in
                            ((), c)) ()))
                            )
    ) (Array.init_withenv len (fun  i () -> let a = (- i) in
    ((), a)) ()))
    )
  
let main =
  let t = (mktoto 4) in
  let t2 = (mktoto 5) in
  Scanf.scanf "%d"
  (fun  h -> (
               t.bar <- h;
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               Scanf.scanf "%d"
               (fun  g -> (
                            t.blah <- g;
                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                            Scanf.scanf "%d"
                            (fun  f -> (
                                         t2.bar <- f;
                                         (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                         Scanf.scanf "%d"
                                         (fun  e -> (
                                                      t2.blah <- e;
                                                      (Printf.printf "%d%d" (result t t2) t.blah)
                                                      )
                                         )
                                         )
                            )
                            )
               )
               )
  )

