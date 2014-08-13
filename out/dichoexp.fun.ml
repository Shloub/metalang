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

let rec exp_ =
  (fun a b ->
      let d = (fun a b ->
                  let c = (fun a b ->
                              ()) in
                  (if ((b mod 2) = 0)
                   then let o = (exp_ a (b / 2)) in
                   (o * o)
                   else (a * (exp_ a (b - 1))))) in
      (if (b = 0)
       then 1
       else (d a b)));;
let rec main =
  let a = 0 in
  let b = 0 in
  Scanf.scanf "%d"
  (fun f ->
      let a = f in
      (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
      (fun e ->
          let b = e in
          (Printf.printf "%d" (exp_ a b))))));;

