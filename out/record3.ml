type toto = {
  mutable foo : int;
  mutable bar : int;
  mutable blah : int;
};;
let mktoto v1 =
  let t = {foo=v1;
  bar=0;
  blah=0} in
  t
let result t len =
  let out0 = ref( 0 ) in
  for j = 0 to len - 1 do
    t.(j).blah <- t.(j).blah + 1;
    out0 := (!out0) + t.(j).foo + t.(j).blah * t.(j).bar + t.(j).bar * t.(j).foo
  done;
  (!out0)
let () =
 let t = Array.init 4 (fun i ->
   mktoto i) in
  Scanf.scanf "%d %d" (fun e f -> t.(0).bar <- e;
                                  t.(1).blah <- f);
  let titi = result t 4 in
  Printf.printf "%d%d" titi t.(2).blah 
 