(*
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier,
and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a
1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.


(a * 10 + b) ( c * 100 + d * 10 + e) =
  a * c * 1000 +
  a * d * 100 +
  a * e * 10 +
  b * c * 100 +
  b * d * 10 +
  b * e
  => b != e != b * e % 10 ET
  a != d != (b * e / 10 + b * d + a * e ) % 10
*)
let rec okdigits ok n =
  if n = 0 then
    true
  else
    begin
      let digit = n mod 10 in
      if ok.(digit) then
        begin
          ok.(digit) <- false;
          let o = okdigits ok (n / 10) in
          ok.(digit) <- true;
          o
        end
      else
        false
    end

let () =
begin
  let count = ref( 0 ) in
  let allowed = Array.init 10 (fun i ->
    i <> 0) in
  let counted = Array.init 100000 (fun _j ->
    false) in
  for e = 1 to 9 do
    allowed.(e) <- false;
    for b = 1 to 9 do
      if allowed.(b) then
        begin
          allowed.(b) <- false;
          let be = (b * e) mod 10 in
          if allowed.(be) then
            begin
              allowed.(be) <- false;
              for a = 1 to 9 do
                if allowed.(a) then
                  begin
                    allowed.(a) <- false;
                    for c = 1 to 9 do
                      if allowed.(c) then
                        begin
                          allowed.(c) <- false;
                          for d = 1 to 9 do
                            if allowed.(d) then
                              begin
                                allowed.(d) <- false;
                                (* 2 * 3 digits *)
                                let product = (a * 10 + b) * (c * 100 + d *
                                                               10 + e) in
                                if not counted.(product) && okdigits allowed (product / 10) then
                                  begin
                                    counted.(product) <- true;
                                    count := (!count) + product;
                                    Printf.printf "%d " product
                                  end;
                                (* 1  * 4 digits *)
                                let product2 = b * (a * 1000 + c * 100 + d *
                                                     10 + e) in
                                if not counted.(product2) && okdigits allowed (product2 / 10) then
                                  begin
                                    counted.(product2) <- true;
                                    count := (!count) + product2;
                                    Printf.printf "%d " product2
                                  end;
                                allowed.(d) <- true
                              end
                          done;
                          allowed.(c) <- true
                        end
                    done;
                    allowed.(a) <- true
                  end
              done;
              allowed.(be) <- true
            end;
          allowed.(b) <- true
        end
    done;
    allowed.(e) <- true
  done;
  Printf.printf "%d\n" (!count)
end
 