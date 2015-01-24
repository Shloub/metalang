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

let programme_candidat tableau1 taille1 tableau2 taille2 =
  let out0 = 0 in
  let r = 0 in
  let s = (taille1 - 1) in
  let rec q i out0 =
    (if (i <= s)
     then let out0 = (out0 + ((int_of_char (tableau1.(i))) * i)) in
     (
       (Printf.printf "%c" tableau1.(i));
       (q (i + 1) out0)
       )
     
     else (
            (Printf.printf "--\n" );
            let o = 0 in
            let p = (taille2 - 1) in
            let rec m j out0 =
              (if (j <= p)
               then let out0 = (out0 + ((int_of_char (tableau2.(j))) * (j * 100))) in
               (
                 (Printf.printf "%c" tableau2.(j));
                 (m (j + 1) out0)
                 )
               
               else (
                      (Printf.printf "--\n" );
                      out0
                      )
               ) in
              (m o out0)
            )
     ) in
    (q r out0)
let main =
  let taille1 = (Scanf.scanf "%d " (fun x -> x)) in
  let taille2 = (Scanf.scanf "%d " (fun x -> x)) in
  let tableau1 = (Array.init_withenv taille1 (fun  e () -> Scanf.scanf "%c"
  (fun  f -> let u = f in
  ((), u))) ()) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tableau2 = (Array.init_withenv taille2 (fun  k () -> Scanf.scanf "%c"
    (fun  l -> let v = l in
    ((), v))) ()) in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      (Printf.printf "%d\n" (programme_candidat tableau1 taille1 tableau2 taille2))
      )
    
    )
  

