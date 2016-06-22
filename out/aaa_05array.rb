require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def id( b )
  return b
end

def g( t, index )
  t[index] = false
end
j = 0
a = [*0..5-1].map { |i|
  
  printf "%d", i
  j += i
  next mod(i, 2) == 0
  }
printf "%d ", j
if a[0] then
    print "True"
else 
    print "False"
end
print "\n"
g(id(a), 0)
if a[0] then
    print "True"
else 
    print "False"
end
print "\n"

