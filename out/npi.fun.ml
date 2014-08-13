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
      let stack = (Array.init_withenv len (fun i ->
                                              (fun (str, len) ->
                                                  let a = 0 in
                                                  ((str, len), a))) (str, len)) in
      let ptrStack = 0 in
      let ptrStr = 0 in
      let rec d ptrStr ptrStack str len =
        (if (ptrStr < len)
         then let e = (fun ptrStr ptrStack str len ->
                          (d ptrStr ptrStack str len)) in
         (if (str.(ptrStr) = ' ')
          then let ptrStr = (ptrStr + 1) in
          (e ptrStr ptrStack str len)
          else let f = (fun ptrStr ptrStack str len ->
                           (e ptrStr ptrStack str len)) in
          (if (is_number str.(ptrStr))
           then let num = 0 in
           let rec h num ptrStr ptrStack str len =
             (if (str.(ptrStr) <> ' ')
              then let num = (((num * 10) + (int_of_char (str.(ptrStr)))) - (int_of_char ('0'))) in
              let ptrStr = (ptrStr + 1) in
              (h num ptrStr ptrStack str len)
              else (stack.(ptrStack) <- num; let ptrStack = (ptrStack + 1) in
              (f ptrStr ptrStack str len))) in
             (h num ptrStr ptrStack str len)
           else let j = (fun ptrStr ptrStack str len ->
                            (f ptrStr ptrStack str len)) in
           (if (str.(ptrStr) = '+')
            then (stack.((ptrStack - 2)) <- (stack.((ptrStack - 2)) + stack.((ptrStack - 1))); let ptrStack = (ptrStack - 1) in
            let ptrStr = (ptrStr + 1) in
            (j ptrStr ptrStack str len))
            else (j ptrStr ptrStack str len))))
         else stack.(0)) in
        (d ptrStr ptrStack str len));;
let rec main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun m ->
      let len = m in
      (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
       i len ->
      let tmp = '\000' in
      Scanf.scanf "%c"
      (fun l ->
          let tmp = l in
          let k = tmp in
          (len, k))) len) in
      let result = (npi_ tab len) in
      (Printf.printf "%d" result))));;

