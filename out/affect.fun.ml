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

type toto = {mutable foo : int; mutable bar : int; mutable blah : int;};;
let rec mktoto =
  (fun v1 ->
      ((fun t ->
           t) {foo=v1;
      bar=v1;
      blah=v1}));;
let rec mktoto2 =
  (fun v1 ->
      ((fun t ->
           t) {foo=(v1 + 3);
      bar=(v1 + 2);
      blah=(v1 + 1)}));;
let rec result =
  (fun t_ t2_ ->
      ((fun t ->
           ((fun t2 ->
                ((fun t3 ->
                     ((fun t3 ->
                          ((fun t ->
                               ((fun t2 ->
                                    (t.blah <- (t.blah + 1); ((fun len ->
                                                                  ((fun
                                                                   cache0 ->
                                                                  ((fun
                                                                   cache1 ->
                                                                  ((fun
                                                                   cache2 ->
                                                                  ((fun
                                                                   cache0 ->
                                                                  ((fun
                                                                   cache2 ->
                                                                  ((t.foo + (t.blah * t.bar)) + (t.bar * t.foo))) cache0)) cache1)) cache0)) ((Array.init_withenv len (fun
                                                                   j ->
                                                                  (fun
                                                                   (len, t3, t2, t, t_, t2_) ->
                                                                  ((fun
                                                                   b ->
                                                                  ((len, t3, t2, t, t_, t2_), b)) j))) ) (len, t3, t2, t, t_, t2_)))) ((Array.init_withenv len (fun
                                                                   i ->
                                                                  (fun
                                                                   (len, t3, t2, t, t_, t2_) ->
                                                                  ((fun
                                                                   a ->
                                                                  ((len, t3, t2, t, t_, t2_), a)) (- i)))) ) (len, t3, t2, t, t_, t2_)))) 1))) t3)) t2)) t2)) {foo=0;
                bar=0;
                blah=0})) t2_)) t_));;
let rec main =
  ((fun t ->
       ((fun t2 ->
            Scanf.scanf "%d" (fun f ->
                                 (t.bar <- f; (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                                  e ->
                                 (t.blah <- e; (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                                  d ->
                                 (t2.bar <- d; (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                                  c ->
                                 (t2.blah <- c; (Printf.printf "%d" (result t t2);
                                 (Printf.printf "%d" t.blah;
                                 ()))))))))))))))))) (mktoto 5))) (mktoto 4));;

