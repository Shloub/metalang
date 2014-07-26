let foo i =
  Printf.printf "%d\n" i

let foobar i =
  Printf.printf "%d\nfoobar" i

let () =
begin
  let a = 0 in
  Printf.printf "%d\n" a;
  let b = 12 in
  Printf.printf "%d\nfoobar" b;
  let c = 1 in
  Printf.printf "%d\n" c
end
 