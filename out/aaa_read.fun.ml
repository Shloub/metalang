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
  (fun len ->
      (Scanf.scanf "%[\n \010]" (fun _ -> begin
                                            (Printf.printf "%d" len);
                                            (Printf.printf "%s" "=len\n");
                                            let len = (len * 2) in
                                            begin
                                              (Printf.printf "%s" "len*2=");
                                              (Printf.printf "%d" len);
                                              (Printf.printf "%s" "\n");
                                              let len = (len / 2) in
                                              let tab = (Array.init_withenv len (fun
                                               i len ->
                                              Scanf.scanf "%d"
                                              (fun tmpi1 ->
                                                  (Scanf.scanf "%[\n \010]" (fun _ -> 
                                                  begin
                                                    (Printf.printf "%d" i);
                                                    (Printf.printf "%s" "=>");
                                                    (Printf.printf "%d" tmpi1);
                                                    (Printf.printf "%s" " ");
                                                    let a = tmpi1 in
                                                    (len, a)
                                                    end
                                                  )))) len) in
                                              begin
                                                (Printf.printf "%s" "\n");
                                                let tab2 = (Array.init_withenv len (fun
                                                 i_ len ->
                                                Scanf.scanf "%d"
                                                (fun tmpi2 ->
                                                    (Scanf.scanf "%[\n \010]" (fun _ -> 
                                                    begin
                                                      (Printf.printf "%d" i_);
                                                      (Printf.printf "%s" "==>");
                                                      (Printf.printf "%d" tmpi2);
                                                      (Printf.printf "%s" " ");
                                                      let b = tmpi2 in
                                                      (len, b)
                                                      end
                                                    )))) len) in
                                                Scanf.scanf "%d"
                                                (fun strlen ->
                                                    (Scanf.scanf "%[\n \010]" (fun _ -> 
                                                    begin
                                                      (Printf.printf "%d" strlen);
                                                      (Printf.printf "%s" "=strlen\n");
                                                      let tab4 = (Array.init_withenv strlen (fun
                                                       toto ->
                                                      (fun (strlen, len) ->
                                                          Scanf.scanf "%c"
                                                          (fun tmpc ->
                                                              let c = (int_of_char (tmpc)) in
                                                              begin
                                                                (Printf.printf "%c" tmpc);
                                                                (Printf.printf "%s" ":");
                                                                (Printf.printf "%d" c);
                                                                (Printf.printf "%s" " ");
                                                                let e = (fun
                                                                 c tmpc toto strlen len ->
                                                                let d = (char_of_int (c)) in
                                                                ((strlen, len), d)) in
                                                                (if (tmpc <> ' ')
                                                                 then let c = ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a'))) in
                                                                 (e c tmpc toto strlen len)
                                                                 else (e c tmpc toto strlen len))
                                                                end
                                                              ))) (strlen, len)) in
                                                      let g = 0 in
                                                      let h = (strlen - 1) in
                                                      let rec f j strlen len =
                                                        (if (j <= h)
                                                         then begin
                                                                (Printf.printf "%c" tab4.(j));
                                                                (f (j + 1) strlen len)
                                                                end
                                                         
                                                         else ()) in
                                                        (f g strlen len)
                                                      end
                                                    )))
                                                end
                                              
                                              end
                                            
                                            end
      )));;

