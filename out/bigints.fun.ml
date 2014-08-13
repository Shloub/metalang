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
      let ei = (fun a b ->
                   ()) in
      (if (a > b)
       then a
       else b));;
let rec min2 =
  (fun a b ->
      let eh = (fun a b ->
                   ()) in
      (if (a < b)
       then a
       else b));;
type bigint = {mutable bigint_sign : bool; mutable bigint_len : int; mutable bigint_chiffres : int array;};;
let rec read_bigint =
  (fun len ->
      let chiffres = (Array.init_withenv len (fun j len ->
                                                 Scanf.scanf "%c"
                                                 (fun c ->
                                                     let ed = (int_of_char (c)) in
                                                     (len, ed))) len) in
      let ef = 0 in
      let eg = ((len - 1) / 2) in
      let rec ee i len =
        (if (i <= eg)
         then let tmp = chiffres.(i) in
         (chiffres.(i) <- chiffres.(((len - 1) - i)); (chiffres.(((len - 1) - i)) <- tmp; (ee (i + 1) len)))
         else {bigint_sign=true;
         bigint_len=len;
         bigint_chiffres=chiffres}) in
        (ee ef len));;
let rec print_bigint =
  (fun a ->
      let ec = (fun a ->
                   let ea = 0 in
                   let eb = (a.bigint_len - 1) in
                   let rec dz i a =
                     (if (i <= eb)
                      then begin
                             (Printf.printf "%d" a.bigint_chiffres.(((a.bigint_len - 1) - i)));
                             (dz (i + 1) a)
                             end
                      
                      else ()) in
                     (dz ea a)) in
      (if (not a.bigint_sign)
       then begin
              (Printf.printf "%c" '-');
              (ec a)
              end
       
       else (ec a)));;
let rec bigint_eq =
  (fun a b ->
      (*  Renvoie vrai si a = b  *)
      let dt = (fun a b ->
                   ()) in
      (if (a.bigint_sign <> b.bigint_sign)
       then false
       else let du = (fun a b ->
                         (dt a b)) in
       (if (a.bigint_len <> b.bigint_len)
        then false
        else let dx = 0 in
        let dy = (a.bigint_len - 1) in
        let rec dv i a b =
          (if (i <= dy)
           then let dw = (fun a b ->
                             (dv (i + 1) a b)) in
           (if (a.bigint_chiffres.(i) <> b.bigint_chiffres.(i))
            then false
            else (dw a b))
           else true) in
          (dv dx a b))));;
let rec bigint_gt =
  (fun a b ->
      (*  Renvoie vrai si a > b  *)
      let dj = (fun a b ->
                   ()) in
      (if (a.bigint_sign && (not b.bigint_sign))
       then true
       else let dk = (fun a b ->
                         (dj a b)) in
       (if ((not a.bigint_sign) && b.bigint_sign)
        then false
        else let dl = (fun a b ->
                          true) in
        (if (a.bigint_len > b.bigint_len)
         then a.bigint_sign
         else let dm = (fun a b ->
                           (dl a b)) in
         (if (a.bigint_len < b.bigint_len)
          then (not a.bigint_sign)
          else let dr = 0 in
          let ds = (a.bigint_len - 1) in
          let rec dn i a b =
            (if (i <= ds)
             then let j = ((a.bigint_len - 1) - i) in
             let dp = (fun j a b ->
                          (dn (i + 1) a b)) in
             (if (a.bigint_chiffres.(j) > b.bigint_chiffres.(j))
              then a.bigint_sign
              else let dq = (fun j a b ->
                                (dp j a b)) in
              (if (a.bigint_chiffres.(j) < b.bigint_chiffres.(j))
               then (not a.bigint_sign)
               else (dq j a b)))
             else (dm a b)) in
            (dn dr a b))))));;
let rec bigint_lt =
  (fun a b ->
      (not (bigint_gt a b)));;
