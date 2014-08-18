let f =
  (fun tuple_ ->
      ((fun (a, b) ->
           ((a + 1), (b + 1))) tuple_));;
let main =
  let t = (f (0, 1)) in
  ((fun (a, b) ->
       (
         (Printf.printf "%d" a);
         (Printf.printf "%s" " -- ");
         (Printf.printf "%d" b);
         (Printf.printf "%s" "--\n")
         )
       ) t);;

