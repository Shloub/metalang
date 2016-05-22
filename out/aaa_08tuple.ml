type toto = {
  mutable foo : (int * int);
  mutable bar : int;
};;

let () =
begin
  let bar_, c, d = Scanf.scanf "%d %d %d " (fun bar_ c d -> bar_, c, d) in
  let t = {foo=(c, d);
  bar=bar_} in
  let (a, b) = t.foo in
  Printf.printf "%d %d %d\n" a b t.bar
end
 