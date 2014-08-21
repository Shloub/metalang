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
d = min2(min2(e, f), g)
printf "%d ", d
i = 2
j = 4
k = 3
h = min2(min2(i, j), k)
printf "%d ", h
m = 3
n = 2
o = 4
l = min2(min2(m, n), o)
printf "%d ", l
q = 3
r = 4
s = 2
p = min2(min2(q, r), s)
printf "%d ", p
u = 4
v = 2
w = 3
t = min2(min2(u, v), w)
printf "%d ", t
y = 4
z = 3
ba = 2
x = min2(min2(y, z), ba)
printf "%d\n", x

