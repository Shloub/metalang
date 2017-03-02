require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

maximum = 1
b0 = 2
a = 408464633
sqrtia = Math.sqrt(a).to_i
while a != 1 do
    b = b0
    found = false
    while b <= sqrtia do
        if mod(a, b) == 0 then
            a = (a.to_f / b).to_i
            b0 = b
            b = a
            sqrtia = Math.sqrt(a).to_i
            found = true
        end
        b += 1
    end
    if !found then
        printf "%d\n", a
        a = 1
    end
end
