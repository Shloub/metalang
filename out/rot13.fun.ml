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

let rec main =
  Scanf.scanf "%d"
  (fun strlen ->
      (Scanf.scanf "%[\n \010]" (fun _ -> let tab4 = (Array.init_withenv strlen (fun
       toto strlen ->
      Scanf.scanf "%c"
      (fun tmpc ->
          let c = (int_of_char (tmpc)) in
          let b = (fun c tmpc toto strlen ->
                      let a = (char_of_int (c)) in
                      (strlen, a)) in
          (if (tmpc <> ' ')
           then let c = ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a'))) in
           (b c tmpc toto strlen)
           else (b c tmpc toto strlen)))) strlen) in
      let e = 0 in
      let f = (strlen - 1) in
      let rec d j strlen =
        (if (j <= f)
         then begin
                (Printf.printf "%c" tab4.(j));
                (d (j + 1) strlen)
                end
         
         else ()) in
        (d e strlen))));;

