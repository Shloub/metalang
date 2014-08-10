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

let rec foo =
  (fun () -> ((fun f g ->
                  let rec e i =
                    (if (i <= g)
                     then (e (i + 1))
                     else 0) in
                    (e f)) 0 10));;
let rec bar =
  (fun () -> ((fun c d ->
                  let rec b i =
                    (if (i <= d)
                     then ((fun a ->
                               (b (i + 1))) 0)
                     else 0) in
                    (b c)) 0 10));;
let rec main =
  ();;