let rec add_bigint_positif =
  (fun a b ->
      (*  Une addition ou on en a rien a faire des signes  *)
      let len = ((max2 a.bigint_len b.bigint_len) + 1) in
      let retenue = 0 in
      let chiffres = (Array.init_withenv len (fun i ->
                                                 (fun (retenue, len, a, b) ->
                                                     let tmp = retenue in
                                                     let dg = (fun tmp i retenue len a b ->
                                                                  let df = (fun
                                                                   tmp i retenue len a b ->
                                                                  let retenue = (tmp / 10) in
                                                                  let de = (tmp mod 10) in
                                                                  ((retenue, len, a, b), de)) in
                                                                  (if (i < b.bigint_len)
                                                                   then let tmp = (tmp + b.bigint_chiffres.(i)) in
                                                                   (df tmp i retenue len a b)
                                                                   else (df tmp i retenue len a b))) in
                                                     (if (i < a.bigint_len)
                                                      then let tmp = (tmp + a.bigint_chiffres.(i)) in
                                                      (dg tmp i retenue len a b)
                                                      else (dg tmp i retenue len a b)))) (retenue, len, a, b)) in
      let rec di retenue len a b =
        (if ((len > 0) && (chiffres.((len - 1)) = 0))
         then let len = (len - 1) in
         (di retenue len a b)
         else {bigint_sign=true;
         bigint_len=len;
         bigint_chiffres=chiffres}) in
        (di retenue len a b));;
let rec sub_bigint_positif =
  (fun a b ->
      (*  Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
 *)
      let len = a.bigint_len in
      let retenue = 0 in
      let chiffres = (Array.init_withenv len (fun i ->
                                                 (fun (retenue, len, a, b) ->
                                                     let tmp = (retenue + a.bigint_chiffres.(i)) in
                                                     let db = (fun tmp i retenue len a b ->
                                                                  let da = (fun
                                                                   tmp i retenue len a b ->
                                                                  let cz = tmp in
                                                                  ((retenue, len, a, b), cz)) in
                                                                  (if (tmp < 0)
                                                                   then let tmp = (tmp + 10) in
                                                                   let retenue = (- 1) in
                                                                   (da tmp i retenue len a b)
                                                                   else let retenue = 0 in
                                                                   (da tmp i retenue len a b))) in
                                                     (if (i < b.bigint_len)
                                                      then let tmp = (tmp - b.bigint_chiffres.(i)) in
                                                      (db tmp i retenue len a b)
                                                      else (db tmp i retenue len a b)))) (retenue, len, a, b)) in
      let rec dd retenue len a b =
        (if ((len > 0) && (chiffres.((len - 1)) = 0))
         then let len = (len - 1) in
         (dd retenue len a b)
         else {bigint_sign=true;
         bigint_len=len;
         bigint_chiffres=chiffres}) in
        (dd retenue len a b));;
let rec neg_bigint =
  (fun a ->
      {bigint_sign=(not a.bigint_sign);
      bigint_len=a.bigint_len;
      bigint_chiffres=a.bigint_chiffres});;
let rec add_bigint =
  (fun a b ->
      let cu = (fun a b ->
                   ()) in
      (if (a.bigint_sign = b.bigint_sign)
       then let cv = (fun a b ->
                         (cu a b)) in
       (if a.bigint_sign
        then (add_bigint_positif a b)
        else (neg_bigint (add_bigint_positif a b)))
       else let cw = (fun a b ->
                         (cu a b)) in
       (if a.bigint_sign
        then (*  a positif, b negatif  *)
        let cx = (fun a b ->
                     (cw a b)) in
        (if (bigint_gt a (neg_bigint b))
         then (sub_bigint_positif a b)
         else (neg_bigint (sub_bigint_positif b a)))
        else (*  a negatif, b positif  *)
        let cy = (fun a b ->
                     (cw a b)) in
        (if (bigint_gt (neg_bigint a) b)
         then (neg_bigint (sub_bigint_positif a b))
         else (sub_bigint_positif b a)))));;
let rec sub_bigint =
  (fun a b ->
      (add_bigint a (neg_bigint b)));;
let rec mul_bigint_cp =
  (fun a b ->
      (*  Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction.  *)
      let len = ((a.bigint_len + b.bigint_len) + 1) in
      let chiffres = (Array.init_withenv len (fun k ->
                                                 (fun (len, a, b) ->
                                                     let cj = 0 in
                                                     ((len, a, b), cj))) (len, a, b)) in
      let cs = 0 in
      let ct = (a.bigint_len - 1) in
      let rec co i len a b =
        (if (i <= ct)
         then let retenue = 0 in
         let cq = 0 in
         let cr = (b.bigint_len - 1) in
         let rec cp j retenue len a b =
           (if (j <= cr)
            then (chiffres.((i + j)) <- (chiffres.((i + j)) + (retenue + (b.bigint_chiffres.(j) * a.bigint_chiffres.(i)))); let retenue = (chiffres.((i + j)) / 10) in
            (chiffres.((i + j)) <- (chiffres.((i + j)) mod 10); (cp (j + 1) retenue len a b)))
            else (chiffres.((i + b.bigint_len)) <- (chiffres.((i + b.bigint_len)) + retenue); (co (i + 1) len a b))) in
           (cp cq retenue len a b)
         else (chiffres.((a.bigint_len + b.bigint_len)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) / 10); (chiffres.(((a.bigint_len + b.bigint_len) - 1)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) mod 10); let cm = 0 in
         let cn = 2 in
         let rec ck l len a b =
           (if (l <= cn)
            then let cl = (fun len a b ->
                              (ck (l + 1) len a b)) in
            (if ((len <> 0) && (chiffres.((len - 1)) = 0))
             then let len = (len - 1) in
             (cl len a b)
             else (cl len a b))
            else {bigint_sign=(a.bigint_sign = b.bigint_sign);
            bigint_len=len;
            bigint_chiffres=chiffres}) in
           (ck cm len a b)))) in
        (co cs len a b));;
