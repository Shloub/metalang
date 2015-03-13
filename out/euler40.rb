require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def exp0( a, e )
    o = 1
    for i in (1 ..  e) do
      o *= a
    end
    return (o)
end

def e( t, n )
    for i in (1 ..  8) do
      if n >= t[i] * i then
        n -= t[i] * i
      else
        nombre = exp0(10, i - 1) + (n.to_f / i).to_i
        chiffre = i - 1 - mod(n, i)
        return (mod((nombre.to_f / exp0(10, chiffre)).to_i, 10))
      end
    end
    return (-1)
end

t = [*0..9 - 1].map { |i|
  next (exp0(10, i) - exp0(10, i - 1))
  }
for i2 in (1 ..  8) do
  printf "%d => %d\n", i2, t[i2]
end
for j in (0 ..  80) do
  printf "%d", e(t, j)
end
print "\n"
for k in (1 ..  50) do
  printf "%d", k
end
print "\n"
for j2 in (169 ..  220) do
  printf "%d", e(t, j2)
end
print "\n"
for k2 in (90 ..  110) do
  printf "%d", k2
end
print "\n"
out0 = 1
for l in (0 ..  6) do
  puiss = exp0(10, l)
  v = e(t, puiss - 1)
  out0 *= v
  printf "10^%d=%d v=%d\n", l, puiss, v
end
printf "%d\n", out0

