(*
La suite de fibonaci
*)
let fibo0 a b i =
  let out0 = ref( 0 ) in
  let a2 = ref( a ) in
  let b2 = ref( b ) in
  for _j = 0 to i + 1 do
    out0 := (!out0) + (!a2);
    let tmp = (!b2) in
    b2 := (!b2) + (!a2);
    a2 := tmp
  done;
  (!out0)
let () =
 let a, b, i = Scanf.scanf "%d %d %d" (fun a b i -> a, b, i) in
  Printf.printf "%d" (fibo0 a b i) 
 