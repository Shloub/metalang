let rec exp_ a b =
  if b = 0 then
    1
  else if (b mod 2) = 0 then
    begin
      let o = exp_ a (b / 2) in
      o * o
    end
  else
    a * exp_ a (b - 1)

let () =
begin
  let a = ref( 0 ) in
  let b = ref( 0 ) in
  Scanf.scanf "%d %d" (fun v_0 v_1 -> a := v_0;
                                      b := v_1);
  let c = exp_ (!a) (!b) in
  Printf.printf "%d" c
end
 