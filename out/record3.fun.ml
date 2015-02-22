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
  bar=0;
  blah=0} in
  t
let result t len =
  let out0 = 0 in
  let b = 0 in
  let c = (len - 1) in
  let rec a j out0 =
    (if (j <= c)
     then (
            t.(j).blah <- (t.(j).blah + 1);
            let out0 = (((out0 + t.(j).foo) + (t.(j).blah * t.(j).bar)) + (t.(j).bar * t.(j).foo)) in
            (a (j + 1) out0)
            )
     
     else out0) in
    (a b out0)
let main =
  ((fun  (e, t) -> (
                     e;
                     Scanf.scanf "%d"
                     (fun  g -> (
                                  t.(0).bar <- g;
                                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                  Scanf.scanf "%d"
                                  (fun  f -> (
                                               t.(1).blah <- f;
                                               let titi = (result t 4) in
                                               (
                                                 (Printf.printf "%d%d" titi t.(2).blah)
                                                 )
                                               
                                               )
                                  )
                                  )
                     )
                     )
  ) (Array.init_withenv 4 (fun  i () -> let d = (mktoto i) in
  ((), d)) ()))

