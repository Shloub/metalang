let read_int () =
  (Scanf.scanf "%d " (fun x -> x))
let main =
  let len = (read_int ()) in
  (
    (Printf.printf "%d\n" len)
    )
  

