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
      ((fun ei ->
           (if (a > b)
            then a
            else b)) (fun a b ->
                         ())));;
let rec min2 =
  (fun a b ->
      ((fun eh ->
           (if (a < b)
            then a
            else b)) (fun a b ->
                         ())));;
type bigint = {mutable bigint_sign : bool; mutable bigint_len : int; mutable bigint_chiffres : int array;};;
let rec read_bigint =
  (fun len ->
      ((fun chiffres ->
           ((fun ef eg ->
                let rec ee i len =
                  (if (i <= eg)
                   then ((fun tmp ->
                             (chiffres.(i) <- chiffres.(((len - 1) - i)); (chiffres.(((len - 1) - i)) <- tmp; (ee (i + 1) len)))) chiffres.(i))
                   else {bigint_sign=true;
                   bigint_len=len;
                   bigint_chiffres=chiffres}) in
                  (ee ef len)) 0 ((len - 1) / 2))) ((Array.init_withenv len (fun
       j ->
      (fun (len) ->
          Scanf.scanf "%c" (fun c ->
                               ((fun ed ->
                                    ((len), ed)) (int_of_char (c)))))) ) (len))));;
let rec print_bigint =
  (fun a ->
      ((fun ec ->
           (if (not a.bigint_sign)
            then (Printf.printf "%c" '-';
            (ec a))
            else (ec a))) (fun a ->
                              ((fun ea eb ->
                                   let rec dz i a =
                                     (if (i <= eb)
                                      then (Printf.printf "%d" a.bigint_chiffres.(((a.bigint_len - 1) - i));
                                      (dz (i + 1) a))
                                      else ()) in
                                     (dz ea a)) 0 (a.bigint_len - 1)))));;
let rec bigint_eq =
  (fun a b ->
      (*  Renvoie vrai si a = b  *)
      ((fun dt ->
           (if (a.bigint_sign <> b.bigint_sign)
            then false
            else ((fun du ->
                      (if (a.bigint_len <> b.bigint_len)
                       then false
                       else ((fun dx dy ->
                                 let rec dv i a b =
                                   (if (i <= dy)
                                    then ((fun dw ->
                                              (if (a.bigint_chiffres.(i) <> b.bigint_chiffres.(i))
                                               then false
                                               else (dw a b))) (fun a b ->
                                                                   (dv (i + 1) a b)))
                                    else true) in
                                   (dv dx a b)) 0 (a.bigint_len - 1)))) (fun
             a b ->
            (dt a b))))) (fun a b ->
                             ())));;
let rec bigint_gt =
  (fun a b ->
      (*  Renvoie vrai si a > b  *)
      ((fun dj ->
           (if (a.bigint_sign && (not b.bigint_sign))
            then true
            else ((fun dk ->
                      (if ((not a.bigint_sign) && b.bigint_sign)
                       then false
                       else ((fun dl ->
                                 (if (a.bigint_len > b.bigint_len)
                                  then a.bigint_sign
                                  else ((fun dm ->
                                            (if (a.bigint_len < b.bigint_len)
                                             then (not a.bigint_sign)
                                             else ((fun dr ds ->
                                                       let rec dn i a b =
                                                         (if (i <= ds)
                                                          then ((fun j ->
                                                                    ((fun
                                                                     dp ->
                                                                    (
                                                                    if (a.bigint_chiffres.(j) > b.bigint_chiffres.(j))
                                                                    then a.bigint_sign
                                                                    else ((fun
                                                                     dq ->
                                                                    (
                                                                    if (a.bigint_chiffres.(j) < b.bigint_chiffres.(j))
                                                                    then (not a.bigint_sign)
                                                                    else (dq j a b))) (fun
                                                                     j a b ->
                                                                    (dp j a b))))) (fun
                                                                     j a b ->
                                                                    (dn (i + 1) a b)))) ((a.bigint_len - 1) - i))
                                                          else (dm a b)) in
                                                         (dn dr a b)) 0 (a.bigint_len - 1)))) (fun
                                   a b ->
                                  (dl a b))))) (fun a b ->
                                                   true)))) (fun a b ->
                                                                (dj a b))))) (fun
       a b ->
      ())));;
let rec bigint_lt =
  (fun a b ->
      (not (bigint_gt a b)));;
