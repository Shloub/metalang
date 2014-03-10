(*
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*)
type toto = {
  mutable foo : int;
  mutable bar : int;
  mutable blah : int;
};;

let rec mktoto v1 =
  let t__ = {
    foo=v1;
    bar=v1;
    blah=v1;
  } in
  t__

let rec result t_ t2_ =
  let t__ = ref( t_ ) in
  let t2 = ref( t2_ ) in
  let t3 = ref(
  {
    foo=0;
    bar=0;
    blah=0;
  }) in
  t3 := (!t2);
  t__ := (!t2);
  t2 := (!t3);
  (!t__).blah <- (!t__).blah + 1;
  let len = 1 in
  let cache0 = ref( Array.init len (fun i ->
    -i)) in
  let cache1 = Array.init len (fun j ->
    j) in
  let cache2 = ref( (!cache0) ) in
  cache0 := cache1;
  cache2 := (!cache0);
  (!t__).foo + (!t__).blah * (!t__).bar + (!t__).bar * (!t__).foo

let () =
begin
  let t__ = mktoto 4 in
  let t2 = mktoto 5 in
  Scanf.scanf "%d" (fun value -> t__.bar <- value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> t__.blah <- value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> t2.bar <- value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> t__.blah <- value);
  let a = result t__ t2 in
  Printf.printf "%d" a;
  let b = t__.blah in
  Printf.printf "%d" b
end
 