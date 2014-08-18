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

let devine_ =
  (fun nombre tab len ->
      let min_ = tab.(0) in
      let max_ = tab.(1) in
      let c = 2 in
      let d = (len - 1) in
      let rec b i max_ min_ =
        (if (i <= d)
         then (if ((tab.(i) > max_) || (tab.(i) < min_))
               then false
               else let min_ = (if (tab.(i) < nombre)
                                then let min_ = tab.(i) in
                                min_
                                else min_) in
               let max_ = (if (tab.(i) > nombre)
                           then let max_ = tab.(i) in
                           max_
                           else max_) in
               (if ((tab.(i) = nombre) && (len <> (i + 1)))
                then false
                else (b (i + 1) max_ min_)))
         else true) in
        (b c max_ min_));;
let main =
  Scanf.scanf "%d"
  (fun nombre ->
      (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
      (fun len ->
          (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
           i ->
          (fun () -> Scanf.scanf "%d"
          (fun tmp ->
              (Scanf.scanf "%[\n \010]" (fun _ -> let e = tmp in
              ((), e)))))) ()) in
          let a = (devine_ nombre tab len) in
          (
            (if a
             then (Printf.printf "%s" "True")
             else (Printf.printf "%s" "False"));
            ()
            )
          ))))));;

