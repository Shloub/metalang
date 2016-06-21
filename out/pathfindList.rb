require "scanf.rb"
def pathfind_aux( cache, tab, len, pos )
  if pos >= len - 1 then
      return 0
   elsif cache[pos] != -1 then
      return cache[pos]
   else 
      cache[pos] = len * 2
      posval = pathfind_aux(cache, tab, len, tab[pos])
      oneval = pathfind_aux(cache, tab, len, pos + 1)
      out0 = 0
      if posval < oneval then
          out0 = 1 + posval
       else 
          out0 = 1 + oneval
      end
      cache[pos] = out0
      return out0
  end
end

def pathfind( tab, len )
  cache = [*0..len-1].map { |i|
    
    next -1
    }
  return pathfind_aux(cache, tab, len, 0)
end
len = 0
len = scanf("%d")[0]
scanf("%*\n")
tab = [*0..len-1].map { |i|
  
  tmp = 0
  tmp = scanf("%d")[0]
  scanf("%*\n")
  next tmp
  }
result = pathfind(tab, len)
printf "%d", result

