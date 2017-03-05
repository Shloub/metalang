let test tab len =
  for i = 0 to len - 1 do
    Printf.printf "%d " tab.(i)
  done;
  Printf.printf "\n"

let () =
 let t = Array.init 5 (fun _i ->
   1) in
  test t 5 
 