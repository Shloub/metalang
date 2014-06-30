let min2 a b =
  if a < b then
    a
  else
    b

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
  let maximumprimes = 1000001 in
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
  let sum = Array.init nprimes (fun i_ ->
    primes.(i_)) in
  let maxl = ref( 0 ) in
  let process = ref( true ) in
  let stop = ref( maximumprimes - 1 ) in
  let len = ref( 1 ) in
  let resp = ref( 1 ) in
  while (!process)
  do
      process := false;
      for i = 0 to (!stop) do
        if i + (!len) < nprimes then
          begin
            sum.(i) <- sum.(i) + primes.(i + (!len));
            if maximumprimes > sum.(i) then
              begin
                process := true;
                if era.(sum.(i)) = sum.(i) then
                  begin
                    maxl := (!len);
                    resp := sum.(i)
                  end
              end
            else
              stop := min2 (!stop) i
          end
      done;
      len := (!len) + 1
  done;
  Printf.printf "%d\n%d\n" (!resp) (!maxl)
end
 