let rec add_bigint_positif =
  (fun a b ->
      (*  Une addition ou on en a rien a faire des signes  *)
      ((fun len ->
           ((fun retenue ->
                ((fun chiffres ->
                     let rec di retenue len a b =
                       (if ((len > 0) && (chiffres.((len - 1)) = 0))
                        then ((fun len ->
                                  (di retenue len a b)) (len - 1))
                        else {bigint_sign=true;
                        bigint_len=len;
                        bigint_chiffres=chiffres}) in
                       (di retenue len a b)) ((Array.init_withenv len (fun
                 i ->
                (fun (retenue, len, a, b) ->
                    ((fun tmp ->
                         ((fun dg ->
                              (if (i < a.bigint_len)
                               then ((fun tmp ->
                                         (dg tmp i retenue len a b)) (tmp + a.bigint_chiffres.(i)))
                               else (dg tmp i retenue len a b))) (fun
                          tmp i retenue len a b ->
                         ((fun df ->
                              (if (i < b.bigint_len)
                               then ((fun tmp ->
                                         (df tmp i retenue len a b)) (tmp + b.bigint_chiffres.(i)))
                               else (df tmp i retenue len a b))) (fun
                          tmp i retenue len a b ->
                         ((fun retenue ->
                              ((fun de ->
                                   ((retenue, len, a, b), de)) (tmp mod 10))) (tmp / 10))))))) retenue))) ) (retenue, len, a, b)))) 0)) ((max2 a.bigint_len b.bigint_len) + 1)));;
let rec sub_bigint_positif =
  (fun a b ->
      (*  Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
 *)
      ((fun len ->
           ((fun retenue ->
                ((fun chiffres ->
                     let rec dd retenue len a b =
                       (if ((len > 0) && (chiffres.((len - 1)) = 0))
                        then ((fun len ->
                                  (dd retenue len a b)) (len - 1))
                        else {bigint_sign=true;
                        bigint_len=len;
                        bigint_chiffres=chiffres}) in
                       (dd retenue len a b)) ((Array.init_withenv len (fun
                 i ->
                (fun (retenue, len, a, b) ->
                    ((fun tmp ->
                         ((fun db ->
                              (if (i < b.bigint_len)
                               then ((fun tmp ->
                                         (db tmp i retenue len a b)) (tmp - b.bigint_chiffres.(i)))
                               else (db tmp i retenue len a b))) (fun
                          tmp i retenue len a b ->
                         ((fun da ->
                              (if (tmp < 0)
                               then ((fun tmp ->
                                         ((fun retenue ->
                                              (da tmp i retenue len a b)) (- 1))) (tmp + 10))
                               else ((fun retenue ->
                                         (da tmp i retenue len a b)) 0))) (fun
                          tmp i retenue len a b ->
                         ((fun cz ->
                              ((retenue, len, a, b), cz)) tmp)))))) (retenue + a.bigint_chiffres.(i))))) ) (retenue, len, a, b)))) 0)) a.bigint_len));;
let rec neg_bigint =
  (fun a ->
      {bigint_sign=(not a.bigint_sign);
      bigint_len=a.bigint_len;
      bigint_chiffres=a.bigint_chiffres});;
let rec add_bigint =
  (fun a b ->
      ((fun cu ->
           (if (a.bigint_sign = b.bigint_sign)
            then ((fun cv ->
                      (if a.bigint_sign
                       then (add_bigint_positif a b)
                       else (neg_bigint (add_bigint_positif a b)))) (fun
             a b ->
            (cu a b)))
            else ((fun cw ->
                      (if a.bigint_sign
                       then (*  a positif, b negatif  *)
                       ((fun cx ->
                            (if (bigint_gt a (neg_bigint b))
                             then (sub_bigint_positif a b)
                             else (neg_bigint (sub_bigint_positif b a)))) (fun
                        a b ->
                       (cw a b)))
                       else (*  a negatif, b positif  *)
                       ((fun cy ->
                            (if (bigint_gt (neg_bigint a) b)
                             then (neg_bigint (sub_bigint_positif a b))
                             else (sub_bigint_positif b a))) (fun a b ->
                                                                 (cw a b))))) (fun
             a b ->
            (cu a b))))) (fun a b ->
                             ())));;
let rec sub_bigint =
  (fun a b ->
      (add_bigint a (neg_bigint b)));;
