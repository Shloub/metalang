let rec nth tab tofind len =
  let out_ = ref( 0 ) in
  for i = 0 to len - 1 do
    if tab.(i) = tofind then
      out_ := (!out_) + 1
  done;
  (!out_)

let () =
begin
  let len = ref( 0 ) in
  Scanf.scanf "%d" (fun value -> len := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let tofind = ref( '\000' ) in
  Scanf.scanf "%c" (fun value -> tofind := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let tab = Array.init ((!len)) (fun _i ->
    let tmp = ref( '\000' ) in
    Scanf.scanf "%c" (fun value -> tmp := value);
    (!tmp)) in
  let result = nth tab (!tofind) (!len) in
  Printf.printf "%d" result
end
 