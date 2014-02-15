let rec go tab a b =
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
        go tab a m
      else
        go tab m b
    end

let rec plus_petit_ tab len =
  go tab 0 len

let () =
begin
  let len = ref( 0 ) in
  Scanf.scanf "%d" (fun value -> len := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let tab = Array.init (!len) (fun _i ->
    let tmp = ref( 0 ) in
    Scanf.scanf "%d" (fun value -> tmp := value);
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    (!tmp)) in
  let c = plus_petit_ tab (!len) in
  Printf.printf "%d" c
end
 