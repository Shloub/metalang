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

let read_int () =
  Scanf.scanf "%d"
  (fun  out_ -> (
                  (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                  out_
                  )
  )
let read_int_line n =
  let tab = (Array.init_withenv n (fun  i () -> Scanf.scanf "%d"
  (fun  t -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let d = t in
               ((), d)
               )
  )) ()) in
  tab
let programme_candidat tableau taille =
  let out_ = 0 in
  let b = 0 in
  let c = (taille - 1) in
  let rec a i out_ =
    (if (i <= c)
     then let out_ = (out_ + tableau.(i)) in
     (a (i + 1) out_)
     else out_) in
    (a b out_)
let main =
  let taille = (read_int ()) in
  let tableau = (read_int_line taille) in
  (
    (Printf.printf "%d" (programme_candidat tableau taille));
    (Printf.printf "%s" "\n")
    )
  

