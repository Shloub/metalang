let max2 a b =
  if a > b then
    a
  else
    b

let min2 a b =
  if a < b then
    a
  else
    b

let rec pgcd a b =
  let c = min2 a b in
  let d = max2 a b in
  let reste = d mod c in
  if reste = 0 then
    c
  else
    pgcd c reste

let () =
begin
  let top = ref( 1 ) in
  let bottom = ref( 1 ) in
  for i = 1 to 9 do
    for j = 1 to 9 do
      for k = 1 to 9 do
        if i <> j && j <> k then
          begin
            let a = i * 10 + j in
            let b = j * 10 + k in
            if a * k = i * b then
              begin
                Printf.printf "%d" a;
                Printf.printf "/";
                Printf.printf "%d" b;
                Printf.printf "\n";
                top := (!top) * a;
                bottom := (!bottom) * b
              end
          end
      done
    done
  done;
  Printf.printf "%d" (!top);
  Printf.printf "/";
  Printf.printf "%d" (!bottom);
  Printf.printf "\n";
  let p = pgcd (!top) (!bottom) in
  Printf.printf "pgcd=";
  Printf.printf "%d" p;
  Printf.printf "\n";
  let e = (!bottom) / p in
  Printf.printf "%d" e;
  Printf.printf "\n"
end
 