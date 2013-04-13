type toto = {
  mutable foo : int;
  mutable bar : int;
};;

let () =
begin
  let param = {
    foo=0;
    bar=0;
  } in
  Scanf.scanf "%d" (fun value -> param.bar <- value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> param.foo <- value);
  let g = param.bar + (param.foo * param.bar) in
  Printf.printf "%d" (g)
end
 