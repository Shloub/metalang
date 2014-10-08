(*

(a + b * 10 + c * 100) * (d + e * 10 + f * 100) =
a * d + a * e * 10 + a * f * 100 +
10 * (b * d + b * e * 10 + b * f * 100)+
100 * (c * d + c * e * 10 + c * f * 100) =

a * d       + a * e * 10   + a * f * 100 +
b * d * 10  + b * e * 100  + b * f * 1000 +
c * d * 100 + c * e * 1000 + c * f * 10000 =

a * d +
10 * ( a * e + b * d) +
100 * (a * f + b * e + c * d) +
(c * e + b * f) * 1000 +
c * f * 10000

*)
let rec chiffre c m =
  if c = 0 then
    m mod 10
  else
    chiffre (c - 1) (m / 10)

let () =
begin
  let m = ref( 1 ) in
  for a = 0 to 9 do
    for f = 1 to 9 do
      for d = 0 to 9 do
        for c = 1 to 9 do
          for b = 0 to 9 do
            for e = 0 to 9 do
              let mul = a * d + 10 * (a * e + b * d) + 100 * (a * f + b * e +
                                                               c * d) + 1000 * (c *
                                                                    e + b * f) + 10000 * c * f in
              if chiffre 0 mul = chiffre 5 mul && chiffre 1 mul = chiffre 4 mul && chiffre 2 mul = chiffre 3 mul then
                begin
                  let g = (max (mul) ((!m))) in
                  m := g
                end
            done
          done
        done
      done
    done
  done;
  Printf.printf "%d\n" (!m)
end
 