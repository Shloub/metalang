let rec pathfind_aux cache tab len pos =
  if pos >= len - 1 then
    0
  else
    if cache.(pos) <> - 1 then
      cache.(pos)
    else
      begin
         cache.(pos) <- len * 2;
         let posval = pathfind_aux cache tab len tab.(pos) in
         let oneval = pathfind_aux cache tab len (pos + 1) in
         let out0 = ref( 0 ) in
         if posval < oneval then
           out0 := 1 + posval
         else
           out0 := 1 + oneval;
         cache.(pos) <- (!out0);
         (!out0)
      end
let pathfind tab len =
  let cache = Array.init len (fun i ->
    - 1) in
  pathfind_aux cache tab len 0
let () =
 let len = 0 in
  let len = Scanf.scanf "%d " (fun len -> len) in
  let tab = Array.init len (fun i ->
    let tmp = ref( 0 ) in
    Scanf.scanf "%d " (fun c -> tmp := c);
    (!tmp)) in
  let result = pathfind tab len in
  Printf.printf "%d" result 
 