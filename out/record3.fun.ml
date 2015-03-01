type toto = {mutable foo : int; mutable bar : int; mutable blah : int;}
let mktoto v1 =
  let t = {foo=v1;
  bar=0;
  blah=0} in
  t
let result t len =
  let out0 = 0 in
  let rec a j out0 =
    (if (j <= (len - 1))
     then (
            t.(j).blah <- (t.(j).blah + 1);
            let out0 = (((out0 + t.(j).foo) + (t.(j).blah * t.(j).bar)) + (t.(j).bar * t.(j).foo)) in
            (a (j + 1) out0)
            )
     
     else out0) in
    (a 0 out0)
let main =
  let t = (Array.init 4 (fun  i -> (mktoto i))) in
  Scanf.scanf "%d"
  (fun  e -> (
               t.(0).bar <- e;
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               Scanf.scanf "%d"
               (fun  d -> (
                            t.(1).blah <- d;
                            let titi = (result t 4) in
                            (Printf.printf "%d%d" titi t.(2).blah)
                            )
               )
               )
  )

