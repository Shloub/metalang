require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def periode( restes, len, a, b )
    while a != 0 do
      chiffre = (a.to_f / b).to_i
      reste = mod(a, b)
      for i in (0 ..  len - 1) do
        if restes[i] == reste then
          return (len - i);
        end
      end
      restes[len] = reste
      len += 1
      a = reste * 10
    end
    return (0);
end

t = [];
for j in (0 ..  1000 - 1) do
  t[j] = 0
end
m = 0
mi = 0
for i in (1 ..  1000) do
  p = periode(t, 0, 1, i)
  if p > m then
    mi = i
    m = p
  end
end
printf "%d\n%d\n", mi, m

