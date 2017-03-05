let () =
 for _i = 1 to 3 do
   let a, b = Scanf.scanf "%d %d " (fun a b -> a, b) in
   Printf.printf "a = %d b = %d\n" a b
  done;
  let l = Array.init 10 (fun _c ->
    let d = Scanf.scanf "%d " (fun d -> d) in
    d) in
  for j = 0 to 9 do
    Printf.printf "%d\n" l.(j)
  done 
 