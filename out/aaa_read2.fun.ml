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

let rec read_int =
  (fun () -> Scanf.scanf "%d"
  (fun out_ ->
      (Scanf.scanf "%[\n \010]" (fun _ -> out_))));;
let rec read_int_line =
  (fun n ->
      let tab = (Array.init_withenv n (fun i n ->
                                          Scanf.scanf "%d"
                                          (fun t ->
                                              (Scanf.scanf "%[\n \010]" (fun _ -> let b = t in
                                              (n, b))))) n) in
      tab);;
let rec read_char_line =
  (fun n ->
      let tab = (Array.init_withenv n (fun i n ->
                                          Scanf.scanf "%c"
                                          (fun t ->
                                              let a = t in
                                              (n, a))) n) in
      (Scanf.scanf "%[\n \010]" (fun _ -> tab)));;
let rec main =
  let len = (read_int ()) in
  begin
    (Printf.printf "%d" len);
    (Printf.printf "%s" "=len\n");
    let tab = (read_int_line len) in
    let r = 0 in
    let s = (len - 1) in
    let rec q i tab len =
      (if (i <= s)
       then begin
              (Printf.printf "%d" i);
              (Printf.printf "%s" "=>");
              (Printf.printf "%d" tab.(i));
              (Printf.printf "%s" " ");
              (q (i + 1) tab len)
              end
       
       else begin
              (Printf.printf "%s" "\n");
              let tab2 = (read_int_line len) in
              let o = 0 in
              let p = (len - 1) in
              let rec m i_ tab2 tab len =
                (if (i_ <= p)
                 then begin
                        (Printf.printf "%d" i_);
                        (Printf.printf "%s" "==>");
                        (Printf.printf "%d" tab2.(i_));
                        (Printf.printf "%s" " ");
                        (m (i_ + 1) tab2 tab len)
                        end
                 
                 else let strlen = (read_int ()) in
                 begin
                   (Printf.printf "%d" strlen);
                   (Printf.printf "%s" "=strlen\n");
                   let tab4 = (read_char_line strlen) in
                   let k = 0 in
                   let l = (strlen - 1) in
                   let rec g i3 tab4 strlen tab2 tab len =
                     (if (i3 <= l)
                      then let tmpc = tab4.(i3) in
                      let c = (int_of_char (tmpc)) in
                      begin
                        (Printf.printf "%c" tmpc);
                        (Printf.printf "%s" ":");
                        (Printf.printf "%d" c);
                        (Printf.printf "%s" " ");
                        let h = (fun c tmpc tab4 strlen tab2 tab len ->
                                    (tab4.(i3) <- (char_of_int (c)); (g (i3 + 1) tab4 strlen tab2 tab len))) in
                        (if (tmpc <> ' ')
                         then let c = ((((c - (int_of_char ('a'))) + 13) mod 26) + (int_of_char ('a'))) in
                         (h c tmpc tab4 strlen tab2 tab len)
                         else (h c tmpc tab4 strlen tab2 tab len))
                        end
                      
                      else let e = 0 in
                      let f = (strlen - 1) in
                      let rec d j tab4 strlen tab2 tab len =
                        (if (j <= f)
                         then begin
                                (Printf.printf "%c" tab4.(j));
                                (d (j + 1) tab4 strlen tab2 tab len)
                                end
                         
                         else ()) in
                        (d e tab4 strlen tab2 tab len)) in
                     (g k tab4 strlen tab2 tab len)
                   end
                 ) in
                (m o tab2 tab len)
              end
       ) in
      (q r tab len)
    end
  ;;

