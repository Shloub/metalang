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

let rec result t_ len =
  let out_ = ref( 0 ) in
  for j = 0 to len - 1 do
    t_.(j).blah <- t_.(j).blah + 1;
    out_ := (!out_) + t_.(j).foo + t_.(j).blah * t_.(j).bar + t_.(j).bar * t_.(j).foo
  done;
  (!out_)

let () =
begin
  let a = 4 in
  let t_ = Array.init a (fun i ->
    mktoto i) in
  Scanf.scanf "%d" (fun value -> t_.(0).bar <- value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> t_.(1).blah <- value);
  let b = result t_ 4 in
  Printf.printf "%d" b;
  let c = t_.(2).blah in
  Printf.printf "%d" c
end
 