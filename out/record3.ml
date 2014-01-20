type toto = {
  mutable foo : int;
  mutable bar : int;
  mutable blah : int;
};;

let rec mktoto v1 =
  let t = {
    foo=v1;
    bar=0;
    blah=0;
  } in
  t

let rec result t len =
  let out_ = ref( 0 ) in
  for j = 0 to len - 1 do
    t.(j).blah <- t.(j).blah + 1;
    out_ := (!out_) + t.(j).foo + t.(j).blah * t.(j).bar + t.(j).bar * t.(j).foo
  done;
  (!out_)

let () =
begin
  let a = 4 in
  let t = Array.init (a) (fun i ->
    mktoto i) in
  Scanf.scanf "%d" (fun value -> t.(0).bar <- value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> t.(1).blah <- value);
  let b = result t 4 in
  Printf.printf "%d" b;
  let c = t.(2).blah in
  Printf.printf "%d" c
end
 