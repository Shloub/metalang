let rec summax lst len =
  let current = ref( 0 ) in
  let max_ = ref( 0 ) in
  for i = 0 to len - 1 do
    current := (!current) + lst.(i);
    if (!current) < 0 then
      current := 0;
    if (!max_) < (!current) then
      max_ := (!current)
  done;
  (!max_)

let () =
begin
  let len = ref( 0 ) in
  Scanf.scanf "%d" (fun value -> len := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let tab = Array.init ((!len)) (fun i ->
    let tmp = ref( 0 ) in
    Scanf.scanf "%d" (fun value -> tmp := value);
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    (!tmp)) in
  let result = summax tab (!len) in
  Printf.printf "%d" result
end
 