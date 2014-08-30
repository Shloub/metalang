let min2 a b =
  min a b

let () =
begin
  Printf.printf "%d %d %d %d %d %d\n" (min2 (min2 2 3) 4) (min2 (min2 2 4) 3) (min2 (min2 3 2) 4) (min2 (min2 3 4) 2) (min2 (min2 4 2) 3) (min2 (min2 4 3) 2)
end
 