let eratostene t max_ =
  let n = ref( 0 ) in
  for i = 2 to max_ - 1 do
    if t.(i) = i then
      begin
        n := (!n) + 1;
        let j = ref( i * i ) in
        if (!j) / i = i then
          begin
            (* overflow test *)
            while (!j) < max_ && (!j) > 0
            do
                t.((!j)) <- 0;
                j := (!j) + i
            done
          end
      end
  done;
  (!n)

let () =
begin
  let maximumprimes = 6000 in
  let era = Array.init maximumprimes (fun j_ ->
    j_) in
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
  let canbe = Array.init maximumprimes (fun _i_ ->
    false) in
  for i = 0 to nprimes - 1 do
    for j = 0 to maximumprimes - 1 do
      let n = primes.(i) + 2 * j * j in
      if n < maximumprimes then
        canbe.(n) <- true
    done
  done;
  for m = 1 to maximumprimes do
    let m2 = m * 2 + 1 in
    if m2 < maximumprimes && not canbe.(m2) then
      begin
        Printf.printf "%d\n" m2
      end
  done
end
 