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

let rec summax =
  (fun lst len ->
      let current = 0 in
      let max_ = 0 in
      let d = 0 in
      let e = (len - 1) in
      let rec a i max_ current lst len =
        (if (i <= e)
         then let current = (current + lst.(i)) in
         let c = (fun max_ current lst len ->
                     let b = (fun max_ current lst len ->
                                 (a (i + 1) max_ current lst len)) in
                     (if (max_ < current)
                      then let max_ = current in
                      (b max_ current lst len)
                      else (b max_ current lst len))) in
         (if (current < 0)
          then let current = 0 in
          (c max_ current lst len)
          else (c max_ current lst len))
         else max_) in
        (a d max_ current lst len));;
let rec main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun h ->
      let len = h in
      (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
       i len ->
      let tmp = 0 in
      Scanf.scanf "%d"
      (fun g ->
          let tmp = g in
          (Scanf.scanf "%[\n \010]" (fun _ -> let f = tmp in
          (len, f))))) len) in
      let result = (summax tab len) in
      (Printf.printf "%d" result))));;

