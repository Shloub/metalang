let summax lst len =
  let current = ref( 0 ) in
  let max0 = ref( 0 ) in
  for i = 0 to len - 1 do
    current := (!current) + lst.(i);
    if (!current) < 0 then
      current := 0;
    if (!max0) < (!current) then
      max0 := (!current)
  done;
  (!max0)

let () =
 let len = 0 in
  let len = Scanf.scanf "%d " (fun len -> len) in
  let tab = Array.init len (fun i ->
    let tmp = ref( 0 ) in
    Scanf.scanf "%d " (fun c -> tmp := c);
    (!tmp)) in
  let result = summax tab len in
  Printf.printf "%d" result 
 