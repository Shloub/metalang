require "scanf.rb"
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
    return (sum)
end

sum = 0
n=scanf("%d")[0]
for i in (1 ..  n) do
  sum += i * score()
end
printf "%d\n", sum

