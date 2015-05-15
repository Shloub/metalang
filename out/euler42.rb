require "scanf.rb"
def is_triangular( n )
    
=begin

   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   
=end

    a = Math.sqrt(n * 2).to_i
    return (a * (a + 1) == n * 2)
end

def score(  )
    scanf("%*\n")
    len=scanf("%d")[0]
    scanf("%*\n")
    sum = 0
    for i in (1 ..  len) do
      c=scanf("%c")[0]
      sum += c.ord - "A".ord + 1
      
=begin
		print c print " " print sum print " " 
=end

    end
    if is_triangular(sum) then
      return (1)
    else
      return (0)
    end
end

for i in (1 ..  55) do
  if is_triangular(i) then
    printf "%d ", i
  end
end
print "\n"
sum = 0
n=scanf("%d")[0]
for i in (1 ..  n) do
  sum += score()
end
printf "%d\n", sum

