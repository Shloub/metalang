let () =
begin
  let i = ref( 4 ) in
  (*while i < 10 do *)
  Printf.printf "%d" (!i);
  i := (!i) + 1
  (*  end *);
  Printf.printf "%d" (!i)
end
 