let rec mul_bigint_cp =
  (fun a b ->
      (*  Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction.  *)
      ((fun len ->
           ((fun chiffres ->
                ((fun cs ct ->
                     let rec co i len a b =
                       (if (i <= ct)
                        then ((fun retenue ->
                                  ((fun cq cr ->
                                       let rec cp j retenue len a b =
                                         (if (j <= cr)
                                          then (chiffres.((i + j)) <- (chiffres.((i + j)) + (retenue + (b.bigint_chiffres.(j) * a.bigint_chiffres.(i)))); ((fun
                                           retenue ->
                                          (chiffres.((i + j)) <- (chiffres.((i + j)) mod 10); (cp (j + 1) retenue len a b))) (chiffres.((i + j)) / 10)))
                                          else (chiffres.((i + b.bigint_len)) <- (chiffres.((i + b.bigint_len)) + retenue); (co (i + 1) len a b))) in
                                         (cp cq retenue len a b)) 0 (b.bigint_len - 1))) 0)
                        else (chiffres.((a.bigint_len + b.bigint_len)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) / 10); (chiffres.(((a.bigint_len + b.bigint_len) - 1)) <- (chiffres.(((a.bigint_len + b.bigint_len) - 1)) mod 10); ((fun
                         cm cn ->
                        let rec ck l len a b =
                          (if (l <= cn)
                           then ((fun cl ->
                                     (if ((len <> 0) && (chiffres.((len - 1)) = 0))
                                      then ((fun len ->
                                                (cl len a b)) (len - 1))
                                      else (cl len a b))) (fun len a b ->
                                                              (ck (l + 1) len a b)))
                           else {bigint_sign=(a.bigint_sign = b.bigint_sign);
                           bigint_len=len;
                           bigint_chiffres=chiffres}) in
                          (ck cm len a b)) 0 2)))) in
                       (co cs len a b)) 0 (a.bigint_len - 1))) ((Array.init_withenv len (fun
            k ->
           (fun (len, a, b) ->
               ((fun cj ->
                    ((len, a, b), cj)) 0))) ) (len, a, b)))) ((a.bigint_len + b.bigint_len) + 1)));;
let rec bigint_premiers_chiffres =
  (fun a i ->
      ((fun len ->
           let rec ci len a i =
             (if ((len <> 0) && (a.bigint_chiffres.((len - 1)) = 0))
              then ((fun len ->
                        (ci len a i)) (len - 1))
              else {bigint_sign=a.bigint_sign;
              bigint_len=len;
              bigint_chiffres=a.bigint_chiffres}) in
             (ci len a i)) (min2 i a.bigint_len)));;
let rec bigint_shift =
  (fun a i ->
      ((fun e ->
           ((fun chiffres ->
                {bigint_sign=a.bigint_sign;
                bigint_len=(a.bigint_len + i);
                bigint_chiffres=chiffres}) ((Array.init_withenv e (fun
            k ->
           (fun (e, a, i) ->
               ((fun cg ->
                    (if (k >= i)
                     then ((fun cf ->
                               ((e, a, i), cf)) a.bigint_chiffres.((k - i)))
                     else ((fun cf ->
                               ((e, a, i), cf)) 0))) (fun k e a i ->
                                                         (fun cf ->
                                                             ((e, a, i), cf)))))) ) (e, a, i)))) (a.bigint_len + i)));;
let rec mul_bigint =
  (fun aa bb ->
      ((fun cc ->
           (if (aa.bigint_len = 0)
            then aa
            else ((fun cd ->
                      (if (bb.bigint_len = 0)
                       then bb
                       else ((fun ce ->
                                 (if ((aa.bigint_len < 3) || (bb.bigint_len < 3))
                                  then (mul_bigint_cp aa bb)
                                  else (ce aa bb))) (fun aa bb ->
                                                        (cd aa bb))))) (fun
             aa bb ->
            (cc aa bb))))) (fun aa bb ->
                               (*  Algorithme de Karatsuba  *)
                               ((fun split ->
                                    ((fun a ->
                                         ((fun b ->
                                              ((fun c ->
                                                   ((fun d ->
                                                        ((fun amoinsb ->
                                                             ((fun cmoinsd ->
                                                                  ((fun
                                                                   ac ->
                                                                  ((fun
                                                                   bd ->
                                                                  ((fun
                                                                   amoinsbcmoinsd ->
                                                                  ((fun
                                                                   acdec ->
                                                                  (add_bigint (add_bigint acdec bd) (bigint_shift (sub_bigint (add_bigint ac bd) amoinsbcmoinsd) split))) (bigint_shift ac (2 * split)))) (mul_bigint amoinsb cmoinsd))) (mul_bigint b d))) (mul_bigint a c))) (sub_bigint c d))) (sub_bigint a b))) (bigint_premiers_chiffres bb split))) (bigint_shift bb (- split)))) (bigint_premiers_chiffres aa split))) (bigint_shift aa (- split)))) ((min2 aa.bigint_len bb.bigint_len) / 2)))));;
