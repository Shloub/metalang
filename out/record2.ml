type toto = {
  mutable foo : int;
  mutable bar : int;
  mutable blah : int;
};;

let rec mktoto v1 =
  let t_ = {
    foo=v1;
    bar=0;
    blah=0;
  } in
  t_

let rec result t_ =
  t_.blah <- t_.blah + 1;
  t_.foo + t_.blah * t_.bar + t_.bar * t_.foo

let () =
begin
  let t_ = mktoto 4 in
  Scanf.scanf "%d" (fun value -> t_.bar <- value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> t_.blah <- value);
  let a = result t_ in
  Printf.printf "%d" a;
  let b = t_.blah in
  Printf.printf "%d" b
end
 