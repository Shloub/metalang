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
      bar=0;
      blah=0}));;
let rec result =
  (fun t ->
      (t.blah <- (t.blah + 1); ((t.foo + (t.blah * t.bar)) + (t.bar * t.foo))));;
let rec main =
  ((fun t ->
       Scanf.scanf "%d" (fun b ->
                            (t.bar <- b; (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                             a ->
                            (t.blah <- a; (Printf.printf "%d" (result t);
                            ())))))))) (mktoto 4));;

