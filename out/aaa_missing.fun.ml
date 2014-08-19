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

let read_int () =
  Scanf.scanf "%d"
  (fun  out_ -> (Scanf.scanf "%[\n \010]" (fun _ -> out_)))
let read_int_line n =
  let tab = (Array.init_withenv n (fun  i () -> Scanf.scanf "%d"
  (fun  t -> (Scanf.scanf "%[\n \010]" (fun _ -> let h = t in
  ((), h))))) ()) in
  tab
let result len tab =
  let tab2 = (Array.init_withenv len (fun  i () -> let a = false in
  ((), a)) ()) in
  let f = 0 in
  let g = (len - 1) in
  let rec e i1 =
    (if (i1 <= g)
     then (
            tab2.(tab.(i1)) <- true;
            (e (i1 + 1))
            )
     
     else let c = 0 in
     let d = (len - 1) in
     let rec b i2 =
       (if (i2 <= d)
        then (if (not tab2.(i2))
              then i2
              else (b (i2 + 1)))
        else (- 1)) in
       (b c)) in
    (e f)
let main =
  let len = (read_int ()) in
  (
    (Printf.printf "%d" len);
    (Printf.printf "%s" "\n");
    let tab = (read_int_line len) in
    (Printf.printf "%d" (result len tab))
    )
  

