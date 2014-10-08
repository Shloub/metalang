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
  (fun  c -> let dw = (int_of_char (c)) in
  ((), dw))) ()) in
  let dy = 0 in
  let dz = ((len - 1) / 2) in
  let rec dx i =
    (if (i <= dz)
     then let tmp = chiffres.(i) in
     (
       chiffres.(i) <- chiffres.(((len - 1) - i));
       chiffres.(((len - 1) - i)) <- tmp;
       (dx (i + 1))
       )
     
     else {bigint_sign=true;
     bigint_len=len;
     bigint_chiffres=chiffres}) in
    (dx dy)
let print_bigint a =
  (
    (if (not a.bigint_sign)
     then (Printf.printf "%c" '-')
     else ());
    let du = 0 in
    let dv = (a.bigint_len - 1) in
    let rec dt i =
      (if (i <= dv)
       then (
              (Printf.printf "%d" a.bigint_chiffres.(((a.bigint_len - 1) - i)));
              (dt (i + 1))
              )
       
       else ()) in
      (dt du)
    )
  
let bigint_eq a b =
  (*  Renvoie vrai si a = b  *)
  let dn () = () in
  (if (a.bigint_sign <> b.bigint_sign)
   then false
   else let dp () = (dn ()) in
   (if (a.bigint_len <> b.bigint_len)
    then false
    else let dr = 0 in
    let ds = (a.bigint_len - 1) in
    let rec dq i =
      (if (i <= ds)
       then (if (a.bigint_chiffres.(i) <> b.bigint_chiffres.(i))
             then false
             else (dq (i + 1)))
       else true) in
      (dq dr)))
