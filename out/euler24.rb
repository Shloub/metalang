require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def fact( n )
    prod = 1
    for i in (2 ..  n) do
      prod *= i
    end
    return (prod)
end

def show( lim, nth )
    t = [*0..lim - 1].map { |i|
      next (i)
      }
    pris = [*0..lim - 1].map { |j|
      next (false)
      }
    for k in (1 ..  lim - 1) do
      n = fact(lim - k)
      nchiffre = (nth.to_f / n).to_i
      nth = mod(nth, n)
      for l in (0 ..  lim - 1) do
        if not(pris[l]) then
          if nchiffre == 0 then
            printf "%d", l
            pris[l] = true
          end
          nchiffre -= 1
        end
      end
    end
    for m in (0 ..  lim - 1) do
      if not(pris[m]) then
        printf "%d", m
      end
    end
    print "\n"
end

show(10, 999999)

