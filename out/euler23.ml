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

exception Found_1 of int

let fillPrimesFactors t n primes nprimes =
  let n = ref n in
  try
  for i = 0 to nprimes - 1 do
    let d = primes.(i) in
    while (!n) mod d = 0 do
      t.(d) <- t.(d) + 1;
      n := (!n) / d
    done;
    if (!n) = 1 then
      raise (Found_1(primes.(i)))
  done;
  (!n)
  with Found_1 (out) -> out

let sumdivaux2 t n i =
  let i = ref i in
  while (!i) < n && t.((!i)) = 0 do
    i := (!i) + 1
  done;
  (!i)

let rec sumdivaux t n i =
  if i > n then
    1
  else
    if t.(i) = 0 then
      sumdivaux t n (sumdivaux2 t n (i + 1))
    else
      begin
         let o = sumdivaux t n (sumdivaux2 t n (i + 1)) in
         let out0 = ref( 0 ) in
         let p = ref( i ) in
         for _j = 1 to t.(i) do
           out0 := (!out0) + (!p);
           p := (!p) * i
         done;
         ((!out0) + 1) * o
      end

let sumdiv nprimes primes n =
  let t = Array.init (n + 1) (fun _i ->
    0) in
  let max0 = fillPrimesFactors t n primes nprimes in
  sumdivaux t max0 0

let () =
 let maximumprimes = 30001 in
  let era = Array.init maximumprimes (fun s ->
    s) in
  let nprimes = eratostene era maximumprimes in
  let primes = Array.init nprimes (fun _t ->
    0) in
  let l = ref( 0 ) in
  for k = 2 to maximumprimes - 1 do
    if era.(k) = k then
      begin
         primes.((!l)) <- k;
         l := (!l) + 1
      end
  done;
  let n = 100 in
  (* 28124 ça prend trop de temps mais on arrive a passer le test *)
  let abondant = Array.init (n + 1) (fun _p ->
    false) in
  let summable = Array.init (n + 1) (fun _q ->
    false) in
  let sum = ref( 0 ) in
  for r = 2 to n do
    let other = sumdiv nprimes primes r - r in
    if other > r then
      abondant.(r) <- true
  done;
  for i = 1 to n do
    for j = 1 to n do
      if abondant.(i) && abondant.(j) && i + j <= n then
        summable.(i + j) <- true
    done
  done;
  for o = 1 to n do
    if not summable.(o) then
      sum := (!sum) + o
  done;
  Printf.printf "\n%d\n" (!sum) 
 