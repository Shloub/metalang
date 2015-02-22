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

let programme_candidat tableau1 taille1 tableau2 taille2 =
  let out0 = 0 in
  let k = 0 in
  let l = (taille1 - 1) in
  let rec h i out0 =
    (if (i <= l)
     then let out0 = (out0 + ((int_of_char (tableau1.(i))) * i)) in
     (
       (Printf.printf "%c" tableau1.(i));
       (h (i + 1) out0)
       )
     
     else (
            (Printf.printf "--\n" );
            let f = 0 in
            let g = (taille2 - 1) in
            let rec e j out0 =
              (if (j <= g)
               then let out0 = (out0 + ((int_of_char (tableau2.(j))) * (j * 100))) in
               (
                 (Printf.printf "%c" tableau2.(j));
                 (e (j + 1) out0)
                 )
               
               else (
                      (Printf.printf "--\n" );
                      out0
                      )
               ) in
              (e f out0)
            )
     ) in
    (h k out0)
let main =
  let taille1 = (Scanf.scanf "%d " (fun x -> x)) in
  let taille2 = (Scanf.scanf "%d " (fun x -> x)) in
  ((fun  (o, tableau1) -> (
                            o;
                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                            ((fun  (q, tableau2) -> (
                                                      q;
                                                      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                                                      (Printf.printf "%d\n" (programme_candidat tableau1 taille1 tableau2 taille2))
                                                      )
                            ) (Array.init_withenv taille2 (fun  c () -> Scanf.scanf "%c"
                            (fun  d -> let p = d in
                            ((), p))) ()))
                            )
  ) (Array.init_withenv taille1 (fun  a () -> Scanf.scanf "%c"
  (fun  b -> let m = b in
  ((), m))) ()))

