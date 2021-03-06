let copytab tab len =
  Array.init len (fun i -> tab.(i))

let bubblesort tab len =
  let rec a i =
    if i <= len - 1
    then let rec b j =
           if j <= len - 1
           then if tab.(i) > tab.(j)
                then let tmp = tab.(i) in
                ( tab.(i) <- tab.(j);
                  tab.(j) <- tmp;
                  b (j + 1))
                else b (j + 1)
           else a (i + 1) in
           b (i + 1)
    else () in
    a 0

let rec qsort0 tab len i j =
  if i < j
  then let i0 = i in
  let j0 = j in
  (*  pivot : tab[0]  *)
  let rec c i j =
    if i <> j
    then if tab.(i) > tab.(j)
         then if i = j - 1
              then (*  on inverse simplement *)
              let tmp = tab.(i) in
              ( tab.(i) <- tab.(j);
                tab.(j) <- tmp;
                let i = i + 1 in
                c i j)
              else (*  on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1]  *)
              let tmp = tab.(i) in
              ( tab.(i) <- tab.(j);
                tab.(j) <- tab.(i + 1);
                tab.(i + 1) <- tmp;
                let i = i + 1 in
                c i j)
         else let j = j - 1 in
         c i j
    else ( qsort0 tab len i0 (i - 1);
           qsort0 tab len (i + 1) j0;
           ()) in
    c i j
  else ()

let main =
  let len = 2 in
  Scanf.scanf "%d"
  (fun d -> let len = d in
  ( Scanf.scanf "%[\n \010]" (fun _ -> ());
    let tab = Array.init len (fun i_ -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun g -> let tmp = g in
    ( Scanf.scanf "%[\n \010]" (fun _ -> ());
      tmp))) in
    let tab2 = copytab tab len in
    ( bubblesort tab2 len;
      let rec e i =
        if i <= len - 1
        then ( Printf.printf "%d " tab2.(i);
               e (i + 1))
        else ( Printf.printf "%s" "\n";
               let tab3 = copytab tab len in
               ( qsort0 tab3 len 0 (len - 1);
                 let rec f i =
                   if i <= len - 1
                   then ( Printf.printf "%d " tab3.(i);
                          f (i + 1))
                   else Printf.printf "%s" "\n" in
                   f 0)) in
        e 0)))

