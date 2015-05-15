let f i =
  if i = 0
  then true
  else false
let main =
  ( if f 4
    then Printf.printf "%s" "true <-\n ->\n"
    else Printf.printf "%s" "false <-\n ->\n";
    Printf.printf "%s" "small test end\n")

