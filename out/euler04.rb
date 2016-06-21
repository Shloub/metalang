require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end


def chiffre( c, m )
  if c == 0 then
      return mod(m, 10)
   else 
      return chiffre(c - 1, (m.to_f / 10).to_i)
  end
end
m = 1
for a in (0 ..  9) do
    for f in (1 ..  9) do
        for d in (0 ..  9) do
            for c in (1 ..  9) do
                for b in (0 ..  9) do
                    for e in (0 ..  9) do
                        mul = a * d + 10 * (a * e + b * d) + 100 * (a * f + b * e + c * d) + 1000 * (c * e + b * f) + 10000 * c * f
                        if chiffre(0, mul) == chiffre(5, mul) && chiffre(1, mul) == chiffre(4, mul) && chiffre(2, mul) == chiffre(3, mul) then
                            m = [mul, m].max
                        end
                        end
                        end
                        end
                        end
                        end
                        end
                        printf "%d\n", m
                        
                        