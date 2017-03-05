let () =
 for _i = 1 to 3 do
   let a, b, c = Scanf.scanf "%d %d %d " (fun a b c -> a, b, c) in
   Printf.printf "a = %d b = %dc =%d\n" a b c
  done;
  let l = Array.init 10 (fun _d ->
    let e = Scanf.scanf "%d " (fun e -> e) in
    e) in
  for j = 0 to 9 do
    Printf.printf "%d\n" l.(j)
  done 
 