let f i =
  if i = 0 then
    true
  else
    false
let () =
 if f 4 then
    Printf.printf "true <-\n ->\n"
  else
    Printf.printf "false <-\n ->\n";
  Printf.printf "small test end\n" 
 