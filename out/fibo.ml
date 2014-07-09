(*
La suite de fibonaci
*)
let fibo_ a b i =
  let out_ = ref( 0 ) in
  let a2 = ref( a ) in
  let b2 = ref( b ) in
  for _j = 0 to i + 1 do
    out_ := (!out_) + (!a2);
    let tmp = (!b2) in
    b2 := (!b2) + (!a2);
    a2 := tmp
  done;
  (!out_)

let () =
begin
  let a = ref( 0 ) in
  let b = ref( 0 ) in
  let i = ref( 0 ) in
  Scanf.scanf "%d %d %d" (fun v_0 v_1 v_2 -> a := v_0;
                                             b := v_1;
                                             i := v_2);
  Printf.printf "%d" (fibo_ (!a) (!b) (!i))
end
 