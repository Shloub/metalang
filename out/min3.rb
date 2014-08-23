require "scanf.rb"
def min2( a, b )
    if a < b then
      return (a);
    else
      return (b);
    end
end

e = 2
f = 3
g = 4
printf "%d ", min2(min2(e, f), g)
i = 2
j = 4
k = 3
printf "%d ", min2(min2(i, j), k)
m = 3
n = 2
o = 4
printf "%d ", min2(min2(m, n), o)
q = 3
r = 4
s = 2
printf "%d ", min2(min2(q, r), s)
u = 4
v = 2
w = 3
printf "%d ", min2(min2(u, v), w)
y = 4
z = 3
ba = 2
printf "%d\n", min2(min2(y, z), ba)

