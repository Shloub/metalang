
let rec max2 a b =
  if a > b then
    a
  else
    b

type bigint_nat = {
  mutable bigint_nat_len : int;
  mutable bigint_nat_chiffres : int array;
};;

let rec read_bigint_nat () =
  let len = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let chiffres = Array.init len (fun _d ->
    let c = Scanf.scanf "%c" (fun x -> x) in
    int_of_char (c) - int_of_char ('0')) in
  for i = 0 to (len - 1) / 2 do
    let tmp = chiffres.(i) in
    chiffres.(i) <- chiffres.(len - 1 - i);
    chiffres.(len - 1 - i) <- tmp
  done;
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let out_ = {
    bigint_nat_len=len;
    bigint_nat_chiffres=chiffres;
  } in
  out_

let rec print_bigint_nat a =
  for i = 0 to a.bigint_nat_len - 1 do
    let e = a.bigint_nat_chiffres.(a.bigint_nat_len - 1 - i) in
    Printf.printf "%d" e
  done

let rec add_bigint_nat a b =
  let len = ref( max2 a.bigint_nat_len b.bigint_nat_len + 1 ) in
  let retenue = ref( 0 ) in
  let chiffres = Array.init (!len) (fun i ->
    let tmp = ref( (!retenue) ) in
    if i < a.bigint_nat_len then
      tmp := (!tmp) + a.bigint_nat_chiffres.(i);
    if i < b.bigint_nat_len then
      tmp := (!tmp) + b.bigint_nat_chiffres.(i);
    retenue := (!tmp) / 10;
    (!tmp) mod 10) in
  if chiffres.((!len) - 1) = 0 then
    len := (!len) - 1;
  let out_ = {
    bigint_nat_len=(!len);
    bigint_nat_chiffres=chiffres;
  } in
  out_

let rec mul_bigint_nat a b =
  let len = ref( a.bigint_nat_len + b.bigint_nat_len + 1 ) in
  let chiffres = Array.init (!len) (fun _k ->
    0) in
  for i = 0 to a.bigint_nat_len - 1 do
    let retenue = ref( 0 ) in
    for j = 0 to b.bigint_nat_len - 1 do
      chiffres.(i + j) <- chiffres.(i + j) + (!retenue) + b.bigint_nat_chiffres.(j) * a.bigint_nat_chiffres.(i);
      retenue := chiffres.(i + j) / 10;
      chiffres.(i + j) <- chiffres.(i + j) mod 10
    done;
    chiffres.(i + b.bigint_nat_len) <- chiffres.(i + b.bigint_nat_len) + (!retenue)
  done;
  chiffres.(a.bigint_nat_len + b.bigint_nat_len) <- chiffres.(a.bigint_nat_len + b.bigint_nat_len - 1) / 10;
  chiffres.(a.bigint_nat_len + b.bigint_nat_len - 1) <- chiffres.(a.bigint_nat_len + b.bigint_nat_len - 1) mod 10;
  for _l = 0 to 2 do
    if chiffres.((!len) - 1) = 0 then
      len := (!len) - 1
  done;
  let out_ = {
    bigint_nat_len=(!len);
    bigint_nat_chiffres=chiffres;
  } in
  out_

(*
def @bigint exp_bigint(@bigint_nat a, @bigint_nat b)

end
*)
let () =
begin
  let a = (read_bigint_nat ()) in
  let b = (read_bigint_nat ()) in
  print_bigint_nat a;
  Printf.printf "*";
  print_bigint_nat b;
  Printf.printf "=";
  print_bigint_nat (mul_bigint_nat a b);
  Printf.printf "\n"
end
 