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

let montagnes_ tab len =
  let max_ = 1 in
  let j = 1 in
  let i = (len - 2) in
  let rec b i j max_ =
    (if (i >= 0)
     then let x = tab.(i) in
     let rec d j =
       (if ((j >= 0) && (x > tab.((len - j))))
        then let j = (j - 1) in
        (d j)
        else let j = (j + 1) in
        (
          tab.((len - j)) <- x;
          let max_ = (if (j > max_)
                      then let max_ = j in
                      max_
                      else max_) in
          let i = (i - 1) in
          (b i j max_)
          )
        ) in
       (d j)
     else max_) in
    (b i j max_)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  g -> let len = g in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init_withenv len (fun  i () -> let x = 0 in
    Scanf.scanf "%d"
    (fun  f -> let x = f in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let e = x in
      ((), e)
      )
    )) ()) in
    (Printf.printf "%d" (montagnes_ tab len))
    )
  )

