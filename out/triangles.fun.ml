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

let rec find0 =
  (fun len tab cache x y ->
      (* 
	Cette fonction est récursive
	 *)
      let f = (fun len tab cache x y ->
                  let result = 0 in
                  let out0 = (find0 len tab cache x (y + 1)) in
                  let out1 = (find0 len tab cache (x + 1) (y + 1)) in
                  let e = (fun out1 out0 result len tab cache x y ->
                              (cache.(y).(x) <- result; result)) in
                  (if (out0 > out1)
                   then let result = (out0 + tab.(y).(x)) in
                   (e out1 out0 result len tab cache x y)
                   else let result = (out1 + tab.(y).(x)) in
                   (e out1 out0 result len tab cache x y))) in
      (if (y = (len - 1))
       then tab.(y).(x)
       else let g = (fun len tab cache x y ->
                        (f len tab cache x y)) in
       (if (x > y)
        then (- 10000)
        else let h = (fun len tab cache x y ->
                         (g len tab cache x y)) in
        (if (cache.(y).(x) <> 0)
         then cache.(y).(x)
         else (h len tab cache x y)))));;
let rec find =
  (fun len tab ->
      let tab2 = (Array.init_withenv len (fun i ->
                                             (fun (len, tab) ->
                                                 let a = (i + 1) in
                                                 let tab3 = (Array.init_withenv a (fun
                                                  j ->
                                                 (fun (a, i, len, tab) ->
                                                     let d = 0 in
                                                     ((a, i, len, tab), d))) (a, i, len, tab)) in
                                                 let c = tab3 in
                                                 ((len, tab), c))) (len, tab)) in
      (find0 len tab tab2 0 0));;
let rec main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun v ->
      let len = v in
      (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv len (fun
       i len ->
      let b = (i + 1) in
      let tab2 = (Array.init_withenv b (fun j ->
                                           (fun (b, i, len) ->
                                               let tmp = 0 in
                                               Scanf.scanf "%d"
                                               (fun o ->
                                                   let tmp = o in
                                                   (Scanf.scanf "%[\n \010]" (fun _ -> let n = tmp in
                                                   ((b, i, len), n)))))) (b, i, len)) in
      let m = tab2 in
      (len, m)) len) in
      begin
        (Printf.printf "%d" (find len tab));
        (Printf.printf "%s" "\n");
        let t = 0 in
        let u = (len - 1) in
        let rec p k len =
          (if (k <= u)
           then let r = 0 in
           let s = k in
           let rec q l len =
             (if (l <= s)
              then begin
                     (Printf.printf "%d" tab.(k).(l));
                     (Printf.printf "%s" " ");
                     (q (l + 1) len)
                     end
              
              else begin
                     (Printf.printf "%s" "\n");
                     (p (k + 1) len)
                     end
              ) in
             (q r len)
           else ()) in
          (p t len)
        end
      )));;

