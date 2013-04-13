let rec fibo a b i =
  let out_ = ref( 0 ) in
  let a2 = ref( a ) in
  let b2 = ref( b ) in
  for j = 0 to i + 1 do
    Printf.printf "%d" (j);
    out_ := (!out_) + (!a2);
    let tmp = (!b2) in
    b2 := (!b2) + (!a2);
    a2 := tmp
  done;
  (!out_)

let () =
begin
  let k = fibo 1 2 4 in
  Printf.printf "%d" (k)
end
 