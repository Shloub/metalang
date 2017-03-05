let () =
 let str = Array.init 12 (fun _a ->
   let b = Scanf.scanf "%c" (fun b -> b) in
   b) in
  Scanf.scanf " " ();
  for i = 0 to 11 do
    Printf.printf "%c" str.(i)
  done 
 