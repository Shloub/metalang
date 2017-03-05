let rec go0 tab a b =
  let m = (a + b) / 2 in
  if a = m then
    if tab.(a) = m then
      b
    else
      a
  else
    begin
       let i = ref( a ) in
       let j = ref( b ) in
       while (!i) < (!j) do
         let e = tab.((!i)) in
         if e < m then
           i := (!i) + 1
         else
           begin
              j := (!j) - 1;
              tab.((!i)) <- tab.((!j));
              tab.((!j)) <- e
           end
       done;
       if (!i) < m then
         go0 tab a m
       else
         go0 tab m b
    end

let plus_petit0 tab len =
  go0 tab 0 len

let () =
 let len = 0 in
  let len = Scanf.scanf "%d " (fun len -> len) in
  let tab = Array.init len (fun _i ->
    let tmp = ref( 0 ) in
    Scanf.scanf "%d " (fun f -> tmp := f);
    (!tmp)) in
  Printf.printf "%d" (plus_petit0 tab len) 
 