let bigint_gt a b =
  (*  Renvoie vrai si a > b  *)
  let df () = () in
  (if (a.bigint_sign && (not b.bigint_sign))
   then true
   else let dg () = (df ()) in
   (if ((not a.bigint_sign) && b.bigint_sign)
    then false
    else let dh () = true in
    (if (a.bigint_len > b.bigint_len)
     then a.bigint_sign
     else let di () = (dh ()) in
     (if (a.bigint_len < b.bigint_len)
      then (not a.bigint_sign)
      else let dl = 0 in
      let dm = (a.bigint_len - 1) in
      let rec dj i =
        (if (i <= dm)
         then let j = ((a.bigint_len - 1) - i) in
         let dk () = (dj (i + 1)) in
         (if (a.bigint_chiffres.(j) > b.bigint_chiffres.(j))
          then a.bigint_sign
          else (if (a.bigint_chiffres.(j) < b.bigint_chiffres.(j))
                then (not a.bigint_sign)
                else (dk ())))
         else (di ())) in
        (dj dl)))))
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
  let dc = (tmp mod 10) in
  (retenue, dc)) retenue) in
  let rec de len =
    (if ((len > 0) && (chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (de len)
     else {bigint_sign=true;
     bigint_len=len;
     bigint_chiffres=chiffres}) in
    (de len)
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
  ((fun  (retenue, tmp) -> let cz = tmp in
  (retenue, cz)) (if (tmp < 0)
                  then let tmp = (tmp + 10) in
                  let retenue = (- 1) in
                  (retenue, tmp)
                  else let retenue = 0 in
                  (retenue, tmp)))) retenue) in
  let rec db len =
    (if ((len > 0) && (chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (db len)
     else {bigint_sign=true;
     bigint_len=len;
     bigint_chiffres=chiffres}) in
    (db len)
let neg_bigint a =
  {bigint_sign=(not a.bigint_sign);
  bigint_len=a.bigint_len;
  bigint_chiffres=a.bigint_chiffres}
let add_bigint a b =
  let cu () = () in
  (if (a.bigint_sign = b.bigint_sign)
   then let cv () = (cu ()) in
   (if a.bigint_sign
    then (add_bigint_positif a b)
    else (neg_bigint (add_bigint_positif a b)))
   else let cw () = (cu ()) in
   (if a.bigint_sign
    then (*  a positif, b negatif  *)
    let cx () = (cw ()) in
    (if (bigint_gt a (neg_bigint b))
     then (sub_bigint_positif a b)
     else (neg_bigint (sub_bigint_positif b a)))
    else (*  a negatif, b positif  *)
    let cy () = (cw ()) in
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
  let chiffres = (Array.init_withenv len (fun  k () -> let ck = 0 in
  ((), ck)) ()) in
  let cs = 0 in
  let ct = (a.bigint_len - 1) in
  let rec co i =
    (if (i <= ct)
     then let retenue = 0 in
     let cq = 0 in
     let cr = (b.bigint_len - 1) in
     let rec cp j retenue =
       (if (j <= cr)
        then (
               chiffres.((i + j)) <- (chiffres.((i + j)) + (retenue + (b.bigint_chiffres.(j) * a.bigint_chiffres.(i))));
               let retenue = (chiffres.((i + j)) / 10) in
               (
                 chiffres.((i + j)) <- (chiffres.((i + j)) mod 10);
                 (cp (j + 1) retenue)
                 )
               
               )
        
        else (
               chiffres.((i + b.bigint_len)) <- (chiffres.((i + b.bigint_len)) + retenue);
               (co (i + 1))
               )
        ) in
       (cp cq retenue)
     else (
            chiffres.((a.bigint_len + b.bigint_len)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) / 10);
            chiffres.(((a.bigint_len + b.bigint_len) - 1)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) mod 10);
            let cm = 0 in
            let cn = 2 in
            let rec cl l len =
              (if (l <= cn)
               then let len = (if ((len <> 0) && (chiffres.((len - 1)) = 0))
                               then let len = (len - 1) in
                               len
                               else len) in
               (cl (l + 1) len)
               else {bigint_sign=(a.bigint_sign = b.bigint_sign);
               bigint_len=len;
               bigint_chiffres=chiffres}) in
              (cl cm len)
            )
     ) in
    (co cs)
let bigint_premiers_chiffres a i =
  let len = ((min (i) (a.bigint_len))) in
  let rec cj len =
    (if ((len <> 0) && (a.bigint_chiffres.((len - 1)) = 0))
     then let len = (len - 1) in
     (cj len)
     else {bigint_sign=a.bigint_sign;
     bigint_len=len;
     bigint_chiffres=a.bigint_chiffres}) in
    (cj len)
let bigint_shift a i =
  let chiffres = (Array.init_withenv (a.bigint_len + i) (fun  k () -> let ch cg = ((), cg) in
  (if (k >= i)
   then let cg = a.bigint_chiffres.((k - i)) in
   ((), cg)
   else let cg = 0 in
   ((), cg))) ()) in
  {bigint_sign=a.bigint_sign;
  bigint_len=(a.bigint_len + i);
  bigint_chiffres=chiffres}
let rec mul_bigint aa bb =
  let ce () = (*  Algorithme de Karatsuba  *)
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
   else let cf () = (ce ()) in
   (if (bb.bigint_len = 0)
    then bb
    else (if ((aa.bigint_len < 3) || (bb.bigint_len < 3))
          then (mul_bigint_cp aa bb)
          else (cf ()))))
let log10 a =
  let out0 = 1 in
  let rec cd a out0 =
    (if (a >= 10)
     then let a = (a / 10) in
     let out0 = (out0 + 1) in
     (cd a out0)
     else out0) in
    (cd a out0)
let bigint_of_int i =
  let size = (log10 i) in
  let size = (if (i = 0)
              then let size = 0 in
              size
              else size) in
  let t = (Array.init_withenv size (fun  j () -> let by = 0 in
  ((), by)) ()) in
  let ca = 0 in
  let cb = (size - 1) in
  let rec bz k i =
    (if (k <= cb)
     then (
            t.(k) <- (i mod 10);
            let i = (i / 10) in
            (bz (k + 1) i)
            )
     
     else {bigint_sign=true;
     bigint_len=size;
     bigint_chiffres=t}) in
    (bz ca i)
let fact_bigint a =
  let one = (bigint_of_int 1) in
  let out0 = one in
  let rec bx a out0 =
    (if (not (bigint_eq a one))
     then let out0 = (mul_bigint a out0) in
     let a = (sub_bigint a one) in
     (bx a out0)
     else out0) in
    (bx a out0)
let sum_chiffres_bigint a =
  let out0 = 0 in
  let bu = 0 in
  let bv = (a.bigint_len - 1) in
  let rec bt i out0 =
    (if (i <= bv)
     then let out0 = (out0 + a.bigint_chiffres.(i)) in
     (bt (i + 1) out0)
     else out0) in
    (bt bu out0)
let euler20 () =
  let a = (bigint_of_int 15) in
  (*  normalement c'est 100  *)
  let a = (fact_bigint a) in
  (sum_chiffres_bigint a)
let rec bigint_exp a b =
  let br () = () in
  (if (b = 1)
   then a
   else let bs () = (br ()) in
   (if ((b mod 2) = 0)
    then (bigint_exp (mul_bigint a a) (b / 2))
    else (mul_bigint a (bigint_exp a (b - 1)))))
let rec bigint_exp_10chiffres a b =
  let a = (bigint_premiers_chiffres a 10) in
  let bp () = () in
  (if (b = 1)
   then a
   else let bq () = (bp ()) in
   (if ((b mod 2) = 0)
    then (bigint_exp_10chiffres (mul_bigint a a) (b / 2))
    else (mul_bigint a (bigint_exp_10chiffres a (b - 1)))))
let euler48 () =
  let sum = (bigint_of_int 0) in
  let bn = 1 in
  let bo = 100 in
  let rec bm i sum =
    (if (i <= bo)
     then (*  1000 normalement  *)
     let ib = (bigint_of_int i) in
     let ibeib = (bigint_exp_10chiffres ib i) in
     let sum = (add_bigint sum ibeib) in
     let sum = (bigint_premiers_chiffres sum 10) in
     (bm (i + 1) sum)
     else (
            (Printf.printf "euler 48 = " );
            (print_bigint sum);
            (Printf.printf "\n" )
            )
     ) in
    (bm bn sum)
let euler16 () =
  let a = (bigint_of_int 2) in
  let a = (bigint_exp a 100) in
  (*  1000 normalement  *)
  (sum_chiffres_bigint a)
let euler25 () =
  let i = 2 in
  let a = (bigint_of_int 1) in
  let b = (bigint_of_int 1) in
  let rec bl a b i =
    (if (b.bigint_len < 100)
     then (*  1000 normalement  *)
     let c = (add_bigint a b) in
     let a = b in
     let b = c in
     let i = (i + 1) in
     (bl a b i)
     else i) in
    (bl a b i)
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
  let rec bc found n =
    (if found
     then let min0 = a0_bigint.(0) in
     let found = false in
     let bi = 2 in
     let bj = maxA in
     let rec bh i found min0 =
       (if (i <= bj)
        then ((fun  (found, min0) -> (bh (i + 1) found min0)) (if (b.(i) <= maxB)
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
                      let bf = 2 in
                      let bg = maxA in
                      let rec be l =
                        (if (l <= bg)
                         then (
                                (if ((bigint_eq a_bigint.(l) min0) && (b.(l) <= maxB))
                                 then (
                                        b.(l) <- (b.(l) + 1);
                                        a_bigint.(l) <- (mul_bigint a_bigint.(l) a0_bigint.(l))
                                        )
                                 
                                 else ());
                                (be (l + 1))
                                )
                         
                         else n) in
                        (be bf)
                      else n) in
        (bc found n)) in
       (bh bi found min0)
     else n) in
    (bc found n)
let main =
  (
    (Printf.printf "%d\n" (euler29 ()));
    let sum = (read_bigint 50) in
    let eb = 2 in
    let ec = 100 in
    let rec ea i sum =
      (if (i <= ec)
       then (
              (Scanf.scanf "%[\n \010]" (fun _ -> ()));
              let tmp = (read_bigint 50) in
              let sum = (add_bigint sum tmp) in
              (ea (i + 1) sum)
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
      (ea eb sum)
    )
  

