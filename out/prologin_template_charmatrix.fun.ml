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

let programme_candidat tableau taille_x taille_y =
  let out0 = 0 in
  let l = 0 in
  let m = (taille_y - 1) in
  let rec f i out0 =
    (if (i <= m)
     then let h = 0 in
     let k = (taille_x - 1) in
     let rec g j out0 =
       (if (j <= k)
        then let out0 = (out0 + ((int_of_char (tableau.(i).(j))) * (i + (j * 2)))) in
        (
          (Printf.printf "%c" tableau.(i).(j));
          (g (j + 1) out0)
          )
        
        else (
               (Printf.printf "--\n" );
               (f (i + 1) out0)
               )
        ) in
       (g h out0)
     else out0) in
    (f l out0)
let main =
  let taille_x = (Scanf.scanf "%d " (fun x -> x)) in
  let taille_y = (Scanf.scanf "%d " (fun x -> x)) in
  let a = (Array.init_withenv taille_y (fun  b () -> let d = (Array.init_withenv taille_x (fun  e () -> Scanf.scanf "%c"
  (fun  c -> let p = c in
  ((), p))) ()) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let o = d in
    ((), o)
    )
  ) ()) in
  let tableau = a in
  (
    (Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y))
    )
  

