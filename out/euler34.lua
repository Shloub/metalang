
local f = {}
for j = 0,10 - 1 do
  f[j] = 1;
end
for i = 1,9 do
  f[i] = f[i] * i * f[i - 1];
  io.write(string.format("%d ", f[i]))
end
local out0 = 0
io.write("\n")
for a = 0,9 do
  for b = 0,9 do
    for c = 0,9 do
      for d = 0,9 do
        for e = 0,9 do
          for g = 0,9 do
            local sum = f[a] + f[b] + f[c] + f[d] + f[e] + f[g]
            local num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g
            if a == 0
            then
              sum = sum - 1;
              if b == 0
              then
                sum = sum - 1;
                if c == 0
                then
                  sum = sum - 1;
                  if d == 0
                  then
                    sum = sum - 1;
                  end
                end
              end
            end
            if sum == num and sum ~= 1 and sum ~= 2
            then
              out0 = out0 + num;
              io.write(string.format("%d ", num))
            end
          end
        end
      end
    end
  end
end
io.write(string.format("\n%d\n", out0))
