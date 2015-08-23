let main =
  ( Printf.printf "%s" "Hello World";
    let a = 5 in
    ( Printf.printf "%d \n%dfoo" ((4 + 6) * 2) a;
      if 1 + (1 + 1) * 2 * (3 + 8) / 4 - (1 - 2) - 3 = 12 && true
      then Printf.printf "%s" "True"
      else Printf.printf "%s" "False";
      Printf.printf "%s" "\n";
      if (3 * (4 + 5 + 6) * 2 = 45) = false
      then Printf.printf "%s" "True"
      else Printf.printf "%s" "False";
      Printf.printf "%s" " ";
      if (2 = 1) = false
      then Printf.printf "%s" "True"
      else Printf.printf "%s" "False";
      Printf.printf " %d%d" ((4 + 1) / 3 / (2 + 1)) (4 * 1 / 3 / 2 * 1);
      if not (not (a = 0) && not (a = 4))
      then Printf.printf "%s" "True"
      else Printf.printf "%s" "False";
      if true && not false && not (true && false)
      then Printf.printf "%s" "True"
      else Printf.printf "%s" "False";
      Printf.printf "%s" "\n"))

