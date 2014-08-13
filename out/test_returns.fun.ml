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
      let j = 1 in
      let c = (fun j i ->
                  let j = 6 in
                  let a = (fun j i ->
                              ((i mod 2) = 0)) in
                  (if (i < 20)
                   then let b = (fun j i ->
                                    let j = 8 in
                                    (a j i)) in
                   (if (i = 22)
                    then let j = 0 in
                    (b j i)
                    else (b j i))
                   else (a j i))) in
      (if (i < 10)
       then let j = 2 in
       let e = (fun j i ->
                   let j = 3 in
                   let d = (fun j i ->
                               let j = 5 in
                               (c j i)) in
                   (if (i = 2)
                    then let j = 4 in
                    true
                    else (d j i))) in
       (if (i = 0)
        then let j = 4 in
        true
        else (e j i))
       else (c j i)));;
let rec main =
  ();;

