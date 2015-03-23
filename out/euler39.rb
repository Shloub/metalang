require "scanf.rb"
t = [*0..1001 - 1].map { |i|
                     next (0)
                     }
for a in (1 ..  1000) do
  for b in (1 ..  1000) do
    c2 = a * a + b * b
    c = Math.sqrt(c2).to_i
    if c * c == c2 then
      p = a + b + c
      if p <= 1000 then
        t[p] = t[p] + 1
      end
    end
  end
end
j = 0
for k in (1 ..  1000) do
  if t[k] > t[j] then
    j = k
  end
end
printf "%d", j

