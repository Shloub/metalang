require "scanf.rb"
def result( sum, t, maxIndex, cache )
    if cache[sum][maxIndex] != 0 then
      return (cache[sum][maxIndex]);
    elsif sum == 0 || maxIndex == 0 then
      return (1);
    else
      out0 = 0
      div = (sum.to_f / t[maxIndex]).to_i
      for i in (0 ..  div) do
        out0 += result(sum - i * t[maxIndex], t, maxIndex - 1, cache)
      end
      cache[sum][maxIndex] = out0
      return (out0);
    end
end

t = [];
for i in (0 ..  8 - 1) do
  t[i] = 0
end
t[0] = 1
t[1] = 2
t[2] = 5
t[3] = 10
t[4] = 20
t[5] = 50
t[6] = 100
t[7] = 200
cache = [];
for j in (0 ..  201 - 1) do
  o = [];
  for k in (0 ..  8 - 1) do
    o[k] = 0
  end
  cache[j] = o
end
printf "%d", result(200, t, 7, cache)

