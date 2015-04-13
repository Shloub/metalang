let is_number c =
  (((int_of_char (c)) <= (int_of_char ('9'))) && ((int_of_char (c)) >= (int_of_char ('0'))))
let npi0 str len =
  let stack = (Array.init len (fun  i -> 0)) in
  let ptrStack = 0 in
  let ptrStr = 0 in
  let rec a ptrStack ptrStr =
    (if (ptrStr < len)
     then (if (str.(ptrStr) = ' ')
           then let ptrStr = (ptrStr + 1) in
           (a ptrStack ptrStr)
           else (if (is_number str.(ptrStr))
                 then let num = 0 in
                 let rec b num ptrStr =
                   (if (str.(ptrStr) <> ' ')
                    then let num = (((num * 10) + (int_of_char (str.(ptrStr)))) - (int_of_char ('0'))) in
                    let ptrStr = (ptrStr + 1) in
                    (b num ptrStr)
                    else (
                           stack.(ptrStack) <- num;
                           let ptrStack = (ptrStack + 1) in
                           (a ptrStack ptrStr)
                           )
                    ) in
                   (b num ptrStr)
                 else (if (str.(ptrStr) = '+')
                       then (
                              stack.((ptrStack - 2)) <- (stack.((ptrStack - 2)) + stack.((ptrStack - 1)));
                              let ptrStack = (ptrStack - 1) in
                              let ptrStr = (ptrStr + 1) in
                              (a ptrStack ptrStr)
                              )
                       
                       else (a ptrStack ptrStr))))
     else stack.(0)) in
    (a ptrStack ptrStr)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  d -> let len = d in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init len (fun  i -> let tmp = '\000' in
    Scanf.scanf "%c"
    (fun  e -> e))) in
    let result = (npi0 tab len) in
    (Printf.printf "%d" result)
    )
  )

