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

let read_char_line n =
  let tab = (Array.init_withenv n (fun  i () -> Scanf.scanf "%c"
  (fun  t -> let a = t in
  ((), a))) ()) in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    tab
    )
  
let main =
  let str = (read_char_line 12) in
  let c = 0 in
  let d = 11 in
  let rec b i =
    (if (i <= d)
     then (
            (Printf.printf "%c" str.(i));
            (b (i + 1))
            )
     
     else ()) in
    (b c)

