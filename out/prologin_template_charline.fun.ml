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

let programme_candidat tableau taille =
  let out0 = 0 in
  let g = 0 in
  let h = (taille - 1) in
  let rec f i out0 =
    (if (i <= h)
     then let out0 = (out0 + ((int_of_char (tableau.(i))) * i)) in
     (
       (Printf.printf "%c" tableau.(i));
       (f (i + 1) out0)
       )
     
     else (
            (Printf.printf "--\n" );
            out0
            )
     ) in
    (f g out0)
let main =
  let taille = (Scanf.scanf "%d " (fun x -> x)) in
  let c = (Array.init_withenv taille (fun  d () -> Scanf.scanf "%c"
  (fun  e -> let j = e in
  ((), j))) ()) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tableau = c in
    (
      (Printf.printf "%d\n" (programme_candidat tableau taille))
      )
    
    )
  

