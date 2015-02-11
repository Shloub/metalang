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
  (fun  c -> let dc = (int_of_char (c)) in
  ((), dc))) ()) in
  let de = 0 in
  let df = ((len - 1) / 2) in
  let rec dd i =
    (if (i <= df)
     then let tmp = chiffres.(i) in
     (
       chiffres.(i) <- chiffres.(((len - 1) - i));
       chiffres.(((len - 1) - i)) <- tmp;
       (dd (i + 1))
       )
     
     else {bigint_sign=true;
     bigint_len=len;
     bigint_chiffres=chiffres}) in
    (dd de)
let print_bigint a =
  (
    (if (not a.bigint_sign)
     then (Printf.printf "%c" '-')
     else ());
    let da = 0 in
    let db = (a.bigint_len - 1) in
    let rec cz i =
      (if (i <= db)
       then (
              (Printf.printf "%d" a.bigint_chiffres.(((a.bigint_len - 1) - i)));
              (cz (i + 1))
              )
       
       else ()) in
      (cz da)
    )
  
let bigint_eq a b =
  (*  Renvoie vrai si a = b  *)
  let cu () = () in
  (if (a.bigint_sign <> b.bigint_sign)
   then false
   else let cv () = (cu ()) in
   (if (a.bigint_len <> b.bigint_len)
    then false
    else let cx = 0 in
    let cy = (a.bigint_len - 1) in
    let rec cw i =
      (if (i <= cy)
       then (if (a.bigint_chiffres.(i) <> b.bigint_chiffres.(i))
             then false
             else (cw (i + 1)))
       else true) in
      (cw cx)))
