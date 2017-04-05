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
  let chiffres = Array.init len (fun j -> Scanf.scanf "%c"
  (fun c -> (int_of_char (c)))) in
  let e = (len - 1) / 2 in
  let rec f i =
    if i <= e
    then let tmp = chiffres.(i) in
    ( chiffres.(i) <- chiffres.(len - 1 - i);
      chiffres.(len - 1 - i) <- tmp;
      f (i + 1))
    else {bigint_sign=true;
          bigint_len=len;
          bigint_chiffres=chiffres} in
    f 0

let print_bigint a =
  ( if not a.bigint_sign
    then Printf.printf "%c" '-'
    else ();
    let g = a.bigint_len - 1 in
    let rec h i =
      if i <= g
      then ( Printf.printf "%d" a.bigint_chiffres.(a.bigint_len - 1 - i);
             h (i + 1))
      else () in
      h 0)

let bigint_eq a b =
  (*  Renvoie vrai si a = b  *)
  if a.bigint_sign <> b.bigint_sign
  then false
  else if a.bigint_len <> b.bigint_len
       then false
       else let m = a.bigint_len - 1 in
       let rec o i =
         if i <= m
         then if a.bigint_chiffres.(i) <> b.bigint_chiffres.(i)
              then false
              else o (i + 1)
         else true in
         o 0

let bigint_gt a b =
  (*  Renvoie vrai si a > b  *)
  if a.bigint_sign && not b.bigint_sign
  then true
  else if not a.bigint_sign && b.bigint_sign
       then false
       else if a.bigint_len > b.bigint_len
            then a.bigint_sign
            else if a.bigint_len < b.bigint_len
                 then not a.bigint_sign
                 else let p = a.bigint_len - 1 in
                 let rec q i =
                   if i <= p
                   then let j = a.bigint_len - 1 - i in
                   if a.bigint_chiffres.(j) > b.bigint_chiffres.(j)
                   then a.bigint_sign
                   else if a.bigint_chiffres.(j) < b.bigint_chiffres.(j)
                        then not a.bigint_sign
                        else q (i + 1)
                   else true in
                   q 0

let bigint_lt a b =
  not (bigint_gt a b)

let add_bigint_positif a b =
  (*  Une addition ou on en a rien a faire des signes  *)
  let len = (max (a.bigint_len) (b.bigint_len)) + 1 in
  let retenue = 0 in
  (fun (retenue, chiffres) ->let rec s len =
                               if len > 0 && chiffres.(len - 1) = 0
                               then let len = len - 1 in
                               s len
                               else {bigint_sign=true;
                                     bigint_len=len;
                                     bigint_chiffres=chiffres} in
                               s len) (Array.init_withenv len (fun i retenue -> let tmp = retenue in
  let tmp = if i < a.bigint_len
            then tmp + a.bigint_chiffres.(i)
            else tmp in
  let tmp = if i < b.bigint_len
            then tmp + b.bigint_chiffres.(i)
            else tmp in
  let retenue = tmp / 10 in
  let r = tmp mod 10 in
  retenue, r) retenue)

let sub_bigint_positif a b =
  (*  Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
 *)
  let len = a.bigint_len in
  let retenue = 0 in
  (fun (retenue, chiffres) ->let rec v len =
                               if len > 0 && chiffres.(len - 1) = 0
                               then let len = len - 1 in
                               v len
                               else {bigint_sign=true;
                                     bigint_len=len;
                                     bigint_chiffres=chiffres} in
                               v len) (Array.init_withenv len (fun i retenue -> let tmp = retenue + a.bigint_chiffres.(i) in
  let tmp = if i < b.bigint_len
            then tmp - b.bigint_chiffres.(i)
            else tmp in
  (fun (retenue, tmp) ->let u = tmp in
                        retenue, u) (if tmp < 0
                                     then let tmp = tmp + 10 in
                                     let retenue = - 1 in
                                     retenue, tmp
                                     else let retenue = 0 in
                                     retenue, tmp)) retenue)

let neg_bigint a =
  {bigint_sign=not a.bigint_sign;
   bigint_len=a.bigint_len;
   bigint_chiffres=a.bigint_chiffres}

let add_bigint a b =
  if a.bigint_sign = b.bigint_sign
  then if a.bigint_sign
       then add_bigint_positif a b
       else neg_bigint (add_bigint_positif a b)
  else if a.bigint_sign
       then (*  a positif, b negatif  *)
       if bigint_gt a (neg_bigint b)
       then sub_bigint_positif a b
       else neg_bigint (sub_bigint_positif b a)
       else (*  a negatif, b positif  *)
       if bigint_gt (neg_bigint a) b
       then neg_bigint (sub_bigint_positif a b)
       else sub_bigint_positif b a

let sub_bigint a b =
  add_bigint a (neg_bigint b)

