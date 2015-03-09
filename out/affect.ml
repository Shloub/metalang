(*
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*)
type toto = {
  mutable foo : int;
  mutable bar : int;
  mutable blah : int;
};;

let mktoto v1 =
  let t = {
    foo=v1;
    bar=v1;
    blah=v1;
  } in
  t

let mktoto2 v1 =
  let t = {
    foo=v1 + 3;
    bar=v1 + 2;
    blah=v1 + 1;
  } in
  t

let result t_ t2_ =
  let t = t_ in
  let t2 = t2_ in
  let t3 = {
    foo=0;
    bar=0;
    blah=0;
  } in
  let t3 = t2 in
  let t = t2 in
  let t2 = t3 in
  t.blah <- t.blah + 1;
  let len = 1 in
  let cache0 = Array.init len (fun i ->
    -i) in
  let cache1 = Array.init len (fun j ->
    j) in
  let cache2 = cache0 in
  let cache0 = cache1 in
  let cache2 = cache0 in
  t.foo + t.blah * t.bar + t.bar * t.foo

let () =
begin
  let t = mktoto 4 in
  let t2 = mktoto 5 in
  Scanf.scanf "%d %d %d %d" (fun v_0 v_1 v_2 v_3 -> t.bar <- v_0;
                                                    t.blah <- v_1;
                                                    t2.bar <- v_2;
                                                    t2.blah <- v_3);
  Printf.printf "%d%d" (result t t2) t.blah
end
 