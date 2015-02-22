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

let programme_candidat tableau taille =
  let out0 = 0 in
  let d = 0 in
  let e = (taille - 1) in
  let rec c i out0 =
    (if (i <= e)
     then let out0 = (out0 + tableau.(i)) in
     (c (i + 1) out0)
     else out0) in
    (c d out0)
let main =
  let taille = (Scanf.scanf "%d " (fun x -> x)) in
  ((fun  (g, tableau) -> (
                           g;
                           (Printf.printf "%d\n" (programme_candidat tableau taille))
                           )
  ) (Array.init_withenv taille (fun  a () -> Scanf.scanf "%d"
  (fun  b -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               let f = b in
               ((), f)
               )
  )) ()))

