let sort_ tab len =
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
  Scanf.scanf "%d " (fun v_0 -> len := v_0);
  let tab = Array.init (!len) (fun _i_ ->
    let tmp = ref( 0 ) in
    Scanf.scanf "%d " (fun v_0 -> tmp := v_0);
    (!tmp)) in
  sort_ tab (!len);
  for i = 0 to (!len) - 1 do
    let a = tab.(i) in
    Printf.printf "%d" a
  done
end
 