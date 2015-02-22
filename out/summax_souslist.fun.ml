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

let summax lst len =
  let current = 0 in
  let max0 = 0 in
  let b = 0 in
  let c = (len - 1) in
  let rec a i current max0 =
    (if (i <= c)
     then let current = (current + lst.(i)) in
     let current = (if (current < 0)
                    then let current = 0 in
                    current
                    else current) in
     let max0 = (if (max0 < current)
                 then let max0 = current in
                 max0
                 else max0) in
     (a (i + 1) current max0)
     else max0) in
    (a b current max0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  g -> let len = g in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    ((fun  (e, tab) -> (
                         e;
                         let result = (summax tab len) in
                         (Printf.printf "%d" result)
                         )
    ) (Array.init_withenv len (fun  i () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  f -> let tmp = f in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let d = tmp in
      ((), d)
      )
    )) ()))
    )
  )

