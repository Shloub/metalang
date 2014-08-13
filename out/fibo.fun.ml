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

let rec fibo_ =
  (fun a b i ->
      let out_ = 0 in
      let a2 = a in
      let b2 = b in
      let d = 0 in
      let e = (i + 1) in
      let rec c j b2 a2 out_ a b i =
        (if (j <= e)
         then let out_ = (out_ + a2) in
         let tmp = b2 in
         let b2 = (b2 + a2) in
         let a2 = tmp in
         (c (j + 1) b2 a2 out_ a b i)
         else out_) in
        (c d b2 a2 out_ a b i));;
let rec main =
  let a = 0 in
  let b = 0 in
  let i = 0 in
  Scanf.scanf "%d"
  (fun h ->
      let a = h in
      (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
      (fun g ->
          let b = g in
          (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
          (fun f ->
              let i = f in
              (Printf.printf "%d" (fibo_ a b i)))))))));;

