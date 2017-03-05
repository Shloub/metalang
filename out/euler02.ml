
let () =
 let a = ref( 1 ) in
  let b = ref( 2 ) in
  let sum = ref( 0 ) in
  while (!a) < 4000000 do
    if (!a) mod 2 = 0 then
      sum := (!sum) + (!a);
    let c = (!a) in
    a := (!b);
    b := (!b) + c
  done;
  Printf.printf "%d\n" (!sum) 
 