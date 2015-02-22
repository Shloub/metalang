module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

type bigint = {mutable bigint_sign : bool; mutable bigint_len : int; mutable bigint_chiffres : int array;}
let read_bigint len =
  ((fun  (dl, chiffres) -> (
                             dl;
                             let dn = 0 in
                             let dp = ((len - 1) / 2) in
                             let rec dm i =
                               (if (i <= dp)
                                then let tmp = chiffres.(i) in
                                (
                                  chiffres.(i) <- chiffres.(((len - 1) - i));
                                  chiffres.(((len - 1) - i)) <- tmp;
                                  (dm (i + 1))
                                  )
                                
                                else {bigint_sign=true;
                                bigint_len=len;
                                bigint_chiffres=chiffres}) in
                               (dm dn)
                             )
  ) (Array.init_withenv len (fun  j () -> Scanf.scanf "%c"
  (fun  c -> let dk = (int_of_char (c)) in
  ((), dk))) ()))
let print_bigint a =
  (
    (if (not a.bigint_sign)
     then (Printf.printf "%c" '-')
     else ());
    let di = 0 in
    let dj = (a.bigint_len - 1) in
    let rec dh i =
      (if (i <= dj)
       then (
              (Printf.printf "%d" a.bigint_chiffres.(((a.bigint_len - 1) - i)));
              (dh (i + 1))
              )
       
       else ()) in
      (dh di)
    )
  
let bigint_eq a b =
  (*  Renvoie vrai si a = b  *)
  let dc () = () in
  (if (a.bigint_sign <> b.bigint_sign)
   then false
   else let dd () = (dc ()) in
   (if (a.bigint_len <> b.bigint_len)
    then false
    else let df = 0 in
    let dg = (a.bigint_len - 1) in
    let rec de i =
      (if (i <= dg)
       then (if (a.bigint_chiffres.(i) <> b.bigint_chiffres.(i))
             then false
             else (de (i + 1)))
       else true) in
      (de df)))
let bigint_gt a b =
  (*  Renvoie vrai si a > b  *)
  let cu () = () in
  (if (a.bigint_sign && (not b.bigint_sign))
   then true
   else let cv () = (cu ()) in
   (if ((not a.bigint_sign) && b.bigint_sign)
    then false
    else let cw () = true in
    (if (a.bigint_len > b.bigint_len)
     then a.bigint_sign
     else let cx () = (cw ()) in
     (if (a.bigint_len < b.bigint_len)
      then (not a.bigint_sign)
      else let da = 0 in
      let db = (a.bigint_len - 1) in
      let rec cy i =
        (if (i <= db)
         then let j = ((a.bigint_len - 1) - i) in
         let cz () = (cy (i + 1)) in
         (if (a.bigint_chiffres.(j) > b.bigint_chiffres.(j))
          then a.bigint_sign
          else (if (a.bigint_chiffres.(j) < b.bigint_chiffres.(j))
                then (not a.bigint_sign)
                else (cz ())))
         else (cx ())) in
        (cy da)))))
let bigint_lt a b =
  (not (bigint_gt a b))
