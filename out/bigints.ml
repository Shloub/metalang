type bigint = {
  mutable bigint_sign : bool;
  mutable bigint_len : int;
  mutable bigint_chiffres : int array;
};;

let read_bigint len =
  let chiffres = Array.init len (fun _j ->
    let c = Scanf.scanf "%c" (fun v_0 -> v_0) in
    int_of_char (c)) in
  for i = 0 to (len - 1) / 2 do
    let tmp = chiffres.(i) in
    chiffres.(i) <- chiffres.(len - 1 - i);
    chiffres.(len - 1 - i) <- tmp
  done;
  {
    bigint_sign=true;
    bigint_len=len;
    bigint_chiffres=chiffres;
  }

let print_bigint a =
  if not a.bigint_sign then
    Printf.printf "%c" '-';
  for i = 0 to a.bigint_len - 1 do
    Printf.printf "%d" a.bigint_chiffres.(a.bigint_len - 1 - i)
  done

exception Found_1 of bool

let bigint_eq a b =
  try
  (* Renvoie vrai si a = b *)
  if a.bigint_sign <> b.bigint_sign then
    raise (Found_1(false))
  else if a.bigint_len <> b.bigint_len then
    raise (Found_1(false))
  else
    begin
      for i = 0 to a.bigint_len - 1 do
        if a.bigint_chiffres.(i) <> b.bigint_chiffres.(i) then
          raise (Found_1(false))
      done;
      raise (Found_1(true))
    end
  with Found_1 (out) -> out

exception Found_2 of bool

let bigint_gt a b =
  try
  (* Renvoie vrai si a > b *)
  if a.bigint_sign && not b.bigint_sign then
    raise (Found_2(true))
  else if not a.bigint_sign && b.bigint_sign then
    raise (Found_2(false))
  else
    begin
      if a.bigint_len > b.bigint_len then
        raise (Found_2(a.bigint_sign))
      else if a.bigint_len < b.bigint_len then
        raise (Found_2(not a.bigint_sign))
      else
        for i = 0 to a.bigint_len - 1 do
          let j = a.bigint_len - 1 - i in
          if a.bigint_chiffres.(j) > b.bigint_chiffres.(j) then
            raise (Found_2(a.bigint_sign))
          else if a.bigint_chiffres.(j) < b.bigint_chiffres.(j) then
            raise (Found_2(not a.bigint_sign))
        done;
      raise (Found_2(true))
    end
  with Found_2 (out) -> out

let bigint_lt a b =
  not (bigint_gt a b)

let add_bigint_positif a b =
  (* Une addition ou on en a rien a faire des signes *)
  let len = ref( (max (a.bigint_len) (b.bigint_len)) + 1 ) in
  let retenue = ref( 0 ) in
  let chiffres = Array.init (!len) (fun i ->
    let tmp = ref( (!retenue) ) in
    if i < a.bigint_len then
      tmp := (!tmp) + a.bigint_chiffres.(i);
    if i < b.bigint_len then
      tmp := (!tmp) + b.bigint_chiffres.(i);
    retenue := (!tmp) / 10;
    (!tmp) mod 10) in
  while (!len) > 0 && chiffres.((!len) - 1) = 0
  do
      len := (!len) - 1
  done;
  {
    bigint_sign=true;
    bigint_len=(!len);
    bigint_chiffres=chiffres;
  }

let sub_bigint_positif a b =
  (* Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
*)
  let len = ref( a.bigint_len ) in
  let retenue = ref( 0 ) in
  let chiffres = Array.init (!len) (fun i ->
    let tmp = ref( (!retenue) + a.bigint_chiffres.(i) ) in
    if i < b.bigint_len then
      tmp := (!tmp) - b.bigint_chiffres.(i);
    if (!tmp) < 0 then
      begin
        tmp := (!tmp) + 10;
        retenue := -1
      end
    else
      retenue := 0;
    (!tmp)) in
  while (!len) > 0 && chiffres.((!len) - 1) = 0
  do
      len := (!len) - 1
  done;
  {
    bigint_sign=true;
    bigint_len=(!len);
    bigint_chiffres=chiffres;
  }

let neg_bigint a =
  {
    bigint_sign=not a.bigint_sign;
    bigint_len=a.bigint_len;
    bigint_chiffres=a.bigint_chiffres;
  }

let add_bigint a b =
  if a.bigint_sign = b.bigint_sign then
    begin
      if a.bigint_sign then
        add_bigint_positif a b
      else
        neg_bigint (add_bigint_positif a b)
    end
  else if a.bigint_sign then
    begin
      (* a positif, b negatif *)
      if bigint_gt a (neg_bigint b) then
        sub_bigint_positif a b
      else
        neg_bigint (sub_bigint_positif b a)
    end
  else
    begin
      (* a negatif, b positif *)
      if bigint_gt (neg_bigint a) b then
        neg_bigint (sub_bigint_positif a b)
      else
        sub_bigint_positif b a
    end

