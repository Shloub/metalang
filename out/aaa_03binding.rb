require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def g( i )
    j = i * 4
    if (mod(j, 2)) == 1 then
      return (0);
    end
    return (j);
end

def h( i )
    printf "%d\n", i
end

h(14)
a = 4
b = 5
printf "%d", a + b

=begin
 main 
=end

h(15)
a = 2
b = 1
printf "%d", a + b

