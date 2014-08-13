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

let rec periode =
  (fun restes len a b ->
      let rec e restes len a b =
        (if (a <> 0)
         then let chiffre = (a / b) in
         let reste = (a mod b) in
         let h = 0 in
         let k = (len - 1) in
         let rec f i reste chiffre restes len a b =
           (if (i <= k)
            then let g = (fun reste chiffre restes len a b ->
                             (f (i + 1) reste chiffre restes len a b)) in
            (if (restes.(i) = reste)
             then (len - i)
             else (g reste chiffre restes len a b))
            else (restes.(len) <- reste; let len = (len + 1) in
            let a = (reste * 10) in
            (e restes len a b))) in
           (f h reste chiffre restes len a b)
         else 0) in
        (e restes len a b));;
let rec main =
  let c = 1000 in
  let t = (Array.init_withenv c (fun j c ->
                                    let l = 0 in
                                    (c, l)) c) in
  let m = 0 in
  let mi = 0 in
  let q = 1 in
  let r = 1000 in
  let rec n i mi m c =
    (if (i <= r)
     then let p = (periode t 0 1 i) in
     let o = (fun p mi m c ->
                 (n (i + 1) mi m c)) in
     (if (p > m)
      then let mi = i in
      let m = p in
      (o p mi m c)
      else (o p mi m c))
     else begin
            (Printf.printf "%d" mi);
            (Printf.printf "%s" "\n");
            (Printf.printf "%d" m);
            (Printf.printf "%s" "\n")
            end
     ) in
    (n q mi m c);;

