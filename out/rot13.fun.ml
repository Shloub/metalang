module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let main =
  Scanf.scanf "%d"
  (fun  strlen -> (
                    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                    ((fun  (b, tab4) -> (
                                          b;
                                          let e = 0 in
                                          let f = (strlen - 1) in
                                          let rec d j =
                                            (if (j <= f)
                                             then (
                                                    (Printf.printf "%c" tab4.(j));
                                                    (d (j + 1))
                                                    )
                                             
                                             else ()) in
                                            (d e)
                                          )
                    ) (Array.init_withenv strlen (fun  toto () -> Scanf.scanf "%c"
                    (fun  tmpc -> let c = (int_of_char (tmpc)) in
                    let c = (if (tmpc <> ' ')
                             then let c = ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a'))) in
                             c
                             else c) in
                    let a = (char_of_int (c)) in
                    ((), a))) ()))
                    )
  )

