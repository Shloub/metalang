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
     then let out_ = (out_ + tableau.(i)) in
     (f (i + 1) out_)
     else out_) in
    (f g out_)
let main =
  let taille = (Scanf.scanf "%d " (fun x -> x)) in
  let c = (Array.init_withenv taille (fun  d () -> Scanf.scanf "%d"
  (fun  e -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let j = e in
               ((), j)
               )
  )) ()) in
  let tableau = c in
  (
    (Printf.printf "%d\n" (programme_candidat tableau taille))
    )
  

