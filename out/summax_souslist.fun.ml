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

