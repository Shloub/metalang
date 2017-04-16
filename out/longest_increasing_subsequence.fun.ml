let rec dichofind len tab tofind a b =
  if a >= b - 1
  then a
  else let c = (a + b) / 2 in
  if tab.(c) < tofind
  then dichofind len tab tofind c b
  else dichofind len tab tofind a c

let process len tab =
  let size = Array.init len (fun j -> if j = 0
                                      then 0
                                      else len * 2) in
  let rec g i =
    if i <= len - 1
    then let k = dichofind len size tab.(i) 0 (len - 1) in
    if size.(k + 1) > tab.(i)
    then ( size.(k + 1) <- tab.(i);
           g (i + 1))
    else g (i + 1)
    else let rec h l =
           if l <= len - 1
           then ( Printf.printf "%d " size.(l);
                  h (l + 1))
           else let rec o m =
                  if m <= len - 1
                  then let k = len - 1 - m in
                  if size.(k) <> len * 2
                  then k
                  else o (m + 1)
                  else 0 in
                  o 0 in
           h 0 in
    g 0

let main =
  let n = (Scanf.scanf "%d " (fun x -> x)) in
  let rec p i =
    if i <= n
    then let len = (Scanf.scanf "%d " (fun x -> x)) in
    let e = Array.init len (fun f -> Scanf.scanf "%d"
    (fun d -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                d))) in
    ( Printf.printf "%d\n" (process len e);
      p (i + 1))
    else () in
    p 1

