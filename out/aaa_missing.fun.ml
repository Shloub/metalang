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
                                              (Scanf.scanf "%[\n \010]" (fun _ -> let j = t in
                                              (n, j))))) n) in
      tab);;
let rec result =
  (fun len tab ->
      let tab2 = (Array.init_withenv len (fun i ->
                                             (fun (len, tab) ->
                                                 let a = false in
                                                 ((len, tab), a))) (len, tab)) in
      let g = 0 in
      let h = (len - 1) in
      let rec f i1 len tab =
        (if (i1 <= h)
         then (tab2.(tab.(i1)) <- true; (f (i1 + 1) len tab))
         else let d = 0 in
         let e = (len - 1) in
         let rec b i2 len tab =
           (if (i2 <= e)
            then let c = (fun len tab ->
                             (b (i2 + 1) len tab)) in
            (if (not tab2.(i2))
             then i2
             else (c len tab))
            else (- 1)) in
           (b d len tab)) in
        (f g len tab));;
let rec main =
  let len = (read_int ()) in
  begin
    (Printf.printf "%d" len);
    (Printf.printf "%s" "\n");
    let tab = (read_int_line len) in
    (Printf.printf "%d" (result len tab))
    end
  ;;

