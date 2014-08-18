let main =
  let i = 4 in
  (* while i < 10 do  *)
  (
    (Printf.printf "%d" i);
    let i = (i + 1) in
    (*   end  *)
    (Printf.printf "%d" i)
    )
  ;;

