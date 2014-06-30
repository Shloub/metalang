let rec go_ tab a b =
  let m = (a + b) / 2 in
  if a = m then
    begin
      if tab.(a) = m then
        b
      else
        a
    end
  else
    begin
      let i = ref( a ) in
      let j = ref( b ) in
      while (!i) < (!j)
      do
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
        go_ tab a m
      else
        go_ tab m b
    end

let plus_petit_ tab len =
  go_ tab 0 len

let () =
begin
  let len = ref( 0 ) in
  Scanf.scanf "%d " (fun v_0 -> len := v_0);
  let tab = Array.init (!len) (fun _i ->
    let tmp = ref( 0 ) in
    Scanf.scanf "%d " (fun v_0 -> tmp := v_0);
    (!tmp)) in
  let c = plus_petit_ tab (!len) in
  Printf.printf "%d" c
end
 