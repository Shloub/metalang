let main = ((if true
             then (fun () -> Printf.printf "%s" "true <-\n ->\n"; ((fun () -> ()) ()))
             else (fun () -> Printf.printf "%s" "false <-\n ->\n"; ((fun () -> ()) ()))) ());;

