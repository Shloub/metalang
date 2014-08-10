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
  (fun t len ->
      ((fun out_ ->
           ((fun c d ->
                let rec b j out_ t len =
                  (if (j <= d)
                   then (t.(j).blah <- (t.(j).blah + 1); ((fun out_ ->
                                                              (b (j + 1) out_ t len)) (((out_ + t.(j).foo) + (t.(j).blah * t.(j).bar)) + (t.(j).bar * t.(j).foo))))
                   else out_) in
                  (b c out_ t len)) 0 (len - 1))) 0));;
let rec main =
  ((fun a ->
       ((fun t ->
            Scanf.scanf "%d" (fun g ->
                                 (t.(0).bar <- g; (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                                  f ->
                                 (t.(1).blah <- f; ((fun titi ->
                                                        (Printf.printf "%d" titi;
                                                        (Printf.printf "%d" t.(2).blah;
                                                        ()))) (result t 4))))))))) ((Array.init_withenv a (fun
        i ->
       (fun (a) ->
           ((fun e ->
                ((a), e)) (mktoto i)))) ) (a)))) 4);;