let mul_bigint_cp a b =
  (*  Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction.  *)
  let len = a.bigint_len + b.bigint_len + 1 in
  let chiffres = Array.init len (fun k -> 0) in
  let w = a.bigint_len - 1 in
  let rec x i =
    if i <= w
    then let retenue = 0 in
    let z = b.bigint_len - 1 in
    let rec ba j retenue =
      if j <= z
      then ( chiffres.(i + j) <- chiffres.(i + j) + retenue + b.bigint_chiffres.(j) * a.bigint_chiffres.(i);
             let retenue = chiffres.(i + j) / 10 in
             ( chiffres.(i + j) <- chiffres.(i + j) mod 10;
               ba (j + 1) retenue))
      else ( chiffres.(i + b.bigint_len) <- chiffres.(i + b.bigint_len) + retenue;
             x (i + 1)) in
      ba 0 retenue
    else ( chiffres.(a.bigint_len + b.bigint_len) <- chiffres.(a.bigint_len + b.bigint_len - 1) / 10;
           chiffres.(a.bigint_len + b.bigint_len - 1) <- chiffres.(a.bigint_len + b.bigint_len - 1) mod 10;
           let rec y l len =
             if l <= 2
             then if len <> 0 && chiffres.(len - 1) = 0
                  then let len = len - 1 in
                  y (l + 1) len
                  else y (l + 1) len
             else {bigint_sign=a.bigint_sign = b.bigint_sign;
                   bigint_len=len;
                   bigint_chiffres=chiffres} in
             y 0 len) in
    x 0

let bigint_premiers_chiffres a i =
  let len = (min (i) (a.bigint_len)) in
  let rec bc len =
    if len <> 0 && a.bigint_chiffres.(len - 1) = 0
    then let len = len - 1 in
    bc len
    else {bigint_sign=a.bigint_sign;
          bigint_len=len;
          bigint_chiffres=a.bigint_chiffres} in
    bc len

let bigint_shift a i =
  let chiffres = Array.init (a.bigint_len + i) (fun k -> if k >= i
                                                         then a.bigint_chiffres.(k - i)
                                                         else 0) in
  {bigint_sign=a.bigint_sign;
   bigint_len=a.bigint_len + i;
   bigint_chiffres=chiffres}

let rec mul_bigint aa bb =
  if aa.bigint_len = 0
  then aa
  else if bb.bigint_len = 0
       then bb
       else if aa.bigint_len < 3 || bb.bigint_len < 3
            then mul_bigint_cp aa bb
            else (*  Algorithme de Karatsuba  *)
            let split = (min (aa.bigint_len) (bb.bigint_len)) / 2 in
            let a = bigint_shift aa (- split) in
            let b = bigint_premiers_chiffres aa split in
            let c = bigint_shift bb (- split) in
            let d = bigint_premiers_chiffres bb split in
            let amoinsb = sub_bigint a b in
            let cmoinsd = sub_bigint c d in
            let ac = mul_bigint a c in
            let bd = mul_bigint b d in
            let amoinsbcmoinsd = mul_bigint amoinsb cmoinsd in
            let acdec = bigint_shift ac (2 * split) in
            add_bigint (add_bigint acdec bd) (bigint_shift (sub_bigint (add_bigint ac bd) amoinsbcmoinsd) split)

let log10 a =
  let out0 = 1 in
  let rec be a out0 =
    if a >= 10
    then let a = a / 10 in
    let out0 = out0 + 1 in
    be a out0
    else out0 in
    be a out0

let bigint_of_int i =
  let size = log10 i in
  let size = if i = 0
             then 0
             else size in
  let t = Array.init size (fun j -> 0) in
  let rec bf k i =
    if k <= size - 1
    then ( t.(k) <- i mod 10;
           let i = i / 10 in
           bf (k + 1) i)
    else {bigint_sign=true;
          bigint_len=size;
          bigint_chiffres=t} in
    bf 0 i

let fact_bigint a =
  let one = bigint_of_int 1 in
  let out0 = one in
  let rec bg a out0 =
    if not (bigint_eq a one)
    then let out0 = mul_bigint a out0 in
    let a = sub_bigint a one in
    bg a out0
    else out0 in
    bg a out0

let sum_chiffres_bigint a =
  let out0 = 0 in
  let bh = a.bigint_len - 1 in
  let rec bi i out0 =
    if i <= bh
    then let out0 = out0 + a.bigint_chiffres.(i) in
    bi (i + 1) out0
    else out0 in
    bi 0 out0

