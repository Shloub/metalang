let () =
begin
  Printf.printf "%d %d %d %d %d %d\n" (min (min (2) (3)) (4)) (min (min (2) (4)) (3)) (min (min (3) (2)) (4)) (min (min (3) (4)) (2)) (min (min (4) (2)) (3)) (min (min (4) (3)) (2))
end
 