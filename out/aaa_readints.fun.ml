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

let read_int =
  (fun () -> Scanf.scanf "%d"
  (fun out_ ->
      (Scanf.scanf "%[\n \010]" (fun _ -> out_))));;
let read_int_line =
  (fun n ->
      let tab = (Array.init_withenv n (fun i ->
                                          (fun () -> Scanf.scanf "%d"
                                          (fun t ->
                                              (Scanf.scanf "%[\n \010]" (fun _ -> let b = t in
                                              ((), b)))))) ()) in
      tab);;
let read_int_matrix =
  (fun x y ->
      let tab = (Array.init_withenv y (fun z ->
                                          (fun () -> let a = (read_int_line x) in
                                          ((), a))) ()) in
      tab);;
let main =
  let len = (read_int ()) in
  (
    (Printf.printf "%d" len);
    (Printf.printf "%s" "=len\n");
    let tab1 = (read_int_line len) in
    let l = 0 in
    let m = (len - 1) in
    let rec k i =
      (if (i <= m)
       then (
              (Printf.printf "%d" i);
              (Printf.printf "%s" "=>");
              (Printf.printf "%d" tab1.(i));
              (Printf.printf "%s" "\n");
              (k (i + 1))
              )
       
       else let len = (read_int ()) in
       let tab2 = (read_int_matrix len (len - 1)) in
       let g = 0 in
       let h = (len - 2) in
       let rec c i =
         (if (i <= h)
          then let e = 0 in
          let f = (len - 1) in
          let rec d j =
            (if (j <= f)
             then (
                    (Printf.printf "%d" tab2.(i).(j));
                    (Printf.printf "%s" " ");
                    (d (j + 1))
                    )
             
             else (
                    (Printf.printf "%s" "\n");
                    (c (i + 1))
                    )
             ) in
            (d e)
          else ()) in
         (c g)) in
      (k l)
    )
  ;;