let rec bigint_premiers_chiffres =
  (fun a i ->
      let len = (min2 i a.bigint_len) in
      let rec ci len a i =
        (if ((len <> 0) && (a.bigint_chiffres.((len - 1)) = 0))
         then let len = (len - 1) in
         (ci len a i)
         else {bigint_sign=a.bigint_sign;
         bigint_len=len;
         bigint_chiffres=a.bigint_chiffres}) in
        (ci len a i));;
let rec bigint_shift =
  (fun a i ->
      let e = (a.bigint_len + i) in
      let chiffres = (Array.init_withenv e (fun k ->
                                               (fun (e, a, i) ->
                                                   let cg = (fun k e a i cf ->
                                                                ((e, a, i), cf)) in
                                                   (if (k >= i)
                                                    then let cf = a.bigint_chiffres.((k - i)) in
                                                    ((e, a, i), cf)
                                                    else let cf = 0 in
                                                    ((e, a, i), cf)))) (e, a, i)) in
      {bigint_sign=a.bigint_sign;
      bigint_len=(a.bigint_len + i);
      bigint_chiffres=chiffres});;
let rec mul_bigint =
  (fun aa bb ->
      let cc = (fun aa bb ->
                   (*  Algorithme de Karatsuba  *)
                   let split = ((min2 aa.bigint_len bb.bigint_len) / 2) in
                   let a = (bigint_shift aa (- split)) in
                   let b = (bigint_premiers_chiffres aa split) in
                   let c = (bigint_shift bb (- split)) in
                   let d = (bigint_premiers_chiffres bb split) in
                   let amoinsb = (sub_bigint a b) in
                   let cmoinsd = (sub_bigint c d) in
                   let ac = (mul_bigint a c) in
                   let bd = (mul_bigint b d) in
                   let amoinsbcmoinsd = (mul_bigint amoinsb cmoinsd) in
                   let acdec = (bigint_shift ac (2 * split)) in
                   (add_bigint (add_bigint acdec bd) (bigint_shift (sub_bigint (add_bigint ac bd) amoinsbcmoinsd) split))) in
      (if (aa.bigint_len = 0)
       then aa
       else let cd = (fun aa bb ->
                         (cc aa bb)) in
       (if (bb.bigint_len = 0)
        then bb
        else let ce = (fun aa bb ->
                          (cd aa bb)) in
        (if ((aa.bigint_len < 3) || (bb.bigint_len < 3))
         then (mul_bigint_cp aa bb)
         else (ce aa bb)))));;
let rec log10 =
  (fun a ->
      let out_ = 1 in
      let rec cb out_ a =
        (if (a >= 10)
         then let a = (a / 10) in
         let out_ = (out_ + 1) in
         (cb out_ a)
         else out_) in
        (cb out_ a));;
let rec bigint_of_int =
  (fun i ->
      let size = (log10 i) in
      let bz = (fun size i ->
                   let t = (Array.init_withenv size (fun j ->
                                                        (fun (size, i) ->
                                                            let bv = 0 in
                                                            ((size, i), bv))) (size, i)) in
                   let bx = 0 in
                   let by = (size - 1) in
                   let rec bw k size i =
                     (if (k <= by)
                      then (t.(k) <- (i mod 10); let i = (i / 10) in
                      (bw (k + 1) size i))
                      else {bigint_sign=true;
                      bigint_len=size;
                      bigint_chiffres=t}) in
                     (bw bx size i)) in
      (if (i = 0)
       then let size = 0 in
       (bz size i)
       else (bz size i)));;
