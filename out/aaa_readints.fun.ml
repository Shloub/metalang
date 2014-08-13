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
let rec read_int_matrix =
  (fun x y ->
      let tab = (Array.init_withenv y (fun z ->
                                          (fun (x, y) ->
                                              let a = (read_int_line x) in
                                              ((x, y), a))) (x, y)) in
      tab);;
let rec main =
  let len = (read_int ()) in
  begin
    (Printf.printf "%d" len);
    (Printf.printf "%s" "=len\n");
    let tab1 = (read_int_line len) in
    let l = 0 in
    let m = (len - 1) in
    let rec k i tab1 len =
      (if (i <= m)
       then begin
              (Printf.printf "%d" i);
              (Printf.printf "%s" "=>");
              (Printf.printf "%d" tab1.(i));
              (Printf.printf "%s" "\n");
              (k (i + 1) tab1 len)
              end
       
       else let len = (read_int ()) in
       let tab2 = (read_int_matrix len (len - 1)) in
       let g = 0 in
       let h = (len - 2) in
       let rec c i tab2 tab1 len =
         (if (i <= h)
          then let e = 0 in
          let f = (len - 1) in
          let rec d j tab2 tab1 len =
            (if (j <= f)
             then begin
                    (Printf.printf "%d" tab2.(i).(j));
                    (Printf.printf "%s" " ");
                    (d (j + 1) tab2 tab1 len)
                    end
             
             else begin
                    (Printf.printf "%s" "\n");
                    (c (i + 1) tab2 tab1 len)
                    end
             ) in
            (d e tab2 tab1 len)
          else ()) in
         (c g tab2 tab1 len)) in
      (k l tab1 len)
    end
  ;;

