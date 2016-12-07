let rec pgcd a b =
  let c = (min (a) (b)) in
  let d = (max (a) (b)) in
  let reste = d mod c in
  if reste = 0 then
    c
  else
    pgcd c reste

let () =
 let top = ref( 1 ) in
  let bottom = ref( 1 ) in
  for i = 1 to 9 do
    for j = 1 to 9 do
      for k = 1 to 9 do
        if i <> j && j <> k then
          let a = i * 10 + j in
          let b = j * 10 + k in
          if a * k = i * b then
            begin
               Printf.printf "%d/%d\n" a b;
               top := (!top) * a;
               bottom := (!bottom) * b
            end
      done
    done
  done;
  Printf.printf "%d/%d\n" (!top) (!bottom);
  let p = pgcd (!top) (!bottom) in
  Printf.printf "pgcd=%d\n%d\n" p ((!bottom) / p) 
 