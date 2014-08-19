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

let summax lst len =
  let current = 0 in
  let max_ = 0 in
  let b = 0 in
  let c = (len - 1) in
  let rec a i current max_ =
    (if (i <= c)
     then let current = (current + lst.(i)) in
     let current = (if (current < 0)
                    then let current = 0 in
                    current
                    else current) in
     let max_ = (if (max_ < current)
                 then let max_ = current in
                 max_
                 else max_) in
     (a (i + 1) current max_)
     else max_) in
    (a b current max_)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  f -> let len = f in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init_withenv len (fun  i () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  e -> let tmp = e in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let d = tmp in
      ((), d)
      )
    )) ()) in
    let result = (summax tab len) in
    (Printf.printf "%d" result)
    )
  )

