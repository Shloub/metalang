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

let rec is_number =
  (fun c ->
      (((int_of_char (c)) <= (int_of_char ('9'))) && ((int_of_char (c)) >= (int_of_char ('0')))));;
let rec npi_ =
  (fun str len ->
      ((fun stack ->
           ((fun ptrStack ->
                ((fun ptrStr ->
                     let rec d ptrStr ptrStack str len =
                       (if (ptrStr < len)
                        then ((fun e ->
                                  (if (str.(ptrStr) = ' ')
                                   then ((fun ptrStr ->
                                             (e ptrStr ptrStack str len)) (ptrStr + 1))
                                   else ((fun f ->
                                             (if (is_number str.(ptrStr))
                                              then ((fun num ->
                                                        let rec h num ptrStr ptrStack str len =
                                                          (if (str.(ptrStr) <> ' ')
                                                           then ((fun
                                                            num ->
                                                           ((fun ptrStr ->
                                                                (h num ptrStr ptrStack str len)) (ptrStr + 1))) (((num * 10) + (int_of_char (str.(ptrStr)))) - (int_of_char ('0'))))
                                                           else (stack.(ptrStack) <- num; ((fun
                                                            ptrStack ->
                                                           (f ptrStr ptrStack str len)) (ptrStack + 1)))) in
                                                          (h num ptrStr ptrStack str len)) 0)
                                              else ((fun j ->
                                                        (if (str.(ptrStr) = '+')
                                                         then (stack.((ptrStack - 2)) <- (stack.((ptrStack - 2)) + stack.((ptrStack - 1))); ((fun
                                                          ptrStack ->
                                                         ((fun ptrStr ->
                                                              (j ptrStr ptrStack str len)) (ptrStr + 1))) (ptrStack - 1)))
                                                         else (j ptrStr ptrStack str len))) (fun
                                               ptrStr ptrStack str len ->
                                              (f ptrStr ptrStack str len))))) (fun
                                    ptrStr ptrStack str len ->
                                   (e ptrStr ptrStack str len))))) (fun
                         ptrStr ptrStack str len ->
                        (d ptrStr ptrStack str len)))
                        else stack.(0)) in
                       (d ptrStr ptrStack str len)) 0)) 0)) ((Array.init_withenv len (fun
       i ->
      (fun (str, len) ->
          ((fun a ->
               ((str, len), a)) 0))) ) (str, len))));;
let rec main =
  ((fun len ->
       Scanf.scanf "%d" (fun m ->
                            ((fun len ->
                                 (Scanf.scanf "%[\n \010]" (fun _ -> ((fun
                                  tab ->
                                 ((fun result ->
                                      (Printf.printf "%d" result;
                                      ())) (npi_ tab len))) ((Array.init_withenv len (fun
                                  i ->
                                 (fun (len) ->
                                     ((fun tmp ->
                                          Scanf.scanf "%c" (fun l ->
                                                               ((fun tmp ->
                                                                    ((fun
                                                                     k ->
                                                                    ((len), k)) tmp)) l))) '\000'))) ) (len)))))) m))) 0);;

