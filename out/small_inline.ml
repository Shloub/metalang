let () =
 let t = Array.init 2 (fun d ->
   let out0 = Scanf.scanf "%d " (fun out0 -> out0) in
   out0) in
  Printf.printf "%d - %d\n" t.(0) t.(1) 
 