let sub_bigint a b =
  add_bigint a (neg_bigint b)

let mul_bigint_cp a b =
  (* Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. *)
  let len = ref( a.bigint_len + b.bigint_len + 1 ) in
  let chiffres = Array.init (!len) (fun _k ->
    0) in
  for i = 0 to a.bigint_len - 1 do
    let retenue = ref( 0 ) in
    for j = 0 to b.bigint_len - 1 do
      chiffres.(i + j) <- chiffres.(i + j) + (!retenue) + b.bigint_chiffres.(j) * a.bigint_chiffres.(i);
      retenue := chiffres.(i + j) / 10;
      chiffres.(i + j) <- chiffres.(i + j) mod 10
    done;
    chiffres.(i + b.bigint_len) <- chiffres.(i + b.bigint_len) + (!retenue)
  done;
  chiffres.(a.bigint_len + b.bigint_len) <- chiffres.(a.bigint_len + b.bigint_len - 1) / 10;
  chiffres.(a.bigint_len + b.bigint_len - 1) <- chiffres.(a.bigint_len + b.bigint_len - 1) mod 10;
  for _l = 0 to 2 do
    if (!len) <> 0 && chiffres.((!len) - 1) = 0 then
      len := (!len) - 1
  done;
  {
    bigint_sign=a.bigint_sign = b.bigint_sign;
    bigint_len=(!len);
    bigint_chiffres=chiffres;
  }

let bigint_premiers_chiffres a i =
  let len = ref( (min (i) (a.bigint_len)) ) in
  while (!len) <> 0 && a.bigint_chiffres.((!len) - 1) = 0
  do
      len := (!len) - 1
  done;
  {
    bigint_sign=a.bigint_sign;
    bigint_len=(!len);
    bigint_chiffres=a.bigint_chiffres;
  }

let bigint_shift a i =
  let chiffres = Array.init (a.bigint_len + i) (fun k ->
    if k >= i then
      a.bigint_chiffres.(k - i)
    else
      0) in
  {
    bigint_sign=a.bigint_sign;
    bigint_len=a.bigint_len + i;
    bigint_chiffres=chiffres;
  }

let rec mul_bigint aa bb =
  if aa.bigint_len = 0 then
    aa
  else if bb.bigint_len = 0 then
    bb
  else if aa.bigint_len < 3 or bb.bigint_len < 3 then
    mul_bigint_cp aa bb
  else
    begin
      (* Algorithme de Karatsuba *)
      let split = (min (aa.bigint_len) (bb.bigint_len)) / 2 in
      let a = bigint_shift aa (-split) in
      let b = bigint_premiers_chiffres aa split in
      let c = bigint_shift bb (-split) in
      let d = bigint_premiers_chiffres bb split in
      let amoinsb = sub_bigint a b in
      let cmoinsd = sub_bigint c d in
      let ac = mul_bigint a c in
      let bd = mul_bigint b d in
      let amoinsbcmoinsd = mul_bigint amoinsb cmoinsd in
      let acdec = bigint_shift ac (2 * split) in
      add_bigint (add_bigint acdec bd) (bigint_shift (sub_bigint (add_bigint ac bd) amoinsbcmoinsd) split)
      (* ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd *)
    end

(*
Division,
Modulo
*)
let log10 a =
  let a = ref a in
  let out0 = ref( 1 ) in
  while (!a) >= 10
  do
      a := (!a) / 10;
      out0 := (!out0) + 1
  done;
  (!out0)

let bigint_of_int i =
  let i = ref i in
  let size = ref( log10 (!i) ) in
  if (!i) = 0 then
    size := 0;
  let t = Array.init (!size) (fun _j ->
    0) in
  for k = 0 to (!size) - 1 do
    t.(k) <- (!i) mod 10;
    i := (!i) / 10
  done;
  {
    bigint_sign=true;
    bigint_len=(!size);
    bigint_chiffres=t;
  }

let fact_bigint a =
  let a = ref a in
  let one = bigint_of_int 1 in
  let out0 = ref( one ) in
  while not (bigint_eq (!a) one)
  do
      out0 := mul_bigint (!a) (!out0);
      a := sub_bigint (!a) one
  done;
  (!out0)

let sum_chiffres_bigint a =
  let out0 = ref( 0 ) in
  for i = 0 to a.bigint_len - 1 do
    out0 := (!out0) + a.bigint_chiffres.(i)
  done;
  (!out0)