let euler20 () =
  let a = bigint_of_int 15 in
  (*  normalement c'est 100  *)
  let a = fact_bigint a in
  sum_chiffres_bigint a

let rec bigint_exp a b =
  if b = 1
  then a
  else if b mod 2 = 0
       then bigint_exp (mul_bigint a a) (b / 2)
       else mul_bigint a (bigint_exp a (b - 1))

let rec bigint_exp_10chiffres a b =
  let a = bigint_premiers_chiffres a 10 in
  if b = 1
  then a
  else if b mod 2 = 0
       then bigint_exp_10chiffres (mul_bigint a a) (b / 2)
       else mul_bigint a (bigint_exp_10chiffres a (b - 1))

let euler48 () =
  let sum = bigint_of_int 0 in
  let rec bj i sum =
    if i <= 100
    then (*  1000 normalement  *)
    let ib = bigint_of_int i in
    let ibeib = bigint_exp_10chiffres ib i in
    let sum = add_bigint sum ibeib in
    let sum = bigint_premiers_chiffres sum 10 in
    bj (i + 1) sum
    else ( Printf.printf "%s" "euler 48 = ";
           print_bigint sum;
           Printf.printf "%s" "\n") in
    bj 1 sum

let euler16 () =
  let a = bigint_of_int 2 in
  let a = bigint_exp a 100 in
  (*  1000 normalement  *)
  sum_chiffres_bigint a

let euler25 () =
  let i = 2 in
  let a = bigint_of_int 1 in
  let b = bigint_of_int 1 in
  let rec bk a b i =
    if b.bigint_len < 100
    then (*  1000 normalement  *)
    let c = add_bigint a b in
    let a = b in
    let b = c in
    let i = i + 1 in
    bk a b i
    else i in
    bk a b i

let euler29 () =
  let maxA = 5 in
  let maxB = 5 in
  let a_bigint = Array.init (maxA + 1) (fun j -> bigint_of_int (j * j)) in
  let a0_bigint = Array.init (maxA + 1) (fun j2 -> bigint_of_int j2) in
  let b = Array.init (maxA + 1) (fun k -> 2) in
  let n = 0 in
  let found = true in
  let rec bl found n =
    if found
    then let min0 = a0_bigint.(0) in
    let found = false in
    let rec bm i found min0 =
      if i <= maxA
      then if b.(i) <= maxB
           then if found
                then if bigint_lt a_bigint.(i) min0
                     then let min0 = a_bigint.(i) in
                     bm (i + 1) found min0
                     else bm (i + 1) found min0
                else let min0 = a_bigint.(i) in
                let found = true in
                bm (i + 1) found min0
           else bm (i + 1) found min0
      else if found
           then let n = n + 1 in
           let rec bn l =
             if l <= maxA
             then if bigint_eq a_bigint.(l) min0 && b.(l) <= maxB
                  then ( b.(l) <- b.(l) + 1;
                         a_bigint.(l) <- mul_bigint a_bigint.(l) a0_bigint.(l);
                         bn (l + 1))
                  else bn (l + 1)
             else bl found n in
             bn 2
           else bl found n in
      bm 2 found min0
    else n in
    bl found n

let main =
  ( Printf.printf "%d\n" (euler29 ());
    let sum = read_bigint 50 in
    let rec bo i sum =
      if i <= 100
      then ( Scanf.scanf "%[\n \010]" (fun _ -> ());
             let tmp = read_bigint 50 in
             let sum = add_bigint sum tmp in
             bo (i + 1) sum)
      else ( Printf.printf "%s" "euler13 = ";
             print_bigint sum;
             Printf.printf "\neuler25 = %d\neuler16 = %d\n" (euler25 ()) (euler16 ());
             euler48 ();
             Printf.printf "euler20 = %d\n" (euler20 ());
             let a = bigint_of_int 999999 in
             let b = bigint_of_int 9951263 in
             ( print_bigint a;
               Printf.printf "%s" ">>1=";
               print_bigint (bigint_shift a (- 1));
               Printf.printf "%s" "\n";
               print_bigint a;
               Printf.printf "%s" "*";
               print_bigint b;
               Printf.printf "%s" "=";
               print_bigint (mul_bigint a b);
               Printf.printf "%s" "\n";
               print_bigint a;
               Printf.printf "%s" "*";
               print_bigint b;
               Printf.printf "%s" "=";
               print_bigint (mul_bigint_cp a b);
               Printf.printf "%s" "\n";
               print_bigint a;
               Printf.printf "%s" "+";
               print_bigint b;
               Printf.printf "%s" "=";
               print_bigint (add_bigint a b);
               Printf.printf "%s" "\n";
               print_bigint b;
               Printf.printf "%s" "-";
               print_bigint a;
               Printf.printf "%s" "=";
               print_bigint (sub_bigint b a);
               Printf.printf "%s" "\n";
               print_bigint a;
               Printf.printf "%s" "-";
               print_bigint b;
               Printf.printf "%s" "=";
               print_bigint (sub_bigint a b);
               Printf.printf "%s" "\n";
               print_bigint a;
               Printf.printf "%s" ">";
               print_bigint b;
               Printf.printf "%s" "=";
               if bigint_gt a b
               then Printf.printf "%s" "True"
               else Printf.printf "%s" "False";
               Printf.printf "%s" "\n")) in
      bo 2 sum)

