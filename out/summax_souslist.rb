require "scanf.rb"
def summax( lst, len )
    current = 0
    max0 = 0
    for i in (0 ..  len - 1) do
      current += lst[i]
      if current < 0 then
        current = 0
      end
      if max0 < current then
        max0 = current
      end
    end
    return (max0)
end

len = 0
len=scanf("%d")[0]
scanf("%*\n")
tab = [*0..len - 1].map { |i|
  tmp = 0
  tmp=scanf("%d")[0]
  scanf("%*\n")
  next (tmp)
  }
result = summax(tab, len)
printf "%d", result

