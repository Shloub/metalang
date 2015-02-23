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
  let b = (len - 1) in
  let rec a i current max0 =
    (if (i <= b)
     then let current = (current + lst.(i)) in
     let current = (if (current < 0)
                    then let current = 0 in
                    current
                    else current) in
     (if (max0 < current)
      then let max0 = current in
      (a (i + 1) current max0)
      else (a (i + 1) current max0))
     else max0) in
    (a 0 current max0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  f -> let len = f in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    ((fun  (d, tab) -> (
                         d;
                         let result = (summax tab len) in
                         (Printf.printf "%d" result)
                         )
    ) (Array.init_withenv len (fun  i () -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  e -> let tmp = e in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      let c = tmp in
      ((), c)
      )
    )) ()))
    )
  )

