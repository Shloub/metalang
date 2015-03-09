let foo a =
  let a = 4 in ()

let () =
begin
  let a = 0 in
  foo a;
  Printf.printf "%d\n" a
end
 