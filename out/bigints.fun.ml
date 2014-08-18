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

let max2 =
  (fun a b ->
      let dt = (fun () -> ()) in
      (if (a > b)
       then a
       else b));;
let min2 =
  (fun a b ->
      let ds = (fun () -> ()) in
      (if (a < b)
       then a
       else b));;
type bigint = {mutable bigint_sign : bool; mutable bigint_len : int; mutable bigint_chiffres : int array;};;
let read_bigint =
  (fun len ->
      let chiffres = (Array.init_withenv len (fun j ->
                                                 (fun () -> Scanf.scanf "%c"
                                                 (fun c ->
                                                     let dn = (int_of_char (c)) in
                                                     ((), dn)))) ()) in
      let dq = 0 in
      let dr = ((len - 1) / 2) in
      let rec dp i =
        (if (i <= dr)
         then let tmp = chiffres.(i) in
         (
           chiffres.(i) <- chiffres.(((len - 1) - i));
           chiffres.(((len - 1) - i)) <- tmp;
           (dp (i + 1))
           )
         
         else {bigint_sign=true;
         bigint_len=len;
         bigint_chiffres=chiffres}) in
        (dp dq));;
let print_bigint =
  (fun a ->
      (
        (if (not a.bigint_sign)
         then (Printf.printf "%c" '-')
         else ());
        let dl = 0 in
        let dm = (a.bigint_len - 1) in
        let rec dk i =
          (if (i <= dm)
           then (
                  (Printf.printf "%d" a.bigint_chiffres.(((a.bigint_len - 1) - i)));
                  (dk (i + 1))
                  )
           
           else ()) in
          (dk dl)
        )
      );;
let bigint_eq =
  (fun a b ->
      (*  Renvoie vrai si a = b  *)
      let df = (fun () -> ()) in
      (if (a.bigint_sign <> b.bigint_sign)
       then false
       else let dg = (fun () -> (df ())) in
       (if (a.bigint_len <> b.bigint_len)
        then false
        else let di = 0 in
        let dj = (a.bigint_len - 1) in
        let rec dh i =
          (if (i <= dj)
           then (if (a.bigint_chiffres.(i) <> b.bigint_chiffres.(i))
                 then false
                 else (dh (i + 1)))
           else true) in
          (dh di))));;
let bigint_gt =
  (fun a b ->
      (*  Renvoie vrai si a > b  *)
      let cx = (fun () -> ()) in
      (if (a.bigint_sign && (not b.bigint_sign))
       then true
       else let cy = (fun () -> (cx ())) in
       (if ((not a.bigint_sign) && b.bigint_sign)
        then false
        else let cz = (fun () -> true) in
        (if (a.bigint_len > b.bigint_len)
         then a.bigint_sign
         else let da = (fun () -> (cz ())) in
         (if (a.bigint_len < b.bigint_len)
          then (not a.bigint_sign)
          else let dd = 0 in
          let de = (a.bigint_len - 1) in
          let rec db i =
            (if (i <= de)
             then let j = ((a.bigint_len - 1) - i) in
             let dc = (fun () -> (db (i + 1))) in
             (if (a.bigint_chiffres.(j) > b.bigint_chiffres.(j))
              then a.bigint_sign
              else (if (a.bigint_chiffres.(j) < b.bigint_chiffres.(j))
                    then (not a.bigint_sign)
                    else (dc ())))
             else (da ())) in
            (db dd))))));;
let bigint_lt =
  (fun a b ->
      (not (bigint_gt a b)));;
let add_bigint_positif =
  (fun a b ->
      (*  Une addition ou on en a rien a faire des signes  *)
      let len = ((max2 a.bigint_len b.bigint_len) + 1) in
      let retenue = 0 in
      let chiffres = (Array.init_withenv len (fun i retenue ->
                                                 let tmp = retenue in
                                                 let tmp = (if (i < a.bigint_len)
                                                            then let tmp = (tmp + a.bigint_chiffres.(i)) in
                                                            tmp
                                                            else tmp) in
                                                 let tmp = (if (i < b.bigint_len)
                                                            then let tmp = (tmp + b.bigint_chiffres.(i)) in
                                                            tmp
                                                            else tmp) in
                                                 let retenue = (tmp / 10) in
                                                 let cu = (tmp mod 10) in
                                                 (retenue, cu)) retenue) in
      let rec cw len =
        (if ((len > 0) && (chiffres.((len - 1)) = 0))
         then let len = (len - 1) in
         (cw len)
         else {bigint_sign=true;
         bigint_len=len;
         bigint_chiffres=chiffres}) in
        (cw len));;
