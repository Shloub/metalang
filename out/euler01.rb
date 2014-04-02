require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

sum = 0
for i in (0 ..  999) do
  if (mod(i, 3)) == 0 || (mod(i, 5)) == 0 then
    sum += i
  end
end
printf "%d\n", sum

