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
      bar=0;
      blah=0} in
      t);;
let rec result =
  (fun t len ->
      let out_ = 0 in
      let c = 0 in
      let d = (len - 1) in
      let rec b j out_ t len =
        (if (j <= d)
         then (t.(j).blah <- (t.(j).blah + 1); let out_ = (((out_ + t.(j).foo) + (t.(j).blah * t.(j).bar)) + (t.(j).bar * t.(j).foo)) in
         (b (j + 1) out_ t len))
         else out_) in
        (b c out_ t len));;
let rec main =
  let a = 4 in
  let t = (Array.init_withenv a (fun i a ->
                                    let e = (mktoto i) in
                                    (a, e)) a) in
  Scanf.scanf "%d"
  (fun g ->
      (t.(0).bar <- g; (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
      (fun f ->
          (t.(1).blah <- f; let titi = (result t 4) in
          begin
            (Printf.printf "%d" titi);
            (Printf.printf "%d" t.(2).blah)
            end
          ))))));;

