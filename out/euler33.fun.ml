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

let rec max2 =
  (fun a b ->
      let g = (fun a b ->
                  ()) in
      (if (a > b)
       then a
       else b));;
let rec min2 =
  (fun a b ->
      let f = (fun a b ->
                  ()) in
      (if (a < b)
       then a
       else b));;
let rec pgcd =
  (fun a b ->
      let c = (min2 a b) in
      let d = (max2 a b) in
      let reste = (d mod c) in
      let e = (fun reste d c a b ->
                  ()) in
      (if (reste = 0)
       then c
       else (pgcd c reste)));;
let rec main =
  let top = 1 in
  let bottom = 1 in
  let u = 1 in
  let v = 9 in
  let rec h i bottom top =
    (if (i <= v)
     then let s = 1 in
     let t = 9 in
     let rec l j bottom top =
       (if (j <= t)
        then let q = 1 in
        let r = 9 in
        let rec m k bottom top =
          (if (k <= r)
           then let n = (fun bottom top ->
                            (m (k + 1) bottom top)) in
           (if ((i <> j) && (j <> k))
            then let a = ((i * 10) + j) in
            let b = ((j * 10) + k) in
            let o = (fun b a bottom top ->
                        (n bottom top)) in
            (if ((a * k) = (i * b))
             then begin
                    (Printf.printf "%d" a);
                    (Printf.printf "%s" "/");
                    (Printf.printf "%d" b);
                    (Printf.printf "%s" "\n");
                    let top = (top * a) in
                    let bottom = (bottom * b) in
                    (o b a bottom top)
                    end
             
             else (o b a bottom top))
            else (n bottom top))
           else (l (j + 1) bottom top)) in
          (m q bottom top)
        else (h (i + 1) bottom top)) in
       (l s bottom top)
     else begin
            (Printf.printf "%d" top);
            (Printf.printf "%s" "/");
            (Printf.printf "%d" bottom);
            (Printf.printf "%s" "\n");
            let p = (pgcd top bottom) in
            begin
              (Printf.printf "%s" "pgcd=");
              (Printf.printf "%d" p);
              (Printf.printf "%s" "\n");
              (Printf.printf "%d" (bottom / p));
              (Printf.printf "%s" "\n")
              end
            
            end
     ) in
    (h u bottom top);;

