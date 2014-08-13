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

let rec montagnes_ =
  (fun tab len ->
      let max_ = 1 in
      let j = 1 in
      let i = (len - 2) in
      let rec b i j max_ tab len =
        (if (i >= 0)
         then let x = tab.(i) in
         let rec e x i j max_ tab len =
           (if ((j >= 0) && (x > tab.((len - j))))
            then let j = (j - 1) in
            (e x i j max_ tab len)
            else let j = (j + 1) in
            (tab.((len - j)) <- x; let c = (fun x i j max_ tab len ->
                                               let i = (i - 1) in
                                               (b i j max_ tab len)) in
            (if (j > max_)
             then let max_ = j in
             (c x i j max_ tab len)
             else (c x i j max_ tab len)))) in
           (e x i j max_ tab len)
         else max_) in
        (b i j max_ tab len));;
let rec main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun h ->
      let len = h in
      (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
       i len ->
      let x = 0 in
      Scanf.scanf "%d"
      (fun g ->
          let x = g in
          (Scanf.scanf "%[\n \010]" (fun _ -> let f = x in
          (len, f))))) len) in
      (Printf.printf "%d" (montagnes_ tab len)))));;

