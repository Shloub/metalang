let eratostene t max0 =
  let n = ref( 0 ) in
  for i = 2 to max0 - 1 do
    if t.(i) = i then
      begin
         n := (!n) + 1;
         let j = ref( i * i ) in
         while (!j) < max0 && (!j) > 0 do
           t.((!j)) <- 0;
           j := (!j) + i
         done
      end
  done;
  (!n)

exception Found_1 of bool

let isPrime n primes _len =
  let n = ref n in
  try
  let i = ref( 0 ) in
  if (!n) < 0 then
    n := - (!n);
  while primes.((!i)) * primes.((!i)) < (!n) do
    if (!n) mod primes.((!i)) = 0 then
      raise (Found_1(false));
    i := (!i) + 1
  done;
  true
  with Found_1 (out) -> out

exception Found_2 of int

let test a b primes len =
  try
  for n = 0 to 200 do
    let j = n * n + a * n + b in
    if not (isPrime j primes len) then
      raise (Found_2(n))
  done;
  200
  with Found_2 (out) -> out

let () =
 let maximumprimes = 1000 in
  let era = Array.init maximumprimes (fun j ->
    j) in
  let result = ref( 0 ) in
  let max0 = ref( 0 ) in
  let nprimes = eratostene era maximumprimes in
  let primes = Array.init nprimes (fun o ->
    0) in
  let l = ref( 0 ) in
  for k = 2 to maximumprimes - 1 do
    if era.(k) = k then
      begin
         primes.((!l)) <- k;
         l := (!l) + 1
      end
  done;
  Printf.printf "%d == %d\n" (!l) nprimes;
  let ma = ref( 0 ) in
  let mb = ref( 0 ) in
  for b = 3 to 999 do
    if era.(b) = b then
      for a = - 999 to 999 do
        let n1 = test a b primes nprimes in
        let n2 = test a (- b) primes nprimes in
        if n1 > (!max0) then
          begin
             max0 := n1;
             result := a * b;
             ma := a;
             mb := b
          end;
        if n2 > (!max0) then
          begin
             max0 := n2;
             result := - a * b;
             ma := a;
             mb := - b
          end
      done
  done;
  Printf.printf "%d %d\n%d\n%d\n" (!ma) (!mb) (!max0) (!result) 
 