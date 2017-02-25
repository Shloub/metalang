type toto = {
  mutable foo : int;
  mutable bar : int;
};;
let () =
 let param = {foo=0;
 bar=0} in
  Scanf.scanf "%d %d" (fun e f -> param.bar <- e;
                                  param.foo <- f);
  Printf.printf "%d" (param.bar + param.foo * param.bar) 
 