let rec log10 =
  (fun a ->
      ((fun out_ ->
           let rec cb out_ a =
             (if (a >= 10)
              then ((fun a ->
                        ((fun out_ ->
                             (cb out_ a)) (out_ + 1))) (a / 10))
              else out_) in
             (cb out_ a)) 1));;
let rec bigint_of_int =
  (fun i ->
      ((fun size ->
           ((fun bz ->
                (if (i = 0)
                 then ((fun size ->
                           (bz size i)) 0)
                 else (bz size i))) (fun size i ->
                                        ((fun t ->
                                             ((fun bx by ->
                                                  let rec bw k size i =
                                                    (if (k <= by)
                                                     then (t.(k) <- (i mod 10); ((fun
                                                      i ->
                                                     (bw (k + 1) size i)) (i / 10)))
                                                     else {bigint_sign=true;
                                                     bigint_len=size;
                                                     bigint_chiffres=t}) in
                                                    (bw bx size i)) 0 (size - 1))) ((Array.init_withenv size (fun
                                         j ->
                                        (fun (size, i) ->
                                            ((fun bv ->
                                                 ((size, i), bv)) 0))) ) (size, i)))))) (log10 i)));;
let rec fact_bigint =
  (fun a ->
      ((fun one ->
           ((fun out_ ->
                let rec bu out_ one a =
                  (if (not (bigint_eq a one))
                   then ((fun out_ ->
                             ((fun a ->
                                  (bu out_ one a)) (sub_bigint a one))) (mul_bigint a out_))
                   else out_) in
                  (bu out_ one a)) one)) (bigint_of_int 1)));;
let rec sum_chiffres_bigint =
  (fun a ->
      ((fun out_ ->
           ((fun br bs ->
                let rec bq i out_ a =
                  (if (i <= bs)
                   then ((fun out_ ->
                             (bq (i + 1) out_ a)) (out_ + a.bigint_chiffres.(i)))
                   else out_) in
                  (bq br out_ a)) 0 (a.bigint_len - 1))) 0));;
