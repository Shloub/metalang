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
  let out_ = 0 in
  let g = 0 in
  let h = (taille - 1) in
  let rec f i out_ =
    (if (i <= h)
     then let out_ = (out_ + ((int_of_char (tableau.(i))) * i)) in
     (
       (Printf.printf "%c" tableau.(i));
       (f (i + 1) out_)
       )
     
     else (
            (Printf.printf "--\n" );
            out_
            )
     ) in
    (f g out_)
let main =
  let a = (Scanf.scanf "%d " (fun x -> x)) in
  let taille = a in
  let c = (Array.init_withenv taille (fun  d () -> Scanf.scanf "%c"
  (fun  e -> let j = e in
  ((), j))) ()) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let b = c in
    let tableau = b in
    (
      (Printf.printf "%d\n" (programme_candidat tableau taille))
      )
    
    )
  