let sub_bigint_positif =
  (fun a b ->
      (*  Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
 *)
      let len = a.bigint_len in
      let retenue = 0 in
      let chiffres = (Array.init_withenv len (fun i retenue ->
                                                 let tmp = (retenue + a.bigint_chiffres.(i)) in
                                                 let tmp = (if (i < b.bigint_len)
                                                            then let tmp = (tmp - b.bigint_chiffres.(i)) in
                                                            tmp
                                                            else tmp) in
                                                 ((fun (retenue, tmp) ->
                                                      let cr = tmp in
                                                      (retenue, cr)) (
                                                 if (tmp < 0)
                                                 then let tmp = (tmp + 10) in
                                                 let retenue = (- 1) in
                                                 (retenue, tmp)
                                                 else let retenue = 0 in
                                                 (retenue, tmp)))) retenue) in
      let rec ct len =
        (if ((len > 0) && (chiffres.((len - 1)) = 0))
         then let len = (len - 1) in
         (ct len)
         else {bigint_sign=true;
         bigint_len=len;
         bigint_chiffres=chiffres}) in
        (ct len));;
let neg_bigint =
  (fun a ->
      {bigint_sign=(not a.bigint_sign);
      bigint_len=a.bigint_len;
      bigint_chiffres=a.bigint_chiffres});;
let add_bigint =
  (fun a b ->
      let cm = (fun () -> ()) in
      (if (a.bigint_sign = b.bigint_sign)
       then let cn = (fun () -> (cm ())) in
       (if a.bigint_sign
        then (add_bigint_positif a b)
        else (neg_bigint (add_bigint_positif a b)))
       else let co = (fun () -> (cm ())) in
       (if a.bigint_sign
        then (*  a positif, b negatif  *)
        let cp = (fun () -> (co ())) in
        (if (bigint_gt a (neg_bigint b))
         then (sub_bigint_positif a b)
         else (neg_bigint (sub_bigint_positif b a)))
        else (*  a negatif, b positif  *)
        let cq = (fun () -> (co ())) in
        (if (bigint_gt (neg_bigint a) b)
         then (neg_bigint (sub_bigint_positif a b))
         else (sub_bigint_positif b a)))));;
let sub_bigint =
  (fun a b ->
      (add_bigint a (neg_bigint b)));;
let mul_bigint_cp =
  (fun a b ->
      (*  Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction.  *)
      let len = ((a.bigint_len + b.bigint_len) + 1) in
      let chiffres = (Array.init_withenv len (fun k ->
                                                 (fun () -> let cc = 0 in
                                                 ((), cc))) ()) in
      let ck = 0 in
      let cl = (a.bigint_len - 1) in
      let rec cg i =
        (if (i <= cl)
         then let retenue = 0 in
         let ci = 0 in
         let cj = (b.bigint_len - 1) in
         let rec ch j retenue =
           (if (j <= cj)
            then (
                   chiffres.((i + j)) <- (chiffres.((i + j)) + (retenue + (b.bigint_chiffres.(j) * a.bigint_chiffres.(i))));
                   let retenue = (chiffres.((i + j)) / 10) in
                   (
                     chiffres.((i + j)) <- (chiffres.((i + j)) mod 10);
                     (ch (j + 1) retenue)
                     )
                   
                   )
            
            else (
                   chiffres.((i + b.bigint_len)) <- (chiffres.((i + b.bigint_len)) + retenue);
                   (cg (i + 1))
                   )
            ) in
           (ch ci retenue)
         else (
                chiffres.((a.bigint_len + b.bigint_len)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) / 10);
                chiffres.(((a.bigint_len + b.bigint_len) - 1)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) mod 10);
                let ce = 0 in
                let cf = 2 in
                let rec cd l len =
                  (if (l <= cf)
                   then let len = (if ((len <> 0) && (chiffres.((len - 1)) = 0))
                                   then let len = (len - 1) in
                                   len
                                   else len) in
                   (cd (l + 1) len)
                   else {bigint_sign=(a.bigint_sign = b.bigint_sign);
                   bigint_len=len;
                   bigint_chiffres=chiffres}) in
                  (cd ce len)
                )
         ) in
        (cg ck));;