let rec euler20 =
  (fun () -> ((fun a ->
                  (*  normalement c'est 100  *)
                  ((fun a ->
                       (sum_chiffres_bigint a)) (fact_bigint a))) (bigint_of_int 15)));;
let rec bigint_exp =
  (fun a b ->
      ((fun bo ->
           (if (b = 1)
            then a
            else ((fun bp ->
                      (if ((b mod 2) = 0)
                       then (bigint_exp (mul_bigint a a) (b / 2))
                       else (mul_bigint a (bigint_exp a (b - 1))))) (fun
             a b ->
            (bo a b))))) (fun a b ->
                             ())));;
let rec bigint_exp_10chiffres =
  (fun a b ->
      ((fun a ->
           ((fun bm ->
                (if (b = 1)
                 then a
                 else ((fun bn ->
                           (if ((b mod 2) = 0)
                            then (bigint_exp_10chiffres (mul_bigint a a) (b / 2))
                            else (mul_bigint a (bigint_exp_10chiffres a (b - 1))))) (fun
                  a b ->
                 (bm a b))))) (fun a b ->
                                  ()))) (bigint_premiers_chiffres a 10)));;
let rec euler48 =
  (fun () -> ((fun sum ->
                  ((fun bk bl ->
                       let rec bj i sum =
                         (if (i <= bl)
                          then (*  1000 normalement  *)
                          ((fun ib ->
                               ((fun ibeib ->
                                    ((fun sum ->
                                         ((fun sum ->
                                              (bj (i + 1) sum)) (bigint_premiers_chiffres sum 10))) (add_bigint sum ibeib))) (bigint_exp_10chiffres ib i))) (bigint_of_int i))
                          else (Printf.printf "%s" "euler 48 = ";
                          begin
                            (print_bigint sum);
                            (Printf.printf "%s" "\n";
                            ())
                            end
                          )) in
                         (bj bk sum)) 1 100)) (bigint_of_int 0)));;
let rec euler16 =
  (fun () -> ((fun a ->
                  ((fun a ->
                       (*  1000 normalement  *)
                       (sum_chiffres_bigint a)) (bigint_exp a 100))) (bigint_of_int 2)));;
let rec euler25 =
  (fun () -> ((fun i ->
                  ((fun a ->
                       ((fun b ->
                            let rec bi b a i =
                              (if (b.bigint_len < 100)
                               then (*  1000 normalement  *)
                               ((fun c ->
                                    ((fun a ->
                                         ((fun b ->
                                              ((fun i ->
                                                   (bi b a i)) (i + 1))) c)) b)) (add_bigint a b))
                               else i) in
                              (bi b a i)) (bigint_of_int 1))) (bigint_of_int 1))) 2));;
let rec euler29 =
  (fun () -> ((fun maxA ->
                  ((fun maxB ->
                       ((fun f ->
                            ((fun a_bigint ->
                                 ((fun g ->
                                      ((fun a0_bigint ->
                                           ((fun h ->
                                                ((fun b ->
                                                     ((fun n ->
                                                          ((fun found ->
                                                               let rec s found n h g f maxB maxA =
                                                                 (if found
                                                                  then ((fun
                                                                   min_ ->
                                                                  ((fun
                                                                   found ->
                                                                  ((fun
                                                                   bf bg ->
                                                                  let rec z i min_ found n h g f maxB maxA =
                                                                    (
                                                                    if (i <= bg)
                                                                    then ((fun
                                                                     ba ->
                                                                    (
                                                                    if (b.(i) <= maxB)
                                                                    then ((fun
                                                                     bc ->
                                                                    (
                                                                    if found
                                                                    then ((fun
                                                                     be ->
                                                                    (
                                                                    if (bigint_lt a_bigint.(i) min_)
                                                                    then ((fun
                                                                     min_ ->
                                                                    (be min_ found n h g f maxB maxA)) a_bigint.(i))
                                                                    else (be min_ found n h g f maxB maxA))) (fun
                                                                     min_ found n h g f maxB maxA ->
                                                                    (bc min_ found n h g f maxB maxA)))
                                                                    else ((fun
                                                                     min_ ->
                                                                    ((fun
                                                                     found ->
                                                                    (bc min_ found n h g f maxB maxA)) true)) a_bigint.(i)))) (fun
                                                                     min_ found n h g f maxB maxA ->
                                                                    (ba min_ found n h g f maxB maxA)))
                                                                    else (ba min_ found n h g f maxB maxA))) (fun
                                                                     min_ found n h g f maxB maxA ->
                                                                    (z (i + 1) min_ found n h g f maxB maxA)))
                                                                    else ((fun
                                                                     u ->
                                                                    (
                                                                    if found
                                                                    then ((fun
                                                                     n ->
                                                                    ((fun
                                                                     x y ->
                                                                    let rec v l min_ found n h g f maxB maxA =
                                                                    (if (l <= y)
                                                                    then ((fun
                                                                     w ->
                                                                    (
                                                                    if ((bigint_eq a_bigint.(l) min_) && (b.(l) <= maxB))
                                                                    then (b.(l) <- (b.(l) + 1); (a_bigint.(l) <- (mul_bigint a_bigint.(l) a0_bigint.(l)); (w min_ found n h g f maxB maxA)))
                                                                    else (w min_ found n h g f maxB maxA))) (fun
                                                                     min_ found n h g f maxB maxA ->
                                                                    (v (l + 1) min_ found n h g f maxB maxA)))
                                                                    else (u min_ found n h g f maxB maxA)) in
                                                                    (v x min_ found n h g f maxB maxA)) 2 maxA)) (n + 1))
                                                                    else (u min_ found n h g f maxB maxA))) (fun
                                                                     min_ found n h g f maxB maxA ->
                                                                    (s found n h g f maxB maxA)))) in
                                                                    (z bf min_ found n h g f maxB maxA)) 2 maxA)) false)) a0_bigint.(0))
                                                                  else n) in
                                                                 (s found n h g f maxB maxA)) true)) 0)) ((Array.init_withenv h (fun
                                                 k ->
                                                (fun (h, g, f, maxB, maxA) ->
                                                    ((fun q ->
                                                         ((h, g, f, maxB, maxA), q)) 2))) ) (h, g, f, maxB, maxA)))) (maxA + 1))) ((Array.init_withenv g (fun
                                       j2 ->
                                      (fun (g, f, maxB, maxA) ->
                                          ((fun p ->
                                               ((g, f, maxB, maxA), p)) (bigint_of_int j2)))) ) (g, f, maxB, maxA)))) (maxA + 1))) ((Array.init_withenv f (fun
                             j ->
                            (fun (f, maxB, maxA) ->
                                ((fun o ->
                                     ((f, maxB, maxA), o)) (bigint_of_int (j * j))))) ) (f, maxB, maxA)))) (maxA + 1))) 5)) 5));;
let rec main =
  (Printf.printf "%d" (euler29 ());
  (Printf.printf "%s" "\n";
  ((fun sum ->
       ((fun el em ->
            let rec ek i sum =
              (if (i <= em)
               then (Scanf.scanf "%[\n \010]" (fun _ -> ((fun tmp ->
                                                             ((fun sum ->
                                                                  (ek (i + 1) sum)) (add_bigint sum tmp))) (read_bigint 50))))
               else (Printf.printf "%s" "euler13 = ";
               begin
                 (print_bigint sum);
                 (Printf.printf "%s" "\n";
                 (Printf.printf "%s" "euler25 = ";
                 (Printf.printf "%d" (euler25 ());
                 (Printf.printf "%s" "\n";
                 (Printf.printf "%s" "euler16 = ";
                 (Printf.printf "%d" (euler16 ());
                 (Printf.printf "%s" "\n";
                 begin
                   (euler48 ());
                   (Printf.printf "%s" "euler20 = ";
                   (Printf.printf "%d" (euler20 ());
                   (Printf.printf "%s" "\n";
                   ((fun a ->
                        ((fun b ->
                             begin
                               (print_bigint a);
                               (Printf.printf "%s" ">>1=";
                               begin
                                 (print_bigint (bigint_shift a (- 1)));
                                 (Printf.printf "%s" "\n";
                                 begin
                                   (print_bigint a);
                                   (Printf.printf "%s" "*";
                                   begin
                                     (print_bigint b);
                                     (Printf.printf "%s" "=";
                                     begin
                                       (print_bigint (mul_bigint a b));
                                       (Printf.printf "%s" "\n";
                                       begin
                                         (print_bigint a);
                                         (Printf.printf "%s" "*";
                                         begin
                                           (print_bigint b);
                                           (Printf.printf "%s" "=";
                                           begin
                                             (print_bigint (mul_bigint_cp a b));
                                             (Printf.printf "%s" "\n";
                                             begin
                                               (print_bigint a);
                                               (Printf.printf "%s" "+";
                                               begin
                                                 (print_bigint b);
                                                 (Printf.printf "%s" "=";
                                                 begin
                                                   (print_bigint (add_bigint a b));
                                                   (Printf.printf "%s" "\n";
                                                   begin
                                                     (print_bigint b);
                                                     (Printf.printf "%s" "-";
                                                     begin
                                                       (print_bigint a);
                                                       (Printf.printf "%s" "=";
                                                       begin
                                                         (print_bigint (sub_bigint b a));
                                                         (Printf.printf "%s" "\n";
                                                         begin
                                                           (print_bigint a);
                                                           (Printf.printf "%s" "-";
                                                           begin
                                                             (print_bigint b);
                                                             (Printf.printf "%s" "=";
                                                             begin
                                                               (print_bigint (sub_bigint a b));
                                                               (Printf.printf "%s" "\n";
                                                               begin
                                                                 (print_bigint a);
                                                                 (Printf.printf "%s" ">";
                                                                 begin
                                                                   (print_bigint b);
                                                                   (Printf.printf "%s" "=";
                                                                   ((fun
                                                                    m ->
                                                                   ((fun
                                                                    ej ->
                                                                   (if m
                                                                    then (Printf.printf "%s" "True";
                                                                    (ej m b a sum))
                                                                    else (Printf.printf "%s" "False";
                                                                    (ej m b a sum)))) (fun
                                                                    m b a sum ->
                                                                   (Printf.printf "%s" "\n";
                                                                   ())))) (bigint_gt a b)))
                                                                   end
                                                                 )
                                                                 end
                                                               )
                                                               end
                                                             )
                                                             end
                                                           )
                                                           end
                                                         )
                                                         end
                                                       )
                                                       end
                                                     )
                                                     end
                                                   )
                                                   end
                                                 )
                                                 end
                                               )
                                               end
                                             )
                                             end
                                           )
                                           end
                                         )
                                         end
                                       )
                                       end
                                     )
                                     end
                                   )
                                   end
                                 )
                                 end
                               )
                               end
                             ) (bigint_of_int 9951263))) (bigint_of_int 999999)))))
                   end
                 )))))))
                 end
               )) in
              (ek el sum)) 2 100)) (read_bigint 50))));;

