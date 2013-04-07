let rec sort_ tab len =
  for i = 0 to len - 1 do
    for j = i + 1 to len - 1 do
      if tab.(i) > tab.(j) then
        begin
          let tmp = tab.(i) in
          tab.(i) <- tab.(j);
          tab.(j) <- tmp
        end
    done
  done

let () =
begin
  let len = ref( 2 ) in
  Scanf.scanf "%d" (fun value -> len := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let tab = Array.init ((!len)) (fun i ->
    let tmp = ref( 0 ) in
    Scanf.scanf "%d" (fun value -> tmp := value);
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    (!tmp)) in
  sort_ tab (!len);
  for p = 0 to ((Array.length tab)) - 1 do
    Printf.printf "%d" (tab.(p))
  done
end
 