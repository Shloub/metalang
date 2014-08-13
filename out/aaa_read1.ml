let read_char_line n =
  let tab = Array.init n (fun _i ->
    let t = Scanf.scanf "%c" (fun v_0 -> v_0) in
    t) in
  Scanf.scanf " " (fun () -> ());
  tab

let () =
begin
  let str = read_char_line 12 in
  for i = 0 to 11 do
    Printf.printf "%c" str.(i)
  done
end
 