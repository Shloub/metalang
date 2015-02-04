require "scanf.rb"

=begin

a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5

=end

p = [];
for i in (0 ..  10 - 1) do
  p[i] = i * i * i * i * i
end
sum = 0
for a in (0 ..  9) do
  for b in (0 ..  9) do
    for c in (0 ..  9) do
      for d in (0 ..  9) do
        for e in (0 ..  9) do
          for f in (0 ..  9) do
            s = p[a] + p[b] + p[c] + p[d] + p[e] + p[f]
            r = a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000
            if s == r && r != 1 then
              printf "%d%d%d%d%d%d %d\n", f, e, d, c, b, a, r
              sum += r
            end
          end
        end
      end
    end
  end
end
printf "%d", sum

