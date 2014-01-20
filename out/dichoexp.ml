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
  Scanf.scanf "%d" (fun value -> a := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  Scanf.scanf "%d" (fun value -> b := value);
  let c = exp_ (!a) (!b) in
  Printf.printf "%d" c
end
 