type toto = {
  mutable foo : int;
  mutable bar : int;
};;

let () =
begin
  let param = {foo=0;
  bar=0} in
  Scanf.scanf "%d %d" (fun v_0 v_1 -> param.bar <- v_0;
                                      param.foo <- v_1);
  Printf.printf "%d" (param.bar + param.foo * param.bar)
end
 