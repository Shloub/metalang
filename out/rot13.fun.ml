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

let main =
  Scanf.scanf "%d"
  (fun strlen ->
      (Scanf.scanf "%[\n \010]" (fun _ -> let tab4 = (Array.init_withenv strlen (fun
       toto ->
      (fun () -> Scanf.scanf "%c"
      (fun tmpc ->
          let c = (int_of_char (tmpc)) in
          let c = (if (tmpc <> ' ')
                   then let c = ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a'))) in
                   c
                   else c) in
          let a = (char_of_int (c)) in
          ((), a)))) ()) in
      let d = 0 in
      let e = (strlen - 1) in
      let rec b j =
        (if (j <= e)
         then (
                (Printf.printf "%c" tab4.(j));
                (b (j + 1))
                )
         
         else ()) in
        (b d))));;

