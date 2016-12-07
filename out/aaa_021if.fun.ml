let testA a b =
  if a
  then if b
       then Printf.printf "%s" "A"
       else Printf.printf "%s" "B"
  else if b
       then Printf.printf "%s" "C"
       else Printf.printf "%s" "D"
let testB a b =
  if a
  then Printf.printf "%s" "A"
  else if b
       then Printf.printf "%s" "B"
       else Printf.printf "%s" "C"
let testC a b =
  if a
  then if b
       then Printf.printf "%s" "A"
       else Printf.printf "%s" "B"
  else Printf.printf "%s" "C"
let testD a b =
  if a
  then ( if b
         then Printf.printf "%s" "A"
         else Printf.printf "%s" "B";
         Printf.printf "%s" "C")
  else Printf.printf "%s" "D"
let testE a b =
  if a
  then if b
       then Printf.printf "%s" "A"
       else ()
  else ( if b
         then Printf.printf "%s" "C"
         else Printf.printf "%s" "D";
         Printf.printf "%s" "E")
let test a b =
  ( testD a b;
    testE a b;
    Printf.printf "%s" "\n")
let main =
  ( test true true;
    test true false;
    test false true;
    test false false;
    ())

