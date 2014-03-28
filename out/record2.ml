type toto = {
  mutable foo : int;
  mutable bar : int;
  mutable blah : int;
};;

let rec mktoto v1 =
  let t = { foo=v1;
  bar=0;
  blah=0; } in
  t

let rec result t =
  t.blah <- t.blah + 1;
  t.foo + t.blah * t.bar + t.bar * t.foo

let () =
begin
  let t = mktoto 4 in
  Scanf.scanf "%d" (fun value -> t.bar <- value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> t.blah <- value);
  let a = result t in
  Printf.printf "%d" a;
  let b = t.blah in
  Printf.printf "%d" b
end
 