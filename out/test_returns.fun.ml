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

let rec is_pair =
  (fun i ->
      ((fun j ->
           ((fun c ->
                (if (i < 10)
                 then ((fun j ->
                           ((fun e ->
                                (if (i = 0)
                                 then ((fun j ->
                                           true) 4)
                                 else (e j i))) (fun j i ->
                                                    ((fun j ->
                                                         ((fun d ->
                                                              (if (i = 2)
                                                               then ((fun
                                                                j ->
                                                               true) 4)
                                                               else (d j i))) (fun
                                                          j i ->
                                                         ((fun j ->
                                                              (c j i)) 5)))) 3)))) 2)
                 else (c j i))) (fun j i ->
                                    ((fun j ->
                                         ((fun a ->
                                              (if (i < 20)
                                               then ((fun b ->
                                                         (if (i = 22)
                                                          then ((fun j ->
                                                                    (b j i)) 0)
                                                          else (b j i))) (fun
                                                j i ->
                                               ((fun j ->
                                                    (a j i)) 8)))
                                               else (a j i))) (fun j i ->
                                                                  ((i mod 2) = 0)))) 6)))) 1));;
let rec main =
  ();;

