require "scanf.rb"
def dichofind( len, tab, tofind, a, b )
  if a >= b - 1 then
      return a
  else 
      c = ((a + b).to_f / 2).to_i
      if tab[c] < tofind then
          return dichofind(len, tab, tofind, c, b)
      else 
          return dichofind(len, tab, tofind, a, c)
      end
  end
end
def process( len, tab )
  size = [*0..len-1].map { |j|
    
    if j == 0 then
        next 0
    else 
        next len * 2
    end
    }
  for i in (0 ..  len - 1) do
      k = dichofind(len, size, tab[i], 0, len - 1)
      if size[k + 1] > tab[i] then
          size[k + 1] = tab[i]
      end
      end
      for l in (0 ..  len - 1) do
          printf "%d ", size[l]
          end
          for m in (0 ..  len - 1) do
              k = len - 1 - m
              if size[k] != len * 2 then
                  return k
              end
              end
              return 0
          end
          n = STDIN.readline.to_i(10)
          for i in (1 ..  n) do
              len = STDIN.readline.to_i(10)
              printf "%d\n", process(len, STDIN.readline.split(" ").map{ |x| x.to_i(10) })
              end
              