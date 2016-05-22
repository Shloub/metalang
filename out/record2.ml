type toto = {
  mutable foo : int;
  mutable bar : int;
  mutable blah : int;
};;

let mktoto v1 =
  let t = {foo=v1;
  bar=0;
  blah=0} in
  t

let result t =
  t.blah <- t.blah + 1;
  t.foo + t.blah * t.bar + t.bar * t.foo

let () =
begin
  let t = mktoto 4 in
  Scanf.scanf "%d %d" (fun a b -> t.bar <- a;
                                  t.blah <- b);
  Printf.printf "%d" (result t)
end
 