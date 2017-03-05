let testA a b =
  if a then
    if b then
      Printf.printf "A"
    else
      Printf.printf "B"
  else
    if b then
      Printf.printf "C"
    else
      Printf.printf "D"

let testB a b =
  if a then
    Printf.printf "A"
  else
    if b then
      Printf.printf "B"
    else
      Printf.printf "C"

let testC a b =
  if a then
    if b then
      Printf.printf "A"
    else
      Printf.printf "B"
  else
    Printf.printf "C"

let testD a b =
  if a then
    begin
       if b then
         Printf.printf "A"
       else
         Printf.printf "B";
       Printf.printf "C"
    end
  else
    Printf.printf "D"

let testE a b =
  if a then
    begin
       if b then
         Printf.printf "A"
    end
  else
    begin
       if b then
         Printf.printf "C"
       else
         Printf.printf "D";
       Printf.printf "E"
    end

let test a b =
  testD a b;
  testE a b;
  Printf.printf "\n"
let () =
 test true true;
  test true false;
  test false true;
  test false false 
 