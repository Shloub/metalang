require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def id( b )
    return (b);
end

def g( t, index )
    t[index] = false;
end

c = 5
a = [];
for i in (0 ..  c - 1) do
  printf "%d", i
  a[i] = (mod(i, 2)) == 0;
end
d = a[0]
if d then
  print "True";
else
  print "False";
end
print "\n";
g(id(a), 0);
e = a[0]
if e then
  print "True";
else
  print "False";
end
print "\n";

