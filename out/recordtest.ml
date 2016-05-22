type toto = {
  mutable foo : int;
  mutable bar : int;
};;

let () =
begin
  let param = {foo=0;
  bar=0} in
  Scanf.scanf "%d %d" (fun a b -> param.bar <- a;
                                  param.foo <- b);
  Printf.printf "%d" (param.bar + param.foo * param.bar)
end
 