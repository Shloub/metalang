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

type bigint = {mutable bigint_sign : bool; mutable bigint_len : int; mutable bigint_chiffres : int array;}
let read_bigint len =
  let chiffres = (Array.init_withenv len (fun  j () -> Scanf.scanf "%c"
  (fun  c -> let dp = (int_of_char (c)) in
  ((), dp))) ()) in
  let dr = 0 in
  let ds = ((len - 1) / 2) in
  let rec dq i =
    (if (i <= ds)
     then let tmp = chiffres.(i) in
     (
       chiffres.(i) <- chiffres.(((len - 1) - i));
       chiffres.(((len - 1) - i)) <- tmp;
       (dq (i + 1))
       )
     
     else {bigint_sign=true;
     bigint_len=len;
     bigint_chiffres=chiffres}) in
    (dq dr)
let print_bigint a =
  (
    (if (not a.bigint_sign)
     then (Printf.printf "%c" '-')
     else ());
    let dm = 0 in
    let dn = (a.bigint_len - 1) in
    let rec dl i =
      (if (i <= dn)
       then (
              (Printf.printf "%d" a.bigint_chiffres.(((a.bigint_len - 1) - i)));
              (dl (i + 1))
              )
       
       else ()) in
      (dl dm)
    )
  
let bigint_eq a b =
  (*  Renvoie vrai si a = b  *)
  let dg () = () in
  (if (a.bigint_sign <> b.bigint_sign)
   then false
   else let dh () = (dg ()) in
   (if (a.bigint_len <> b.bigint_len)
    then false
    else let dj = 0 in
    let dk = (a.bigint_len - 1) in
    let rec di i =
      (if (i <= dk)
       then (if (a.bigint_chiffres.(i) <> b.bigint_chiffres.(i))
             then false
             else (di (i + 1)))
       else true) in
      (di dj)))
let bigint_gt a b =
  (*  Renvoie vrai si a > b  *)
  let cy () = () in
  (if (a.bigint_sign && (not b.bigint_sign))
   then true
   else let cz () = (cy ()) in
   (if ((not a.bigint_sign) && b.bigint_sign)
    then false
    else let da () = true in
    (if (a.bigint_len > b.bigint_len)
     then a.bigint_sign
     else let db () = (da ()) in
     (if (a.bigint_len < b.bigint_len)
      then (not a.bigint_sign)
      else let de = 0 in
      let df = (a.bigint_len - 1) in
      let rec dc i =
        (if (i <= df)
         then let j = ((a.bigint_len - 1) - i) in
         let dd () = (dc (i + 1)) in
         (if (a.bigint_chiffres.(j) > b.bigint_chiffres.(j))
          then a.bigint_sign
          else (if (a.bigint_chiffres.(j) < b.bigint_chiffres.(j))
                then (not a.bigint_sign)
                else (dd ())))
         else (db ())) in
        (dc de)))))
let bigint_lt a b =
  (not (bigint_gt a b))
