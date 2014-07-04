require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def max2( a, b )
    if a > b then
      return (a);
    else
      return (b);
    end
end

def min2( a, b )
    if a < b then
      return (a);
    else
      return (b);
    end
end

def pgcd( a, b )
    c = min2(a, b)
    d = max2(a, b)
    reste = mod(d, c)
    if reste == 0 then
      return (c);
    else
      return (pgcd(c, reste));
    end
end

top = 1
bottom = 1
for i in (1 ..  9) do
  for j in (1 ..  9) do
    for k in (1 ..  9) do
      if i != j && j != k then
        a = i * 10 + j
        b = j * 10 + k
        if a * k == i * b then
          printf "%d/%d\n", a, b
          top *= a
          bottom *= b
        end
      end
    end
  end
end
printf "%d/%d\n", top, bottom
p = pgcd(top, bottom)
printf "pgcd=%d\n", p
e = (bottom.to_f / p).to_i
printf "%d\n", e

