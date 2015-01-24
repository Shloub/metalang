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

let programme_candidat tableau x y =
  let out0 = 0 in
  let v = 0 in
  let w = (y - 1) in
  let rec q i out0 =
    (if (i <= w)
     then let s = 0 in
     let u = (x - 1) in
     let rec r j out0 =
       (if (j <= u)
        then let out0 = (out0 + (tableau.(i).(j) * ((i * 2) + j))) in
        (r (j + 1) out0)
        else (q (i + 1) out0)) in
       (r s out0)
     else out0) in
    (q v out0)
let main =
  let taille_x = (Scanf.scanf "%d " (fun x -> x)) in
  let taille_y = (Scanf.scanf "%d " (fun x -> x)) in
  let tableau = (Array.init_withenv taille_y (fun  k () -> let p = (Array.init_withenv taille_x (fun  m () -> Scanf.scanf "%d"
  (fun  o -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let bb = o in
               ((), bb)
               )
  )) ()) in
  let ba = p in
  ((), ba)) ()) in
  (
    (Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y))
    )
  