let add_bigint_positif a b =
  (*  Une addition ou on en a rien a faire des signes  *)
  let len = (((max (a.bigint_len) (b.bigint_len))) + 1) in
  let retenue = 0 in
  let chiffres = (Array.init_withenv len (fun  i retenue -> let tmp = retenue in
  let tmp = (if (i < a.bigint_len)
             then let tmp = (tmp + a.bigint_chiffres.(i)) in
             tmp
             else tmp) in
  let tmp = (if (i < b.bigint_len)
             then let tmp = (tmp + b.bigint_chiffres.(i)) in
             tmp
             else tmp) in
  let retenue = (tmp / 10) in
  let cw = (tmp mod 10) in
  (retenue, cw)) retenue) in
  let rec cx len =
    (if ((len > 0) && (chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (cx len)
     else {bigint_sign=true;
     bigint_len=len;
     bigint_chiffres=chiffres}) in
    (cx len)
let sub_bigint_positif a b =
  (*  Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
 *)
  let len = a.bigint_len in
  let retenue = 0 in
  let chiffres = (Array.init_withenv len (fun  i retenue -> let tmp = (retenue + a.bigint_chiffres.(i)) in
  let tmp = (if (i < b.bigint_len)
             then let tmp = (tmp - b.bigint_chiffres.(i)) in
             tmp
             else tmp) in
  ((fun  (retenue, tmp) -> let cu = tmp in
  (retenue, cu)) (if (tmp < 0)
                  then let tmp = (tmp + 10) in
                  let retenue = (- 1) in
                  (retenue, tmp)
                  else let retenue = 0 in
                  (retenue, tmp)))) retenue) in
  let rec cv len =
    (if ((len > 0) && (chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (cv len)
     else {bigint_sign=true;
     bigint_len=len;
     bigint_chiffres=chiffres}) in
    (cv len)
let neg_bigint a =
  {bigint_sign=(not a.bigint_sign);
  bigint_len=a.bigint_len;
  bigint_chiffres=a.bigint_chiffres}
let add_bigint a b =
  let cp () = () in
  (if (a.bigint_sign = b.bigint_sign)
   then let cq () = (cp ()) in
   (if a.bigint_sign
    then (add_bigint_positif a b)
    else (neg_bigint (add_bigint_positif a b)))
   else let cr () = (cp ()) in
   (if a.bigint_sign
    then (*  a positif, b negatif  *)
    let cs () = (cr ()) in
    (if (bigint_gt a (neg_bigint b))
     then (sub_bigint_positif a b)
     else (neg_bigint (sub_bigint_positif b a)))
    else (*  a negatif, b positif  *)
    let ct () = (cr ()) in
    (if (bigint_gt (neg_bigint a) b)
     then (neg_bigint (sub_bigint_positif a b))
     else (sub_bigint_positif b a))))
let sub_bigint a b =
  (add_bigint a (neg_bigint b))
let mul_bigint_cp a b =
  (*  Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction.  *)
  let len = ((a.bigint_len + b.bigint_len) + 1) in
  let chiffres = (Array.init_withenv len (fun  k () -> let cf = 0 in
  ((), cf)) ()) in
  let cn = 0 in
  let co = (a.bigint_len - 1) in
  let rec cj i =
    (if (i <= co)
     then let retenue = 0 in
     let cl = 0 in
     let cm = (b.bigint_len - 1) in
     let rec ck j retenue =
       (if (j <= cm)
        then (
               chiffres.((i + j)) <- (chiffres.((i + j)) + (retenue + (b.bigint_chiffres.(j) * a.bigint_chiffres.(i))));
               let retenue = (chiffres.((i + j)) / 10) in
               (
                 chiffres.((i + j)) <- (chiffres.((i + j)) mod 10);
                 (ck (j + 1) retenue)
                 )
               
               )
        
        else (
               chiffres.((i + b.bigint_len)) <- (chiffres.((i + b.bigint_len)) + retenue);
               (cj (i + 1))
               )
        ) in
       (ck cl retenue)
     else (
            chiffres.((a.bigint_len + b.bigint_len)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) / 10);
            chiffres.(((a.bigint_len + b.bigint_len) - 1)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) mod 10);
            let ch = 0 in
            let ci = 2 in
            let rec cg l len =
              (if (l <= ci)
               then let len = (if ((len <> 0) && (chiffres.((len - 1)) = 0))
                               then let len = (len - 1) in
                               len
                               else len) in
               (cg (l + 1) len)
               else {bigint_sign=(a.bigint_sign = b.bigint_sign);
               bigint_len=len;
               bigint_chiffres=chiffres}) in
              (cg ch len)
            )
     ) in
    (cj cn)
let bigint_premiers_chiffres a i =
  let len = ((min (i) (a.bigint_len))) in
  let rec ce len =
    (if ((len <> 0) && (a.bigint_chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (ce len)
     else {bigint_sign=a.bigint_sign;
     bigint_len=len;
     bigint_chiffres=a.bigint_chiffres}) in
    (ce len)
let bigint_shift a i =
  let chiffres = (Array.init_withenv (a.bigint_len + i) (fun  k () -> let cd cc = ((), cc) in
  (if (k >= i)
   then let cc = a.bigint_chiffres.((k - i)) in
   ((), cc)
   else let cc = 0 in
   ((), cc))) ()) in
  {bigint_sign=a.bigint_sign;
  bigint_len=(a.bigint_len + i);
  bigint_chiffres=chiffres}
let rec mul_bigint aa bb =
  let ca () = (*  Algorithme de Karatsuba  *)
  let split = (((min (aa.bigint_len) (bb.bigint_len))) / 2) in
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
  (add_bigint (add_bigint acdec bd) (bigint_shift (sub_bigint (add_bigint ac bd) amoinsbcmoinsd) split)) in
  (if (aa.bigint_len = 0)
   then aa
   else let cb () = (ca ()) in
   (if (bb.bigint_len = 0)
    then bb
    else (if ((aa.bigint_len < 3) || (bb.bigint_len < 3))
          then (mul_bigint_cp aa bb)
          else (cb ()))))
let log10 a =
  let out0 = 1 in
  let rec bz a out0 =
    (if (a >= 10)
     then let a = (a / 10) in
     let out0 = (out0 + 1) in
     (bz a out0)
     else out0) in
    (bz a out0)
let bigint_of_int i =
  let size = (log10 i) in
  let size = (if (i = 0)
              then let size = 0 in
              size
              else size) in
  let t = (Array.init_withenv size (fun  j () -> let bv = 0 in
  ((), bv)) ()) in
  let bx = 0 in
  let by = (size - 1) in
  let rec bw k i =
    (if (k <= by)
     then (
            t.(k) <- (i mod 10);
            let i = (i / 10) in
            (bw (k + 1) i)
            )
     
     else {bigint_sign=true;
     bigint_len=size;
     bigint_chiffres=t}) in
    (bw bx i)
let fact_bigint a =
  let one = (bigint_of_int 1) in
  let out0 = one in
  let rec bu a out0 =
    (if (not (bigint_eq a one))
     then let out0 = (mul_bigint a out0) in
     let a = (sub_bigint a one) in
     (bu a out0)
     else out0) in
    (bu a out0)
let sum_chiffres_bigint a =
  let out0 = 0 in
  let bs = 0 in
  let bt = (a.bigint_len - 1) in
  let rec br i out0 =
    (if (i <= bt)
     then let out0 = (out0 + a.bigint_chiffres.(i)) in
     (br (i + 1) out0)
     else out0) in
    (br bs out0)
let euler20 () =
  let a = (bigint_of_int 15) in
  (*  normalement c'est 100  *)
  let a = (fact_bigint a) in
  (sum_chiffres_bigint a)
let rec bigint_exp a b =
  let bp () = () in
  (if (b = 1)
   then a
   else let bq () = (bp ()) in
   (if ((b mod 2) = 0)
    then (bigint_exp (mul_bigint a a) (b / 2))
    else (mul_bigint a (bigint_exp a (b - 1)))))
let rec bigint_exp_10chiffres a b =
  let a = (bigint_premiers_chiffres a 10) in
  let bn () = () in
  (if (b = 1)
   then a
   else let bo () = (bn ()) in
   (if ((b mod 2) = 0)
    then (bigint_exp_10chiffres (mul_bigint a a) (b / 2))
    else (mul_bigint a (bigint_exp_10chiffres a (b - 1)))))
let euler48 () =
  let sum = (bigint_of_int 0) in
  let bl = 1 in
  let bm = 100 in
  let rec bk i sum =
    (if (i <= bm)
     then (*  1000 normalement  *)
     let ib = (bigint_of_int i) in
     let ibeib = (bigint_exp_10chiffres ib i) in
     let sum = (add_bigint sum ibeib) in
     let sum = (bigint_premiers_chiffres sum 10) in
     (bk (i + 1) sum)
     else (
            (Printf.printf "euler 48 = " );
            (print_bigint sum);
            (Printf.printf "\n" )
            )
     ) in
    (bk bl sum)
let euler16 () =
  let a = (bigint_of_int 2) in
  let a = (bigint_exp a 100) in
  (*  1000 normalement  *)
  (sum_chiffres_bigint a)
let euler25 () =
  let i = 2 in
  let a = (bigint_of_int 1) in
  let b = (bigint_of_int 1) in
  let rec bj a b i =
    (if (b.bigint_len < 100)
     then (*  1000 normalement  *)
     let c = (add_bigint a b) in
     let a = b in
     let b = c in
     let i = (i + 1) in
     (bj a b i)
     else i) in
    (bj a b i)
let euler29 () =
  let maxA = 5 in
  let maxB = 5 in
  let a_bigint = (Array.init_withenv (maxA + 1) (fun  j () -> let x = (bigint_of_int (j * j)) in
  ((), x)) ()) in
  let a0_bigint = (Array.init_withenv (maxA + 1) (fun  j2 () -> let y = (bigint_of_int j2) in
  ((), y)) ()) in
  let b = (Array.init_withenv (maxA + 1) (fun  k () -> let z = 2 in
  ((), z)) ()) in
  let n = 0 in
  let found = true in
  let rec ba found n =
    (if found
     then let min0 = a0_bigint.(0) in
     let found = false in
     let bh = 2 in
     let bi = maxA in
     let rec bg i found min0 =
       (if (i <= bi)
        then ((fun  (found, min0) -> (bg (i + 1) found min0)) (if (b.(i) <= maxB)
                                                               then ((fun  (found, min0) -> (found, min0)) (
                                                               if found
                                                               then let min0 = (
                                                               if (bigint_lt a_bigint.(i) min0)
                                                               then let min0 = a_bigint.(i) in
                                                               min0
                                                               else min0) in
                                                               (found, min0)
                                                               else let min0 = a_bigint.(i) in
                                                               let found = true in
                                                               (found, min0)))
                                                               else (found, min0)))
        else let n = (if found
                      then let n = (n + 1) in
                      let be = 2 in
                      let bf = maxA in
                      let rec bc l =
                        (if (l <= bf)
                         then (
                                (if ((bigint_eq a_bigint.(l) min0) && (b.(l) <= maxB))
                                 then (
                                        b.(l) <- (b.(l) + 1);
                                        a_bigint.(l) <- (mul_bigint a_bigint.(l) a0_bigint.(l))
                                        )
                                 
                                 else ());
                                (bc (l + 1))
                                )
                         
                         else n) in
                        (bc be)
                      else n) in
        (ba found n)) in
       (bg bh found min0)
     else n) in
    (ba found n)
let main =
  (
    (Printf.printf "%d\n" (euler29 ()));
    let sum = (read_bigint 50) in
    let du = 2 in
    let dv = 100 in
    let rec dt i sum =
      (if (i <= dv)
       then (
              (Scanf.scanf "%[\n \010]" (fun _ -> ()));
              let tmp = (read_bigint 50) in
              let sum = (add_bigint sum tmp) in
              (dt (i + 1) sum)
              )
       
       else (
              (Printf.printf "euler13 = " );
              (print_bigint sum);
              (Printf.printf "\neuler25 = %d\neuler16 = %d\n" (euler25 ()) (euler16 ()));
              (euler48 ());
              (Printf.printf "euler20 = %d\n" (euler20 ()));
              let a = (bigint_of_int 999999) in
              let b = (bigint_of_int 9951263) in
              (
                (print_bigint a);
                (Printf.printf ">>1=" );
                (print_bigint (bigint_shift a (- 1)));
                (Printf.printf "\n" );
                (print_bigint a);
                (Printf.printf "*" );
                (print_bigint b);
                (Printf.printf "=" );
                (print_bigint (mul_bigint a b));
                (Printf.printf "\n" );
                (print_bigint a);
                (Printf.printf "*" );
                (print_bigint b);
                (Printf.printf "=" );
                (print_bigint (mul_bigint_cp a b));
                (Printf.printf "\n" );
                (print_bigint a);
                (Printf.printf "+" );
                (print_bigint b);
                (Printf.printf "=" );
                (print_bigint (add_bigint a b));
                (Printf.printf "\n" );
                (print_bigint b);
                (Printf.printf "-" );
                (print_bigint a);
                (Printf.printf "=" );
                (print_bigint (sub_bigint b a));
                (Printf.printf "\n" );
                (print_bigint a);
                (Printf.printf "-" );
                (print_bigint b);
                (Printf.printf "=" );
                (print_bigint (sub_bigint a b));
                (Printf.printf "\n" );
                (print_bigint a);
                (Printf.printf ">" );
                (print_bigint b);
                (Printf.printf "=" );
                let m = (bigint_gt a b) in
                (
                  (if m
                   then (Printf.printf "True")
                   else (Printf.printf "False"));
                  (Printf.printf "\n" )
                  )
                
                )
              
              )
       ) in
      (dt du sum)
    )
  

