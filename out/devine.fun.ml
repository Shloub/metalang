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

let rec devine_ =
  (fun nombre tab len ->
      let min_ = tab.(0) in
      let max_ = tab.(1) in
      let g = 2 in
      let h = (len - 1) in
      let rec b i max_ min_ nombre tab len =
        (if (i <= h)
         then let f = (fun max_ min_ nombre tab len ->
                          let e = (fun max_ min_ nombre tab len ->
                                      let d = (fun max_ min_ nombre tab len ->
                                                  let c = (fun max_ min_ nombre tab len ->
                                                              (b (i + 1) max_ min_ nombre tab len)) in
                                                  (if ((tab.(i) = nombre) && (len <> (i + 1)))
                                                   then false
                                                   else (c max_ min_ nombre tab len))) in
                                      (if (tab.(i) > nombre)
                                       then let max_ = tab.(i) in
                                       (d max_ min_ nombre tab len)
                                       else (d max_ min_ nombre tab len))) in
                          (if (tab.(i) < nombre)
                           then let min_ = tab.(i) in
                           (e max_ min_ nombre tab len)
                           else (e max_ min_ nombre tab len))) in
         (if ((tab.(i) > max_) || (tab.(i) < min_))
          then false
          else (f max_ min_ nombre tab len))
         else true) in
        (b g max_ min_ nombre tab len));;
let rec main =
  Scanf.scanf "%d"
  (fun nombre ->
      (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
      (fun len ->
          (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
           i ->
          (fun (len, nombre) ->
              Scanf.scanf "%d"
              (fun tmp ->
                  (Scanf.scanf "%[\n \010]" (fun _ -> let j = tmp in
                  ((len, nombre), j)))))) (len, nombre)) in
          let a = (devine_ nombre tab len) in
          let k = (fun a len nombre ->
                      ()) in
          (if a
           then begin
                  (Printf.printf "%s" "True");
                  (k a len nombre)
                  end
           
           else begin
                  (Printf.printf "%s" "False");
                  (k a len nombre)
                  end
           )))))));;

