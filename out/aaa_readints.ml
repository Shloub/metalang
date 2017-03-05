
let () =
 let len = Scanf.scanf "%d " (fun len -> len) in
  Printf.printf "%d=len\n" len;
  let tab1 = Array.init len (fun _a ->
    let b = Scanf.scanf "%d " (fun b -> b) in
    b) in
  for i = 0 to len - 1 do
    Printf.printf "%d=>%d\n" i tab1.(i)
  done;
  let len = Scanf.scanf "%d " (fun len -> len) in
  let tab2 = Array.init (len - 1) (fun _c ->
    let e = Array.init len (fun _f ->
      let d = Scanf.scanf "%d " (fun d -> d) in
      d) in
    e) in
  for i = 0 to len - 2 do
    for j = 0 to len - 1 do
      Printf.printf "%d " tab2.(i).(j)
    done;
    Printf.printf "\n"
  done 
 