let add_bigint_positif a b =
  (*  Une addition ou on en a rien a faire des signes  *)
  let len = (((max (a.bigint_len) (b.bigint_len))) + 1) in
  let retenue = 0 in
  ((fun  (cs, chiffres) -> let retenue = cs in
  let rec ct len =
    (if ((len > 0) && (chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (ct len)
     else {bigint_sign=true;
     bigint_len=len;
     bigint_chiffres=chiffres}) in
    (ct len)) (Array.init_withenv len (fun  i retenue -> let tmp = retenue in
  let tmp = (if (i < a.bigint_len)
             then let tmp = (tmp + a.bigint_chiffres.(i)) in
             tmp
             else tmp) in
  let tmp = (if (i < b.bigint_len)
             then let tmp = (tmp + b.bigint_chiffres.(i)) in
             tmp
             else tmp) in
  let retenue = (tmp / 10) in
  let cr = (tmp mod 10) in
  (retenue, cr)) retenue))
let sub_bigint_positif a b =
  (*  Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
 *)
  let len = a.bigint_len in
  let retenue = 0 in
  ((fun  (cp, chiffres) -> let retenue = cp in
  let rec cq len =
    (if ((len > 0) && (chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (cq len)
     else {bigint_sign=true;
     bigint_len=len;
     bigint_chiffres=chiffres}) in
    (cq len)) (Array.init_withenv len (fun  i retenue -> let tmp = (retenue + a.bigint_chiffres.(i)) in
  let tmp = (if (i < b.bigint_len)
             then let tmp = (tmp - b.bigint_chiffres.(i)) in
             tmp
             else tmp) in
  ((fun  (retenue, tmp) -> let co = tmp in
  (retenue, co)) (if (tmp < 0)
                  then let tmp = (tmp + 10) in
                  let retenue = (- 1) in
                  (retenue, tmp)
                  else let retenue = 0 in
                  (retenue, tmp)))) retenue))
let neg_bigint a =
  {bigint_sign=(not a.bigint_sign);
  bigint_len=a.bigint_len;
  bigint_chiffres=a.bigint_chiffres}
let add_bigint a b =
  let cj () = () in
  (if (a.bigint_sign = b.bigint_sign)
   then let ck () = (cj ()) in
   (if a.bigint_sign
    then (add_bigint_positif a b)
    else (neg_bigint (add_bigint_positif a b)))
   else let cl () = (cj ()) in
   (if a.bigint_sign
    then (*  a positif, b negatif  *)
    let cm () = (cl ()) in
    (if (bigint_gt a (neg_bigint b))
     then (sub_bigint_positif a b)
     else (neg_bigint (sub_bigint_positif b a)))
    else (*  a negatif, b positif  *)
    let cn () = (cl ()) in
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
  ((fun  (bz, chiffres) -> (
                             bz;
                             let ch = 0 in
                             let ci = (a.bigint_len - 1) in
                             let rec cd i =
                               (if (i <= ci)
                                then let retenue = 0 in
                                let cf = 0 in
                                let cg = (b.bigint_len - 1) in
                                let rec ce j retenue =
                                  (if (j <= cg)
                                   then (
                                          chiffres.((i + j)) <- (chiffres.((i + j)) + (retenue + (b.bigint_chiffres.(j) * a.bigint_chiffres.(i))));
                                          let retenue = (chiffres.((i + j)) / 10) in
                                          (
                                            chiffres.((i + j)) <- (chiffres.((i + j)) mod 10);
                                            (ce (j + 1) retenue)
                                            )
                                          
                                          )
                                   
                                   else (
                                          chiffres.((i + b.bigint_len)) <- (chiffres.((i + b.bigint_len)) + retenue);
                                          (cd (i + 1))
                                          )
                                   ) in
                                  (ce cf retenue)
                                else (
                                       chiffres.((a.bigint_len + b.bigint_len)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) / 10);
                                       chiffres.(((a.bigint_len + b.bigint_len) - 1)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) mod 10);
                                       let cb = 0 in
                                       let cc = 2 in
                                       let rec ca l len =
                                         (if (l <= cc)
                                          then let len = (if ((len <> 0) && (chiffres.((len - 1)) = 0))
                                                          then let len = (len - 1) in
                                                          len
                                                          else len) in
                                          (ca (l + 1) len)
                                          else {bigint_sign=(a.bigint_sign = b.bigint_sign);
                                          bigint_len=len;
                                          bigint_chiffres=chiffres}) in
                                         (ca cb len)
                                       )
                                ) in
                               (cd ch)
                             )
  ) (Array.init_withenv len (fun  k () -> let by = 0 in
  ((), by)) ()))
let bigint_premiers_chiffres a i =
  let len = ((min (i) (a.bigint_len))) in
  let rec bx len =
    (if ((len <> 0) && (a.bigint_chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (bx len)
     else {bigint_sign=a.bigint_sign;
     bigint_len=len;
     bigint_chiffres=a.bigint_chiffres}) in
    (bx len)
let bigint_shift a i =
  ((fun  (bv, chiffres) -> (
                             bv;
                             {bigint_sign=a.bigint_sign;
                             bigint_len=(a.bigint_len + i);
                             bigint_chiffres=chiffres}
                             )
  ) (Array.init_withenv (a.bigint_len + i) (fun  k () -> let bw bu = ((), bu) in
  (if (k >= i)
   then let bu = a.bigint_chiffres.((k - i)) in
   ((), bu)
   else let bu = 0 in
   ((), bu))) ()))
let rec mul_bigint aa bb =
  let bs () = (*  Algorithme de Karatsuba  *)
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
   else let bt () = (bs ()) in
   (if (bb.bigint_len = 0)
    then bb
    else (if ((aa.bigint_len < 3) || (bb.bigint_len < 3))
          then (mul_bigint_cp aa bb)
          else (bt ()))))
let log10 a =
  let out0 = 1 in
  let rec br a out0 =
    (if (a >= 10)
     then let a = (a / 10) in
     let out0 = (out0 + 1) in
     (br a out0)
     else out0) in
    (br a out0)
let bigint_of_int i =
  let size = (log10 i) in
  let size = (if (i = 0)
              then let size = 0 in
              size
              else size) in
  ((fun  (bn, t) -> (
                      bn;
                      let bp = 0 in
                      let bq = (size - 1) in
                      let rec bo k i =
                        (if (k <= bq)
                         then (
                                t.(k) <- (i mod 10);
                                let i = (i / 10) in
                                (bo (k + 1) i)
                                )
                         
                         else {bigint_sign=true;
                         bigint_len=size;
                         bigint_chiffres=t}) in
                        (bo bp i)
                      )
  ) (Array.init_withenv size (fun  j () -> let bm = 0 in
  ((), bm)) ()))
let fact_bigint a =
  let one = (bigint_of_int 1) in
  let out0 = one in
  let rec bl a out0 =
    (if (not (bigint_eq a one))
     then let out0 = (mul_bigint a out0) in
     let a = (sub_bigint a one) in
     (bl a out0)
     else out0) in
    (bl a out0)
let sum_chiffres_bigint a =
  let out0 = 0 in
  let bj = 0 in
  let bk = (a.bigint_len - 1) in
  let rec bi i out0 =
    (if (i <= bk)
     then let out0 = (out0 + a.bigint_chiffres.(i)) in
     (bi (i + 1) out0)
     else out0) in
    (bi bj out0)
let euler20 () =
  let a = (bigint_of_int 15) in
  (*  normalement c'est 100  *)
  let a = (fact_bigint a) in
  (sum_chiffres_bigint a)
let rec bigint_exp a b =
  let bg () = () in
  (if (b = 1)
   then a
   else let bh () = (bg ()) in
   (if ((b mod 2) = 0)
    then (bigint_exp (mul_bigint a a) (b / 2))
    else (mul_bigint a (bigint_exp a (b - 1)))))
let rec bigint_exp_10chiffres a b =
  let a = (bigint_premiers_chiffres a 10) in
  let be () = () in
  (if (b = 1)
   then a
   else let bf () = (be ()) in
   (if ((b mod 2) = 0)
    then (bigint_exp_10chiffres (mul_bigint a a) (b / 2))
    else (mul_bigint a (bigint_exp_10chiffres a (b - 1)))))
let euler48 () =
  let sum = (bigint_of_int 0) in
  let ba = 1 in
  let bc = 100 in
  let rec z i sum =
    (if (i <= bc)
     then (*  1000 normalement  *)
     let ib = (bigint_of_int i) in
     let ibeib = (bigint_exp_10chiffres ib i) in
     let sum = (add_bigint sum ibeib) in
     let sum = (bigint_premiers_chiffres sum 10) in
     (z (i + 1) sum)
     else (
            (Printf.printf "euler 48 = " );
            (print_bigint sum);
            (Printf.printf "\n" )
            )
     ) in
    (z ba sum)
let euler16 () =
  let a = (bigint_of_int 2) in
  let a = (bigint_exp a 100) in
  (*  1000 normalement  *)
  (sum_chiffres_bigint a)
let euler25 () =
  let i = 2 in
  let a = (bigint_of_int 1) in
  let b = (bigint_of_int 1) in
  let rec y a b i =
    (if (b.bigint_len < 100)
     then (*  1000 normalement  *)
     let c = (add_bigint a b) in
     let a = b in
     let b = c in
     let i = (i + 1) in
     (y a b i)
     else i) in
    (y a b i)
let euler29 () =
  let maxA = 5 in
  let maxB = 5 in
  ((fun  (g, a_bigint) -> (
                            g;
                            ((fun  (m, a0_bigint) -> (
                                                       m;
                                                       ((fun  (p, b) -> 
                                                       (
                                                         p;
                                                         let n = 0 in
                                                         let found = true in
                                                         let rec q found n =
                                                           (if found
                                                            then let min0 = a0_bigint.(0) in
                                                            let found = false in
                                                            let w = 2 in
                                                            let x = maxA in
                                                            let rec v i found min0 =
                                                              (if (i <= x)
                                                               then ((fun  (found, min0) -> (v (i + 1) found min0)) (
                                                               if (b.(i) <= maxB)
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
                                                               else let n = (
                                                               if found
                                                               then let n = (n + 1) in
                                                               let s = 2 in
                                                               let u = maxA in
                                                               let rec r l =
                                                                 (if (l <= u)
                                                                  then 
                                                                  (
                                                                    (
                                                                    if ((bigint_eq a_bigint.(l) min0) && (b.(l) <= maxB))
                                                                    then 
                                                                    (
                                                                    b.(l) <- (b.(l) + 1);
                                                                    a_bigint.(l) <- (mul_bigint a_bigint.(l) a0_bigint.(l))
                                                                    )
                                                                    
                                                                    else ());
                                                                    (r (l + 1))
                                                                    )
                                                                  
                                                                  else n) in
                                                                 (r s)
                                                               else n) in
                                                               (q found n)) in
                                                              (v w found min0)
                                                            else n) in
                                                           (q found n)
                                                         )
                                                       ) (Array.init_withenv (maxA + 1) (fun  k () -> let o = 2 in
                                                       ((), o)) ()))
                                                       )
                            ) (Array.init_withenv (maxA + 1) (fun  j2 () -> let h = (bigint_of_int j2) in
                            ((), h)) ()))
                            )
  ) (Array.init_withenv (maxA + 1) (fun  j () -> let f = (bigint_of_int (j * j)) in
  ((), f)) ()))
let main =
  (
    (Printf.printf "%d\n" (euler29 ()));
    let sum = (read_bigint 50) in
    let dr = 2 in
    let ds = 100 in
    let rec dq i sum =
      (if (i <= ds)
       then (
              (Scanf.scanf "%[\n \010]" (fun _ -> ()));
              let tmp = (read_bigint 50) in
              let sum = (add_bigint sum tmp) in
              (dq (i + 1) sum)
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
      (dq dr sum)
    )
  

