require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

a = 1
b = 2
sum = 0
while a < 4000000 do
  if (mod(a, 2)) == 0 then
    sum += a
  end
  c = a
  a = b
  b += c
end
printf "%d\n", sum

