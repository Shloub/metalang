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
  let input = ' ' in
  let current_pos = 500 in
  let a = 1000 in
  let mem = (Array.init_withenv a (fun i ->
                                      (fun (a, current_pos, input) ->
                                          let b = 0 in
                                          ((a, current_pos, input), b))) (a, current_pos, input)) in
  (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); let current_pos = (current_pos + 1) in
  (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); (mem.(current_pos) <- (mem.(current_pos) + 1); 
  let rec d a current_pos input =
    (if (mem.(current_pos) <> 0)
     then (mem.(current_pos) <- (mem.(current_pos) - 1); let current_pos = (current_pos - 1) in
     (mem.(current_pos) <- (mem.(current_pos) + 1); begin
                                                      (Printf.printf "%c" (char_of_int (mem.(current_pos))));
                                                      let current_pos = (current_pos + 1) in
                                                      (d a current_pos input)
                                                      end
     ))
     else ()) in
    (d a current_pos input))))))))))))))))))))))))))))))))))))))))))))))))))))))))));;

