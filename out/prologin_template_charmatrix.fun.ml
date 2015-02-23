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

let programme_candidat tableau taille_x taille_y =
  let out0 = 0 in
  let k = (taille_y - 1) in
  let rec f i out0 =
    (if (i <= k)
     then let h = (taille_x - 1) in
     let rec g j out0 =
       (if (j <= h)
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
       (g 0 out0)
     else out0) in
    (f 0 out0)
let main =
  let taille_x = (Scanf.scanf "%d " (fun x -> x)) in
  let taille_y = (Scanf.scanf "%d " (fun x -> x)) in
  ((fun  (m, a) -> (
                     m;
                     let tableau = a in
                     (
                       (Printf.printf "%d\n" (programme_candidat tableau taille_x taille_y))
                       )
                     
                     )
  ) (Array.init_withenv taille_y (fun  b () -> ((fun  (p, d) -> (
                                                                  p;
                                                                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                                                  let l = d in
                                                                  ((), l)
                                                                  )
  ) (Array.init_withenv taille_x (fun  e () -> Scanf.scanf "%c"
  (fun  c -> let o = c in
  ((), o))) ()))) ()))

