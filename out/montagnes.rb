require "scanf.rb"
def montagnes0( tab, len )
  max0 = 1
  j = 1
  i = len - 2
  while i >= 0 do
      x = tab[i]
      while j >= 0 && x > tab[len - j] do
          j -= 1
      end
      j += 1
      tab[len - j] = x
      if j > max0 then
          max0 = j
      end
      i -= 1
  end
  return max0
end
len = 0
len = scanf("%d")[0]
scanf("%*\n")
tab = [*0..len-1].map { |i|
  
  x = 0
  x = scanf("%d")[0]
  scanf("%*\n")
  next x
  }
printf "%d", montagnes0(tab, len)
