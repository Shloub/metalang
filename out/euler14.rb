require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def next0( n )
    if mod(n, 2) == 0 then
      return ((n.to_f / 2).to_i)
    else
      return (3 * n + 1)
    end
end

def find( n, m )
    if n == 1 then
      return (1)
    elsif n >= 1000000 then
      return (1 + find(next0(n), m))
    elsif m[n] != 0 then
      return (m[n])
    else
      m[n] = 1 + find(next0(n), m)
      return (m[n])
    end
end

m = [*0..1000000 - 1].map { |j|
  next (0)
  }
max0 = 0
maxi = 0
for i in (1 ..  999) do
  
=begin
 normalement on met 999999 mais ça dépasse les int32... 
=end

  n2 = find(i, m)
  if n2 > max0 then
    max0 = n2
    maxi = i
  end
end
printf "%d\n%d\n", max0, maxi

