module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let programme_candidat tableau x y =
  let out0 = 0 in
  let h = (y - 1) in
  let rec e i out0 =
    (if (i <= h)
     then let g = (x - 1) in
     let rec f j out0 =
       (if (j <= g)
        then let out0 = (out0 + (tableau.(i).(j) * ((i * 2) + j))) in
        (f (j + 1) out0)
        else (e (i + 1) out0)) in
       (f 0 out0)
     else out0) in
    (e 0 out0)
let main =
  let taille_x = (Scanf.scanf "%d " (fun x -> x)) in
  let taille_y = (Scanf.scanf "%d " (fun x -> x)) in
  ((fun  (l, tableau) -> (
                           (Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y))
                           )
  ) (Array.init_withenv taille_y (fun  a l -> ((fun  (o, c) -> let k = c in
  ((), k)) (Array.init_withenv taille_x (fun  d o -> Scanf.scanf "%d"
  (fun  b -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let m = b in
               ((), m)
               )
  )) ()))) ()))

