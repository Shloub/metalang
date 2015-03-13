require "scanf.rb"
f = [*0..10 - 1].map { |j|
                     next (1)
                     }
for i in (1 ..  9) do
  f[i] = f[i] * i * f[i - 1]
  printf "%d ", f[i]
end
out0 = 0
print "\n"
for a in (0 ..  9) do
  for b in (0 ..  9) do
    for c in (0 ..  9) do
      for d in (0 ..  9) do
        for e in (0 ..  9) do
          for g in (0 ..  9) do
            sum = f[a] + f[b] + f[c] + f[d] + f[e] + f[g]
            num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g
            if a == 0 then
              sum -= 1
              if b == 0 then
                sum -= 1
                if c == 0 then
                  sum -= 1
                  if d == 0 then
                    sum -= 1
                  end
                end
              end
            end
            if sum == num && sum != 1 && sum != 2 then
              out0 += num
              printf "%d ", num
            end
          end
        end
      end
    end
  end
end
printf "\n%d\n", out0

