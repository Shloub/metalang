let rec find n m x y dx dy =
  if x < 0 || x = 20 || y < 0 || y = 20 then
    - 1
  else
    if n = 0 then
      1
    else
      m.(y).(x) * find (n - 1) m (x + dx) (y + dy) dx dy

let () =
 let directions = Array.init 8 (fun i ->
   if i = 0 then
     (0, 1)
   else
     if i = 1 then
       (1, 0)
     else
       if i = 2 then
         (0, - 1)
       else
         if i = 3 then
           (- 1, 0)
         else
           if i = 4 then
             (1, 1)
           else
             if i = 5 then
               (1, - 1)
             else
               if i = 6 then
                 (- 1, 1)
               else
                 (- 1, - 1)) in
  let max0 = ref( 0 ) in
  let m = Array.init 20 (fun c ->
    let e = Array.init 20 (fun f ->
      let d = Scanf.scanf "%d " (fun d -> d) in
      d) in
    e) in
  for j = 0 to 7 do
    let (dx, dy) = directions.(j) in
    for x = 0 to 19 do
      for y = 0 to 19 do
        max0 := (max ((!max0)) (find 4 m x y dx dy))
      done
    done
  done;
  Printf.printf "%d\n" (!max0) 
 