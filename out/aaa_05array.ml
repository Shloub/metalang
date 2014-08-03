let () =
begin
  let b = 5 in
  let _a = Array.init b (fun i ->
    Printf.printf "%d" i (*--*);
    i * 2 (*--*)) in (*--*) ()
end
 