let bigint_premiers_chiffres =
  (fun a i ->
      let len = (min2 i a.bigint_len) in
      let rec cb len =
        (if ((len <> 0) && (a.bigint_chiffres.((len - 1)) = 0))
         then let len = (len - 1) in
         (cb len)
         else {bigint_sign=a.bigint_sign;
         bigint_len=len;
         bigint_chiffres=a.bigint_chiffres}) in
        (cb len));;
let bigint_shift =
  (fun a i ->
      let e = (a.bigint_len + i) in
      let chiffres = (Array.init_withenv e (fun k ->
                                               (fun () -> let bz = (fun
                                                by ->
                                               ((), by)) in
                                               (if (k >= i)
                                                then let by = a.bigint_chiffres.((k - i)) in
                                                ((), by)
                                                else let by = 0 in
                                                ((), by)))) ()) in
      {bigint_sign=a.bigint_sign;
      bigint_len=(a.bigint_len + i);
      bigint_chiffres=chiffres});;
let rec mul_bigint =
  (fun aa bb ->
      let bw = (fun () -> (*  Algorithme de Karatsuba  *)
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
       else let bx = (fun () -> (bw ())) in
       (if (bb.bigint_len = 0)
        then bb
        else (if ((aa.bigint_len < 3) || (bb.bigint_len < 3))
              then (mul_bigint_cp aa bb)
              else (bx ())))));;
let log10 =
  (fun a ->
      let out_ = 1 in
      let rec bv a out_ =
        (if (a >= 10)
         then let a = (a / 10) in
         let out_ = (out_ + 1) in
         (bv a out_)
         else out_) in
        (bv a out_));;
let bigint_of_int =
  (fun i ->
      let size = (log10 i) in
      let size = (if (i = 0)
                  then let size = 0 in
                  size
                  else size) in
      let t = (Array.init_withenv size (fun j ->
                                           (fun () -> let bq = 0 in
                                           ((), bq))) ()) in
      let bs = 0 in
      let bt = (size - 1) in
      let rec br k i =
        (if (k <= bt)
         then (
                t.(k) <- (i mod 10);
                let i = (i / 10) in
                (br (k + 1) i)
                )
         
         else {bigint_sign=true;
         bigint_len=size;
         bigint_chiffres=t}) in
        (br bs i));;
let fact_bigint =
  (fun a ->
      let one = (bigint_of_int 1) in
      let out_ = one in
      let rec bp a out_ =
        (if (not (bigint_eq a one))
         then let out_ = (mul_bigint a out_) in
         let a = (sub_bigint a one) in
         (bp a out_)
         else out_) in
        (bp a out_));;
let sum_chiffres_bigint =
  (fun a ->
      let out_ = 0 in
      let bm = 0 in
      let bn = (a.bigint_len - 1) in
      let rec bl i out_ =
        (if (i <= bn)
         then let out_ = (out_ + a.bigint_chiffres.(i)) in
         (bl (i + 1) out_)
         else out_) in
        (bl bm out_));;
