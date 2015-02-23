require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def id( b )
    return (b);
end

def g( t, index )
    t[index] = false
end

j = 0
a = [];
for i in (0 ..  5 - 1) do
  printf "%d", i
  j += i
  a[i] = (mod(i, 2)) == 0
end
printf "%d ", j
c = a[0]
if c then
  print "True";
else
  print "False";
end
print "\n";
g(id(a), 0)
d = a[0]
if d then
  print "True";
else
  print "False";
end
print "\n";

