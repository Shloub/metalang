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

let rec h =
  (fun i ->
      (*   for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end  *)
      let j = (i - 2) in
      let rec b j i =
        (if (j <= (i + 2))
         then let c = (fun j i ->
                          let j = (j + 1) in
                          (b j i)) in
         (if ((i mod j) = 5)
          then true
          else (c j i))
         else false) in
        (b j i));;
let rec main =
  let j = 0 in
  let g = 0 in
  let l = 10 in
  let rec f k j =
    (if (k <= l)
     then let j = (j + k) in
     begin
       (Printf.printf "%d" j);
       (Printf.printf "%s" "\n");
       (f (k + 1) j)
       end
     
     else let i = 4 in
     let rec e i j =
       (if (i < 10)
        then begin
               (Printf.printf "%d" i);
               let i = (i + 1) in
               let j = (j + i) in
               (e i j)
               end
        
        else begin
               (Printf.printf "%d" j);
               (Printf.printf "%d" i);
               (Printf.printf "%s" "FIN TEST\n")
               end
        ) in
       (e i j)) in
    (f g j);;

