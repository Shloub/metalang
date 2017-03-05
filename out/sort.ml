let copytab tab len =
  let o = Array.init len (fun i ->
    tab.(i)) in
  o
let bubblesort tab len =
  for i = 0 to len - 1 do
    for j = i + 1 to len - 1 do
      if tab.(i) > tab.(j) then
        begin
           let tmp = tab.(i) in
           tab.(i) <- tab.(j);
           tab.(j) <- tmp
        end
    done
  done
let rec qsort0 tab len i j =
  let i = ref i in
  let j = ref j in
  if (!i) < (!j) then
    begin
       let i0 = (!i) in
       let j0 = (!j) in
       (* pivot : tab[0] *)
       while (!i) <> (!j) do
         if tab.((!i)) > tab.((!j)) then
           if (!i) = (!j) - 1 then
             begin
                (* on inverse simplement*)
                let tmp = tab.((!i)) in
                tab.((!i)) <- tab.((!j));
                tab.((!j)) <- tmp;
                i := (!i) + 1
             end
           else
             begin
                (* on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] *)
                let tmp = tab.((!i)) in
                tab.((!i)) <- tab.((!j));
                tab.((!j)) <- tab.((!i) + 1);
                tab.((!i) + 1) <- tmp;
                i := (!i) + 1
             end
         else
           j := (!j) - 1
       done;
       qsort0 tab len i0 ((!i) - 1);
       qsort0 tab len ((!i) + 1) j0
    end
let () =
 let len = 2 in
  let len = Scanf.scanf "%d " (fun len -> len) in
  let tab = Array.init len (fun _i_ ->
    let tmp = ref( 0 ) in
    Scanf.scanf "%d " (fun c -> tmp := c);
    (!tmp)) in
  let tab2 = copytab tab len in
  bubblesort tab2 len;
  for i = 0 to len - 1 do
    Printf.printf "%d " tab2.(i)
  done;
  Printf.printf "\n";
  let tab3 = copytab tab len in
  qsort0 tab3 len 0 (len - 1);
  for i = 0 to len - 1 do
    Printf.printf "%d " tab3.(i)
  done;
  Printf.printf "\n" 
 