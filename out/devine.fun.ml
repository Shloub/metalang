let devine0 nombre tab len =
  let min0 = tab.(0) in
  let max0 = tab.(1) in
  let rec a i max0 min0 =
    if i <= len - 1
    then if tab.(i) > max0 || tab.(i) < min0
         then false
         else let min0 = if tab.(i) < nombre
                         then tab.(i)
                         else min0 in
         let max0 = if tab.(i) > nombre
                    then tab.(i)
                    else max0 in
         if tab.(i) = nombre && len <> i + 1
         then false
         else a (i + 1) max0 min0
    else true in
    a 2 max0 min0
let main =
  Scanf.scanf "%d"
  (fun nombre -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                   Scanf.scanf "%d"
                   (fun len -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                                 let tab = Array.init len (fun i -> Scanf.scanf "%d"
                                 (fun tmp -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                                               tmp))) in
                                 if devine0 nombre tab len
                                 then Printf.printf "%s" "True"
                                 else Printf.printf "%s" "False"))))

