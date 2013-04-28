let rec montagnes_ tab len =
  let max_ = ref( 1 ) in
  let j = ref( 1 ) in
  let i = ref( len - 2 ) in
  while (!i) >= 0
  do
      let x = tab.((!i)) in
      while ((!j) >= 0) && (x > tab.(len - (!j)))
      do
          j := (!j) - 1
      done;
      j := (!j) + 1;
      tab.(len - (!j)) <- x;
      if (!j) > (!max_) then
        max_ := (!j);
      i := (!i) - 1
  done;
  (!max_)

let () =
begin
  let len = ref( 0 ) in
  Scanf.scanf "%d" (fun value -> len := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let tab = Array.init ((!len)) (fun i ->
    let x = ref( 0 ) in
    Scanf.scanf "%d" (fun value -> x := value);
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    (!x)) in
  let h = montagnes_ tab (!len) in
  Printf.printf "%d" h
end
 