require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def h( i )
  #  for j = i - 2 to i + 2 do
  #    if i % j == 5 then return true end
  #  end 
  
  j = i - 2
  while j <= i + 2 do
      if mod(i, j) == 5 then
          return true
      end
      j += 1
  end
  return false
end
j = 0
for k in (0 ..  10) do
    j += k
    printf "%d\n", j
    end
    i = 4
    while i < 10 do
        printf "%d", i
        i += 1
        j += i
    end
    printf "%d%dFIN TEST\n", j, i
    
    