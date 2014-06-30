let max2 a b =
  if a > b then
    a
  else
    b

let eratostene t max_ =
  let n = ref( 0 ) in
  for i = 2 to max_ - 1 do
    if t.(i) = i then
      begin
        let j = ref( i * i ) in
        n := (!n) + 1;
        while (!j) < max_ && (!j) > 0
        do
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
    while ((!n) mod d) = 0
    do
        t.(d) <- t.(d) + 1;
        n := (!n) / d
    done;
    if (!n) = 1 then
      raise (Found_1(primes.(i)))
  done;
  raise (Found_1((!n)))
  with Found_1 (out) -> out

exception Found_2 of int

let find ndiv2 =
  try
  let maximumprimes = 10000 in
  let era = Array.init maximumprimes (fun j ->
    j) in
  let nprimes = eratostene era maximumprimes in
  let primes = Array.init nprimes (fun _o ->
    0) in
  let l = ref( 0 ) in
  for k = 2 to maximumprimes - 1 do
    if era.(k) = k then
      begin
        primes.((!l)) <- k;
        l := (!l) + 1
      end
  done;
  for n = 1 to 1000000 do
    let c = n + 2 in
    let primesFactors = Array.init c (fun _m ->
      0) in
    let max_ = max2 (fillPrimesFactors primesFactors n primes nprimes) (fillPrimesFactors primesFactors (n + 1) primes nprimes) in
    primesFactors.(2) <- primesFactors.(2) - 1;
    let ndivs = ref( 1 ) in
    for i = 0 to max_ do
      if primesFactors.(i) <> 0 then
        ndivs := (!ndivs) * (1 + primesFactors.(i))
    done;
    if (!ndivs) > ndiv2 then
      raise (Found_2((n * (n + 1)) / 2))
    (* print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" *)
  done;
  raise (Found_2(0))
  with Found_2 (out) -> out

let () =
begin
  let e = find 500 in
  Printf.printf "%d\n" e
end
 