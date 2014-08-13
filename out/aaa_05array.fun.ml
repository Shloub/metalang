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

let rec id =
  (fun b ->
      b);;
let rec g =
  (fun t index ->
      (t.(index) <- false; ()));;
let rec main =
  let c = 5 in
  let a = (Array.init_withenv c (fun i c ->
                                    begin
                                      (Printf.printf "%d" i);
                                      let f = ((i mod 2) = 0) in
                                      (c, f)
                                      end
                                    ) c) in
  let d = a.(0) in
  let j = (fun d c ->
              begin
                (Printf.printf "%s" "\n");
                (g (id a) 0);
                let e = a.(0) in
                let h = (fun e d c ->
                            (Printf.printf "%s" "\n")) in
                (if e
                 then begin
                        (Printf.printf "%s" "True");
                        (h e d c)
                        end
                 
                 else begin
                        (Printf.printf "%s" "False");
                        (h e d c)
                        end
                 )
                end
              ) in
  (if d
   then begin
          (Printf.printf "%s" "True");
          (j d c)
          end
   
   else begin
          (Printf.printf "%s" "False");
          (j d c)
          end
   );;

