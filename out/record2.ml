type toto = {
  mutable foo : int;
  mutable bar : int;
  mutable blah : int;
};;

let mktoto v1 =
  let t = {
    foo=v1;
    bar=0;
    blah=0;
  } in
  t

let result t =
  t.blah <- t.blah + 1;
  t.foo + t.blah * t.bar + t.bar * t.foo

let () =
begin
  let t = mktoto 4 in
  Scanf.scanf "%d %d" (fun v_0 v_1 -> t.bar <- v_0;
                                      t.blah <- v_1);
  let a = result t in
  Printf.printf "%d" a;
  let b = t.blah in
  Printf.printf "%d" b
end
 