let euler20 =
  (fun () -> let a = (bigint_of_int 15) in
  (*  normalement c'est 100  *)
  let a = (fact_bigint a) in
  (sum_chiffres_bigint a));;
let rec bigint_exp =
  (fun a b ->
      let bj = (fun () -> ()) in
      (if (b = 1)
       then a
       else let bk = (fun () -> (bj ())) in
       (if ((b mod 2) = 0)
        then (bigint_exp (mul_bigint a a) (b / 2))
        else (mul_bigint a (bigint_exp a (b - 1))))));;
let rec bigint_exp_10chiffres =
  (fun a b ->
      let a = (bigint_premiers_chiffres a 10) in
      let bh = (fun () -> ()) in
      (if (b = 1)
       then a
       else let bi = (fun () -> (bh ())) in
       (if ((b mod 2) = 0)
        then (bigint_exp_10chiffres (mul_bigint a a) (b / 2))
        else (mul_bigint a (bigint_exp_10chiffres a (b - 1))))));;
let euler48 =
  (fun () -> let sum = (bigint_of_int 0) in
  let bf = 1 in
  let bg = 100 in
  let rec be i sum =
    (if (i <= bg)
     then (*  1000 normalement  *)
     let ib = (bigint_of_int i) in
     let ibeib = (bigint_exp_10chiffres ib i) in
     let sum = (add_bigint sum ibeib) in
     let sum = (bigint_premiers_chiffres sum 10) in
     (be (i + 1) sum)
     else (
            (Printf.printf "%s" "euler 48 = ");
            (print_bigint sum);
            (Printf.printf "%s" "\n")
            )
     ) in
    (be bf sum));;
let euler16 =
  (fun () -> let a = (bigint_of_int 2) in
  let a = (bigint_exp a 100) in
  (*  1000 normalement  *)
  (sum_chiffres_bigint a));;
let euler25 =
  (fun () -> let i = 2 in
  let a = (bigint_of_int 1) in
  let b = (bigint_of_int 1) in
  let rec bc a b i =
    (if (b.bigint_len < 100)
     then (*  1000 normalement  *)
     let c = (add_bigint a b) in
     let a = b in
     let b = c in
     let i = (i + 1) in
     (bc a b i)
     else i) in
    (bc a b i));;
let euler29 =
  (fun () -> let maxA = 5 in
  let maxB = 5 in
  let f = (maxA + 1) in
  let a_bigint = (Array.init_withenv f (fun j ->
                                           (fun () -> let o = (bigint_of_int (j * j)) in
                                           ((), o))) ()) in
  let g = (maxA + 1) in
  let a0_bigint = (Array.init_withenv g (fun j2 ->
                                            (fun () -> let p = (bigint_of_int j2) in
                                            ((), p))) ()) in
  let h = (maxA + 1) in
  let b = (Array.init_withenv h (fun k ->
                                    (fun () -> let q = 2 in
                                    ((), q))) ()) in
  let n = 0 in
  let found = true in
  let rec s found n =
    (if found
     then let min_ = a0_bigint.(0) in
     let found = false in
     let y = 2 in
     let z = maxA in
     let rec x i found min_ =
       (if (i <= z)
        then ((fun (found, min_) ->
                  (x (i + 1) found min_)) (if (b.(i) <= maxB)
                                           then ((fun (found, min_) ->
                                                     (found, min_)) (
                                           if found
                                           then let min_ = (if (bigint_lt a_bigint.(i) min_)
                                                            then let min_ = a_bigint.(i) in
                                                            min_
                                                            else min_) in
                                           (found, min_)
                                           else let min_ = a_bigint.(i) in
                                           let found = true in
                                           (found, min_)))
                                           else (found, min_)))
        else let n = (if found
                      then let n = (n + 1) in
                      let v = 2 in
                      let w = maxA in
                      let rec u l =
                        (if (l <= w)
                         then (
                                (if ((bigint_eq a_bigint.(l) min_) && (b.(l) <= maxB))
                                 then (
                                        b.(l) <- (b.(l) + 1);
                                        a_bigint.(l) <- (mul_bigint a_bigint.(l) a0_bigint.(l));
                                        ()
                                        )
                                 
                                 else ());
                                (u (l + 1))
                                )
                         
                         else n) in
                        (u v)
                      else n) in
        (s found n)) in
       (x y found min_)
     else n) in
    (s found n));;
let main =
  (
    (Printf.printf "%d" (euler29 ()));
    (Printf.printf "%s" "\n");
    let sum = (read_bigint 50) in
    let dv = 2 in
    let dw = 100 in
    let rec du i sum =
      (if (i <= dw)
       then (Scanf.scanf "%[\n \010]" (fun _ -> let tmp = (read_bigint 50) in
       let sum = (add_bigint sum tmp) in
       (du (i + 1) sum)))
       else (
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
              (
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
                (
                  (if m
                   then (Printf.printf "%s" "True")
                   else (Printf.printf "%s" "False"));
                  (Printf.printf "%s" "\n")
                  )
                
                )
              
              )
       ) in
      (du dv sum)
    )
  ;;