let rec fact_bigint =
  (fun a ->
      let one = (bigint_of_int 1) in
      let out_ = one in
      let rec bu out_ one a =
        (if (not (bigint_eq a one))
         then let out_ = (mul_bigint a out_) in
         let a = (sub_bigint a one) in
         (bu out_ one a)
         else out_) in
        (bu out_ one a));;
let rec sum_chiffres_bigint =
  (fun a ->
      let out_ = 0 in
      let br = 0 in
      let bs = (a.bigint_len - 1) in
      let rec bq i out_ a =
        (if (i <= bs)
         then let out_ = (out_ + a.bigint_chiffres.(i)) in
         (bq (i + 1) out_ a)
         else out_) in
        (bq br out_ a));;
let rec euler20 =
  (fun () -> let a = (bigint_of_int 15) in
  (*  normalement c'est 100  *)
  let a = (fact_bigint a) in
  (sum_chiffres_bigint a));;
let rec bigint_exp =
  (fun a b ->
      let bo = (fun a b ->
                   ()) in
      (if (b = 1)
       then a
       else let bp = (fun a b ->
                         (bo a b)) in
       (if ((b mod 2) = 0)
        then (bigint_exp (mul_bigint a a) (b / 2))
        else (mul_bigint a (bigint_exp a (b - 1))))));;
let rec bigint_exp_10chiffres =
  (fun a b ->
      let a = (bigint_premiers_chiffres a 10) in
      let bm = (fun a b ->
                   ()) in
      (if (b = 1)
       then a
       else let bn = (fun a b ->
                         (bm a b)) in
       (if ((b mod 2) = 0)
        then (bigint_exp_10chiffres (mul_bigint a a) (b / 2))
        else (mul_bigint a (bigint_exp_10chiffres a (b - 1))))));;
let rec euler48 =
  (fun () -> let sum = (bigint_of_int 0) in
  let bk = 1 in
  let bl = 100 in
  let rec bj i sum =
    (if (i <= bl)
     then (*  1000 normalement  *)
     let ib = (bigint_of_int i) in
     let ibeib = (bigint_exp_10chiffres ib i) in
     let sum = (add_bigint sum ibeib) in
     let sum = (bigint_premiers_chiffres sum 10) in
     (bj (i + 1) sum)
     else begin
            (Printf.printf "%s" "euler 48 = ");
            (print_bigint sum);
            (Printf.printf "%s" "\n")
            end
     ) in
    (bj bk sum));;
let rec euler16 =
  (fun () -> let a = (bigint_of_int 2) in
  let a = (bigint_exp a 100) in
  (*  1000 normalement  *)
  (sum_chiffres_bigint a));;
let rec euler25 =
  (fun () -> let i = 2 in
  let a = (bigint_of_int 1) in
  let b = (bigint_of_int 1) in
  let rec bi b a i =
    (if (b.bigint_len < 100)
     then (*  1000 normalement  *)
     let c = (add_bigint a b) in
     let a = b in
     let b = c in
     let i = (i + 1) in
     (bi b a i)
     else i) in
    (bi b a i));;
let rec euler29 =
  (fun () -> let maxA = 5 in
  let maxB = 5 in
  let f = (maxA + 1) in
  let a_bigint = (Array.init_withenv f (fun j ->
                                           (fun (f, maxB, maxA) ->
                                               let o = (bigint_of_int (j * j)) in
                                               ((f, maxB, maxA), o))) (f, maxB, maxA)) in
  let g = (maxA + 1) in
  let a0_bigint = (Array.init_withenv g (fun j2 ->
                                            (fun (g, f, maxB, maxA) ->
                                                let p = (bigint_of_int j2) in
                                                ((g, f, maxB, maxA), p))) (g, f, maxB, maxA)) in
  let h = (maxA + 1) in
  let b = (Array.init_withenv h (fun k ->
                                    (fun (h, g, f, maxB, maxA) ->
                                        let q = 2 in
                                        ((h, g, f, maxB, maxA), q))) (h, g, f, maxB, maxA)) in
  let n = 0 in
  let found = true in
  let rec s found n h g f maxB maxA =
    (if found
     then let min_ = a0_bigint.(0) in
     let found = false in
     let bf = 2 in
     let bg = maxA in
     let rec z i min_ found n h g f maxB maxA =
       (if (i <= bg)
        then let ba = (fun min_ found n h g f maxB maxA ->
                          (z (i + 1) min_ found n h g f maxB maxA)) in
        (if (b.(i) <= maxB)
         then let bc = (fun min_ found n h g f maxB maxA ->
                           (ba min_ found n h g f maxB maxA)) in
         (if found
          then let be = (fun min_ found n h g f maxB maxA ->
                            (bc min_ found n h g f maxB maxA)) in
          (if (bigint_lt a_bigint.(i) min_)
           then let min_ = a_bigint.(i) in
           (be min_ found n h g f maxB maxA)
           else (be min_ found n h g f maxB maxA))
          else let min_ = a_bigint.(i) in
          let found = true in
          (bc min_ found n h g f maxB maxA))
         else (ba min_ found n h g f maxB maxA))
        else let u = (fun min_ found n h g f maxB maxA ->
                         (s found n h g f maxB maxA)) in
        (if found
         then let n = (n + 1) in
         let x = 2 in
         let y = maxA in
         let rec v l min_ found n h g f maxB maxA =
           (if (l <= y)
            then let w = (fun min_ found n h g f maxB maxA ->
                             (v (l + 1) min_ found n h g f maxB maxA)) in
            (if ((bigint_eq a_bigint.(l) min_) && (b.(l) <= maxB))
             then (b.(l) <- (b.(l) + 1); (a_bigint.(l) <- (mul_bigint a_bigint.(l) a0_bigint.(l)); (w min_ found n h g f maxB maxA)))
             else (w min_ found n h g f maxB maxA))
            else (u min_ found n h g f maxB maxA)) in
           (v x min_ found n h g f maxB maxA)
         else (u min_ found n h g f maxB maxA))) in
       (z bf min_ found n h g f maxB maxA)
     else n) in
    (s found n h g f maxB maxA));;
let rec main =
  begin
    (Printf.printf "%d" (euler29 ()));
    (Printf.printf "%s" "\n");
    let sum = (read_bigint 50) in
    let el = 2 in
    let em = 100 in
    let rec ek i sum =
      (if (i <= em)
       then (Scanf.scanf "%[\n \010]" (fun _ -> let tmp = (read_bigint 50) in
       let sum = (add_bigint sum tmp) in
       (ek (i + 1) sum)))
       else begin
              (Printf.printf "%s" "euler13 = ");
              (print_bigint sum);
              (Printf.printf "%s" "\n");
              (Printf.printf "%s" "euler25 = ");
              (Printf.printf "%d" (euler25 ()));
              (Printf.printf "%s" "\n");
              (Printf.printf "%s" "euler16 = ");
              (Printf.printf "%d" (euler16 ()));
              (Printf.printf "%s" "\n");
              (euler48 ());
              (Printf.printf "%s" "euler20 = ");
              (Printf.printf "%d" (euler20 ()));
              (Printf.printf "%s" "\n");
              let a = (bigint_of_int 999999) in
              let b = (bigint_of_int 9951263) in
              begin
                (print_bigint a);
                (Printf.printf "%s" ">>1=");
                (print_bigint (bigint_shift a (- 1)));
                (Printf.printf "%s" "\n");
                (print_bigint a);
                (Printf.printf "%s" "*");
                (print_bigint b);
                (Printf.printf "%s" "=");
                (print_bigint (mul_bigint a b));
                (Printf.printf "%s" "\n");
                (print_bigint a);
                (Printf.printf "%s" "*");
                (print_bigint b);
                (Printf.printf "%s" "=");
                (print_bigint (mul_bigint_cp a b));
                (Printf.printf "%s" "\n");
                (print_bigint a);
                (Printf.printf "%s" "+");
                (print_bigint b);
                (Printf.printf "%s" "=");
                (print_bigint (add_bigint a b));
                (Printf.printf "%s" "\n");
                (print_bigint b);
                (Printf.printf "%s" "-");
                (print_bigint a);
                (Printf.printf "%s" "=");
                (print_bigint (sub_bigint b a));
                (Printf.printf "%s" "\n");
                (print_bigint a);
                (Printf.printf "%s" "-");
                (print_bigint b);
                (Printf.printf "%s" "=");
                (print_bigint (sub_bigint a b));
                (Printf.printf "%s" "\n");
                (print_bigint a);
                (Printf.printf "%s" ">");
                (print_bigint b);
                (Printf.printf "%s" "=");
                let m = (bigint_gt a b) in
                let ej = (fun m b a sum ->
                             (Printf.printf "%s" "\n")) in
                (if m
                 then begin
                        (Printf.printf "%s" "True");
                        (ej m b a sum)
                        end
                 
                 else begin
                        (Printf.printf "%s" "False");
                        (ej m b a sum)
                        end
                 )
                end
              
              end
       ) in
      (ek el sum)
    end
  ;;