(* http://projecteuler.net/problem=20 *)
let euler20 () =
  let a = ref( bigint_of_int 15 ) in
  (* normalement c'est 100 *)
  a := fact_bigint (!a);
  sum_chiffres_bigint (!a)

let rec bigint_exp a b =
  if b = 1 then
    a
  else if (b mod 2) = 0 then
    bigint_exp (mul_bigint a a) (b / 2)
  else
    mul_bigint a (bigint_exp a (b - 1))

let rec bigint_exp_10chiffres a b =
  let a = ref a in
  a := bigint_premiers_chiffres (!a) 10;
  if b = 1 then
    (!a)
  else if (b mod 2) = 0 then
    bigint_exp_10chiffres (mul_bigint (!a) (!a)) (b / 2)
  else
    mul_bigint (!a) (bigint_exp_10chiffres (!a) (b - 1))

let euler48 () =
  let sum = ref( bigint_of_int 0 ) in
  for i = 1 to 100 do
    (* 1000 normalement *)
    let ib = bigint_of_int i in
    let ibeib = bigint_exp_10chiffres ib i in
    sum := add_bigint (!sum) ibeib;
    sum := bigint_premiers_chiffres (!sum) 10
  done;
  Printf.printf "euler 48 = ";
  print_bigint (!sum);
  Printf.printf "\n"

let euler16 () =
  let a = ref( bigint_of_int 2 ) in
  a := bigint_exp (!a) 100;
  (* 1000 normalement *)
  sum_chiffres_bigint (!a)

let euler25 () =
  let i = ref( 2 ) in
  let a = ref( bigint_of_int 1 ) in
  let b = ref( bigint_of_int 1 ) in
  while (!b).bigint_len < 100
  do
      (* 1000 normalement *)
      let c = add_bigint (!a) (!b) in
      a := (!b);
      b := c;
      i := (!i) + 1
  done;
  (!i)

let euler29 () =
  let maxA = 5 in
  let maxB = 5 in
  let a_bigint = Array.init (maxA + 1) (fun j ->
    bigint_of_int (j * j)) in
  let a0_bigint = Array.init (maxA + 1) (fun j2 ->
    bigint_of_int j2) in
  let b = Array.init (maxA + 1) (fun _k ->
    2) in
  let n = ref( 0 ) in
  let found = ref( true ) in
  while (!found)
  do
      let min0 = ref( a0_bigint.(0) ) in
      found := false;
      for i = 2 to maxA do
        if b.(i) <= maxB then
          begin
            if (!found) then
              begin
                if bigint_lt a_bigint.(i) (!min0) then
                  min0 := a_bigint.(i)
              end
            else
              begin
                min0 := a_bigint.(i);
                found := true
              end
          end
      done;
      if (!found) then
        begin
          n := (!n) + 1;
          for l = 2 to maxA do
            if bigint_eq a_bigint.(l) (!min0) && b.(l) <= maxB then
              begin
                b.(l) <- b.(l) + 1;
                a_bigint.(l) <- mul_bigint a_bigint.(l) a0_bigint.(l)
              end
          done
        end
  done;
  (!n)

let () =
begin
  Printf.printf "%d\n" ((euler29 ()));
  let sum = ref( read_bigint 50 ) in
  for _i = 2 to 100 do
    Scanf.scanf " " (fun () -> ());
    let tmp = read_bigint 50 in
    sum := add_bigint (!sum) tmp
  done;
  Printf.printf "euler13 = ";
  print_bigint (!sum);
  Printf.printf "\neuler25 = %d\neuler16 = %d\n" ((euler25 ())) ((euler16 ()));
  (euler48 ());
  Printf.printf "euler20 = %d\n" ((euler20 ()));
  let a = bigint_of_int 999999 in
  let b = bigint_of_int 9951263 in
  print_bigint a;
  Printf.printf ">>1=";
  print_bigint (bigint_shift a (-1));
  Printf.printf "\n";
  print_bigint a;
  Printf.printf "*";
  print_bigint b;
  Printf.printf "=";
  print_bigint (mul_bigint a b);
  Printf.printf "\n";
  print_bigint a;
  Printf.printf "*";
  print_bigint b;
  Printf.printf "=";
  print_bigint (mul_bigint_cp a b);
  Printf.printf "\n";
  print_bigint a;
  Printf.printf "+";
  print_bigint b;
  Printf.printf "=";
  print_bigint (add_bigint a b);
  Printf.printf "\n";
  print_bigint b;
  Printf.printf "-";
  print_bigint a;
  Printf.printf "=";
  print_bigint (sub_bigint b a);
  Printf.printf "\n";
  print_bigint a;
  Printf.printf "-";
  print_bigint b;
  Printf.printf "=";
  print_bigint (sub_bigint a b);
  Printf.printf "\n";
  print_bigint a;
  Printf.printf ">";
  print_bigint b;
  Printf.printf "=";
  let m = bigint_gt a b in
  if m then
    Printf.printf "True"
  else
    Printf.printf "False";
  Printf.printf "\n"
end
 