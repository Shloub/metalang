let eratostene t max_ =
  let n = ref( 0 ) in
  for i = 2 to max_ - 1 do
    if t.(i) = i then
      begin
        n := (!n) + 1;
        let j = ref( i * i ) in
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

let sumdivaux2 t n i =
  let i = ref i in
  while (!i) < n && t.((!i)) = 0
  do
      i := (!i) + 1
  done;
  (!i)

let rec sumdivaux t n i =
  if i > n then
    1
  else if t.(i) = 0 then
    sumdivaux t n (sumdivaux2 t n (i + 1))
  else
    begin
      let o = sumdivaux t n (sumdivaux2 t n (i + 1)) in
      let out_ = ref( 0 ) in
      let p = ref( i ) in
      for _j = 1 to t.(i) do
        out_ := (!out_) + (!p);
        p := (!p) * i
      done;
      ((!out_) + 1) * o
    end

let sumdiv nprimes primes n =
  let a = n + 1 in
  let t = Array.init a (fun _i ->
    0) in
  let max_ = fillPrimesFactors t n primes nprimes in
  sumdivaux t max_ 0

let () =
begin
  let maximumprimes = 1001 in
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
  Printf.printf "%d == %d\n" (!l) nprimes;
  let sum = ref( 0 ) in
  for n = 2 to 1000 do
    let other = sumdiv nprimes primes n - n in
    if other > n then
      begin
        let othersum = sumdiv nprimes primes other - other in
        if othersum = n then
          begin
            Printf.printf "%d & %d\n" other n;
            sum := (!sum) + other + n
          end
      end
  done;
  Printf.printf "\n%d\n" (!sum)
end
 