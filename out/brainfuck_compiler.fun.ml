module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let rec main =
  ((fun input ->
       ((fun current_pos ->
            ((fun a ->
                 ((fun mem ->
                      (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); ((fun
                       current_pos ->
                      (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); 
                      let rec d a current_pos input =
                        (if (mem.(current_pos) <> 0)
                         then (mem.(current_pos) <- (mem.(current_pos) - 1); ((fun
                          current_pos ->
                         (mem.(current_pos) <- (mem.(current_pos) + 1); (Printf.printf "%c" (char_of_int (mem.(current_pos)));
                         ((fun current_pos ->
                              (d a current_pos input)) (current_pos + 1))))) (current_pos - 1)))
                         else ()) in
                        (d a current_pos input)))))))))))) (current_pos + 1)))))))))))))))))))))))))))))))))))))))))))))))))) ((Array.init_withenv a (fun
                  i ->
                 (fun (a, current_pos, input) ->
                     ((fun b ->
                          ((a, current_pos, input), b)) 0))) ) (a, current_pos, input)))) 1000)) 500)) ' ');;

