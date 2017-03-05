let foo _a =
  let _a = 4 in
  ()
let () =
 let a = 0 in
  foo a;
  Printf.printf "%d\n" a 
 