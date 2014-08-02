let g = (fun return i ->
            (((fun n o ->
                  ((fun j ->
                       (((fun l m ->
                             (((fun f k ->
                                   ((fun e ->
                                        ((if e
                                          then (fun () -> (return 0))
                                          else (fun () -> ((fun j ->
                                                               (return j)) j))) ())) (f = k))) 1) (l mod m))) 2) j)) (n * o))) 4) i));;
let h = (fun return i ->
            ((fun d ->
                 Printf.printf "%d" d;
                 ((fun c ->
                      Printf.printf "%s" c;
                      (return ())) "\n")) i));;
let main = ((h (fun () -> ((fun a ->
                               ((fun b ->
                                    (((fun t u ->
                                          ((fun s ->
                                               Printf.printf "%d" s;
                                               (*  main  *) ((h (fun () -> ((fun
                                                a ->
                                               ((fun b ->
                                                    (((fun q r ->
                                                          ((fun p ->
                                                               Printf.printf "%d" p;
                                                               ()) (q + r))) b) a)) 1)) 2))) 15)) (t + u))) b) a)) 5)) 4))) 14);;

