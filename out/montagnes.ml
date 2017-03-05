let montagnes0 tab len =
  let max0 = ref( 1 ) in
  let j = ref( 1 ) in
  let i = ref( len - 2 ) in
  while (!i) >= 0 do
    let x = tab.((!i)) in
    while (!j) >= 0 && x > tab.(len - (!j)) do
      j := (!j) - 1
    done;
    j := (!j) + 1;
    tab.(len - (!j)) <- x;
    if (!j) > (!max0) then
      max0 := (!j);
    i := (!i) - 1
  done;
  (!max0)

let () =
 let len = 0 in
  let len = Scanf.scanf "%d " (fun len -> len) in
  let tab = Array.init len (fun _i ->
    let x = ref( 0 ) in
    Scanf.scanf "%d " (fun c -> x := c);
    (!x)) in
  Printf.printf "%d" (montagnes0 tab len) 
 