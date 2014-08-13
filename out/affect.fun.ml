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
      let t = {foo=v1;
      bar=v1;
      blah=v1} in
      t);;
let rec mktoto2 =
  (fun v1 ->
      let t = {foo=(v1 + 3);
      bar=(v1 + 2);
      blah=(v1 + 1)} in
      t);;
let rec result =
  (fun t_ t2_ ->
      let t = t_ in
      let t2 = t2_ in
      let t3 = {foo=0;
      bar=0;
      blah=0} in
      let t3 = t2 in
      let t = t2 in
      let t2 = t3 in
      (t.blah <- (t.blah + 1); let len = 1 in
      let cache0 = (Array.init_withenv len (fun i ->
                                               (fun (len, t3, t2, t, t_, t2_) ->
                                                   let a = (- i) in
                                                   ((len, t3, t2, t, t_, t2_), a))) (len, t3, t2, t, t_, t2_)) in
      let cache1 = (Array.init_withenv len (fun j ->
                                               (fun (len, t3, t2, t, t_, t2_) ->
                                                   let b = j in
                                                   ((len, t3, t2, t, t_, t2_), b))) (len, t3, t2, t, t_, t2_)) in
      let cache2 = cache0 in
      let cache0 = cache1 in
      let cache2 = cache0 in
      ((t.foo + (t.blah * t.bar)) + (t.bar * t.foo))));;
let rec main =
  let t = (mktoto 4) in
  let t2 = (mktoto 5) in
  Scanf.scanf "%d"
  (fun f ->
      (t.bar <- f; (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
      (fun e ->
          (t.blah <- e; (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
          (fun d ->
              (t2.bar <- d; (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
              (fun c ->
                  (t2.blah <- c; begin
                                   (Printf.printf "%d" (result t t2));
                                   (Printf.printf "%d" t.blah)
                                   end
                  ))))))))))))));;