let bigint_gt a b =
  (*  Renvoie vrai si a > b  *)
  let cm () = () in
  (if (a.bigint_sign && (not b.bigint_sign))
   then true
   else let cn () = (cm ()) in
   (if ((not a.bigint_sign) && b.bigint_sign)
    then false
    else let co () = true in
    (if (a.bigint_len > b.bigint_len)
     then a.bigint_sign
     else let cp () = (co ()) in
     (if (a.bigint_len < b.bigint_len)
      then (not a.bigint_sign)
      else let cs = 0 in
      let ct = (a.bigint_len - 1) in
      let rec cq i =
        (if (i <= ct)
         then let j = ((a.bigint_len - 1) - i) in
         let cr () = (cq (i + 1)) in
         (if (a.bigint_chiffres.(j) > b.bigint_chiffres.(j))
          then a.bigint_sign
          else (if (a.bigint_chiffres.(j) < b.bigint_chiffres.(j))
                then (not a.bigint_sign)
                else (cr ())))
         else (cp ())) in
        (cq cs)))))
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
  let ck = (tmp mod 10) in
  (retenue, ck)) retenue) in
  let rec cl len =
    (if ((len > 0) && (chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (cl len)
     else {bigint_sign=true;
     bigint_len=len;
     bigint_chiffres=chiffres}) in
    (cl len)
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
  ((fun  (retenue, tmp) -> let ci = tmp in
  (retenue, ci)) (if (tmp < 0)
                  then let tmp = (tmp + 10) in
                  let retenue = (- 1) in
                  (retenue, tmp)
                  else let retenue = 0 in
                  (retenue, tmp)))) retenue) in
  let rec cj len =
    (if ((len > 0) && (chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (cj len)
     else {bigint_sign=true;
     bigint_len=len;
     bigint_chiffres=chiffres}) in
    (cj len)
let neg_bigint a =
  {bigint_sign=(not a.bigint_sign);
  bigint_len=a.bigint_len;
  bigint_chiffres=a.bigint_chiffres}
let add_bigint a b =
  let cd () = () in
  (if (a.bigint_sign = b.bigint_sign)
   then let ce () = (cd ()) in
   (if a.bigint_sign
    then (add_bigint_positif a b)
    else (neg_bigint (add_bigint_positif a b)))
   else let cf () = (cd ()) in
   (if a.bigint_sign
    then (*  a positif, b negatif  *)
    let cg () = (cf ()) in
    (if (bigint_gt a (neg_bigint b))
     then (sub_bigint_positif a b)
     else (neg_bigint (sub_bigint_positif b a)))
    else (*  a negatif, b positif  *)
    let ch () = (cf ()) in
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
  let chiffres = (Array.init_withenv len (fun  k () -> let bt = 0 in
  ((), bt)) ()) in
  let cb = 0 in
  let cc = (a.bigint_len - 1) in
  let rec bx i =
    (if (i <= cc)
     then let retenue = 0 in
     let bz = 0 in
     let ca = (b.bigint_len - 1) in
     let rec by j retenue =
       (if (j <= ca)
        then (
               chiffres.((i + j)) <- (chiffres.((i + j)) + (retenue + (b.bigint_chiffres.(j) * a.bigint_chiffres.(i))));
               let retenue = (chiffres.((i + j)) / 10) in
               (
                 chiffres.((i + j)) <- (chiffres.((i + j)) mod 10);
                 (by (j + 1) retenue)
                 )
               
               )
        
        else (
               chiffres.((i + b.bigint_len)) <- (chiffres.((i + b.bigint_len)) + retenue);
               (bx (i + 1))
               )
        ) in
       (by bz retenue)
     else (
            chiffres.((a.bigint_len + b.bigint_len)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) / 10);
            chiffres.(((a.bigint_len + b.bigint_len) - 1)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) mod 10);
            let bv = 0 in
            let bw = 2 in
            let rec bu l len =
              (if (l <= bw)
               then let len = (if ((len <> 0) && (chiffres.((len - 1)) = 0))
                               then let len = (len - 1) in
                               len
                               else len) in
               (bu (l + 1) len)
               else {bigint_sign=(a.bigint_sign = b.bigint_sign);
               bigint_len=len;
               bigint_chiffres=chiffres}) in
              (bu bv len)
            )
     ) in
    (bx cb)
let bigint_premiers_chiffres a i =
  let len = ((min (i) (a.bigint_len))) in
  let rec bs len =
    (if ((len <> 0) && (a.bigint_chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (bs len)
     else {bigint_sign=a.bigint_sign;
     bigint_len=len;
     bigint_chiffres=a.bigint_chiffres}) in
    (bs len)
let bigint_shift a i =
  let chiffres = (Array.init_withenv (a.bigint_len + i) (fun  k () -> let br bq = ((), bq) in
  (if (k >= i)
   then let bq = a.bigint_chiffres.((k - i)) in
   ((), bq)
   else let bq = 0 in
   ((), bq))) ()) in
  {bigint_sign=a.bigint_sign;
  bigint_len=(a.bigint_len + i);
  bigint_chiffres=chiffres}
let rec mul_bigint aa bb =
  let bo () = (*  Algorithme de Karatsuba  *)
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
   else let bp () = (bo ()) in
   (if (bb.bigint_len = 0)
    then bb
    else (if ((aa.bigint_len < 3) || (bb.bigint_len < 3))
          then (mul_bigint_cp aa bb)
          else (bp ()))))
let log10 a =
  let out0 = 1 in
  let rec bn a out0 =
    (if (a >= 10)
     then let a = (a / 10) in
     let out0 = (out0 + 1) in
     (bn a out0)
     else out0) in
    (bn a out0)
let bigint_of_int i =
  let size = (log10 i) in
  let size = (if (i = 0)
              then let size = 0 in
              size
              else size) in
  let t = (Array.init_withenv size (fun  j () -> let bj = 0 in
  ((), bj)) ()) in
  let bl = 0 in
  let bm = (size - 1) in
  let rec bk k i =
    (if (k <= bm)
     then (
            t.(k) <- (i mod 10);
            let i = (i / 10) in
            (bk (k + 1) i)
            )
     
     else {bigint_sign=true;
     bigint_len=size;
     bigint_chiffres=t}) in
    (bk bl i)
let fact_bigint a =
  let one = (bigint_of_int 1) in
  let out0 = one in
  let rec bi a out0 =
    (if (not (bigint_eq a one))
     then let out0 = (mul_bigint a out0) in
     let a = (sub_bigint a one) in
     (bi a out0)
     else out0) in
    (bi a out0)
let sum_chiffres_bigint a =
  let out0 = 0 in
  let bg = 0 in
  let bh = (a.bigint_len - 1) in
  let rec bf i out0 =
    (if (i <= bh)
     then let out0 = (out0 + a.bigint_chiffres.(i)) in
     (bf (i + 1) out0)
     else out0) in
    (bf bg out0)
let euler20 () =
  let a = (bigint_of_int 15) in
  (*  normalement c'est 100  *)
  let a = (fact_bigint a) in
  (sum_chiffres_bigint a)
let rec bigint_exp a b =
  let bc () = () in
  (if (b = 1)
   then a
   else let be () = (bc ()) in
   (if ((b mod 2) = 0)
    then (bigint_exp (mul_bigint a a) (b / 2))
    else (mul_bigint a (bigint_exp a (b - 1)))))
let rec bigint_exp_10chiffres a b =
  let a = (bigint_premiers_chiffres a 10) in
  let z () = () in
  (if (b = 1)
   then a
   else let ba () = (z ()) in
   (if ((b mod 2) = 0)
    then (bigint_exp_10chiffres (mul_bigint a a) (b / 2))
    else (mul_bigint a (bigint_exp_10chiffres a (b - 1)))))
let euler48 () =
  let sum = (bigint_of_int 0) in
  let x = 1 in
  let y = 100 in
  let rec w i sum =
    (if (i <= y)
     then (*  1000 normalement  *)
     let ib = (bigint_of_int i) in
     let ibeib = (bigint_exp_10chiffres ib i) in
     let sum = (add_bigint sum ibeib) in
     let sum = (bigint_premiers_chiffres sum 10) in
     (w (i + 1) sum)
     else (
            (Printf.printf "euler 48 = " );
            (print_bigint sum);
            (Printf.printf "\n" )
            )
     ) in
    (w x sum)
let euler16 () =
  let a = (bigint_of_int 2) in
  let a = (bigint_exp a 100) in
  (*  1000 normalement  *)
  (sum_chiffres_bigint a)
let euler25 () =
  let i = 2 in
  let a = (bigint_of_int 1) in
  let b = (bigint_of_int 1) in
  let rec v a b i =
    (if (b.bigint_len < 100)
     then (*  1000 normalement  *)
     let c = (add_bigint a b) in
     let a = b in
     let b = c in
     let i = (i + 1) in
     (v a b i)
     else i) in
    (v a b i)
let euler29 () =
  let maxA = 5 in
  let maxB = 5 in
  let a_bigint = (Array.init_withenv (maxA + 1) (fun  j () -> let f = (bigint_of_int (j * j)) in
  ((), f)) ()) in
  let a0_bigint = (Array.init_withenv (maxA + 1) (fun  j2 () -> let g = (bigint_of_int j2) in
  ((), g)) ()) in
  let b = (Array.init_withenv (maxA + 1) (fun  k () -> let h = 2 in
  ((), h)) ()) in
  let n = 0 in
  let found = true in
  let rec m found n =
    (if found
     then let min0 = a0_bigint.(0) in
     let found = false in
     let s = 2 in
     let u = maxA in
     let rec r i found min0 =
       (if (i <= u)
        then ((fun  (found, min0) -> (r (i + 1) found min0)) (if (b.(i) <= maxB)
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
                      let p = 2 in
                      let q = maxA in
                      let rec o l =
                        (if (l <= q)
                         then (
                                (if ((bigint_eq a_bigint.(l) min0) && (b.(l) <= maxB))
                                 then (
                                        b.(l) <- (b.(l) + 1);
                                        a_bigint.(l) <- (mul_bigint a_bigint.(l) a0_bigint.(l))
                                        )
                                 
                                 else ());
                                (o (l + 1))
                                )
                         
                         else n) in
                        (o p)
                      else n) in
        (m found n)) in
       (r s found min0)
     else n) in
    (m found n)
let main =
  (
    (Printf.printf "%d\n" (euler29 ()));
    let sum = (read_bigint 50) in
    let dh = 2 in
    let di = 100 in
    let rec dg i sum =
      (if (i <= di)
       then (
              (Scanf.scanf "%[\n \010]" (fun _ -> ()));
              let tmp = (read_bigint 50) in
              let sum = (add_bigint sum tmp) in
              (dg (i + 1) sum)
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
                let e = (bigint_gt a b) in
                (
                  (if e
                   then (Printf.printf "True")
                   else (Printf.printf "False"));
                  (Printf.printf "\n" )
                  )
                
                )
              
              )
       ) in
      (dg dh sum)
    )
  

