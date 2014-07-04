require "scanf.rb"
def isqrt( c )
    return (Math.sqrt(c).to_i);
end

def is_triangular( n )
    
=begin

   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   
=end

    a = isqrt(n * 2)
    return (a * (a + 1) == n * 2);
end

def score(  )
    scanf("%*\n");
    len = 0
    len=scanf("%d")[0];
    scanf("%*\n");
    sum = 0
    for i in (1 ..  len) do
      c = "_"
      c=scanf("%c")[0];
      sum += (c.ord - "A".ord) + 1
      
=begin
		print c print " " print sum print " " 
=end

    end
    if is_triangular(sum) then
      return (1);
    else
      return (0);
    end
end

for i in (1 ..  55) do
  if is_triangular(i) then
    printf "%d ", i
  end
end
print "\n";
sum = 0
n = 0
n=scanf("%d")[0];
for i in (1 ..  n) do
  sum += score()
end
printf "%d\n", sum

