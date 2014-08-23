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

i = 1
last = [];
for j in (0 ..  5 - 1) do
  c = "_"
  c=scanf("%c")[0];
  d = c.ord - "0".ord
  i *= d
  last[j] = d;
end
max_ = i
index = 0
nskipdiv = 0
for k in (1 ..  995) do
  e = "_"
  e=scanf("%c")[0];
  f = e.ord - "0".ord
  if f == 0 then
    i = 1;
    nskipdiv = 4;
  else
    i *= f
    if nskipdiv < 0 then
      i = (i.to_f / last[index]).to_i
    end
    nskipdiv -= 1
  end
  last[index] = f;
  index = mod(index + 1, 5);
  max_ = max2(max_, i);
end
printf "%d\n", max_

