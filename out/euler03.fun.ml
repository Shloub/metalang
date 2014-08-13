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
  let maximum = 1 in
  let b0 = 2 in
  let a = 408464633 in
  let rec d a b0 maximum =
    (if (a <> 1)
     then let b = b0 in
     let found = false in
     let rec g found b a b0 maximum =
       (if ((b * b) < a)
        then let h = (fun found b a b0 maximum ->
                         let b = (b + 1) in
                         (g found b a b0 maximum)) in
        (if ((a mod b) = 0)
         then let a = (a / b) in
         let b0 = b in
         let b = a in
         let found = true in
         (h found b a b0 maximum)
         else (h found b a b0 maximum))
        else let e = (fun found b a b0 maximum ->
                         (d a b0 maximum)) in
        (if (not found)
         then begin
                (Printf.printf "%d" a);
                (Printf.printf "%s" "\n");
                let a = 1 in
                (e found b a b0 maximum)
                end
         
         else (e found b a b0 maximum))) in
       (g found b a b0 maximum)
     else ()) in
    (d a b0 maximum);;

