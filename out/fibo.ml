(*
La suite de fibonaci
*)
let rec fibo_ a b i =
  let out_ = ref( 0 ) in
  let a2 = ref( a ) in
  let b2 = ref( b ) in
  for j = 0 to i + 1 do
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
  Scanf.scanf "%d" (fun value -> a := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> b := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> i := value);
  let c = fibo_ (!a) (!b) (!i) in
  Printf.printf "%d" c
end
 