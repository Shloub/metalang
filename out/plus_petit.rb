require "scanf.rb"
def go0( tab, a, b )
    m = ((a + b).to_f / 2).to_i
    if a == m then
      if tab[a] == m then
        return (b)
      else
        return (a)
      end
    end
    i = a
    j = b
    while i < j do
      e = tab[i]
      if e < m then
        i += 1
      else
        j -= 1
        tab[i] = tab[j]
        tab[j] = e
      end
    end
    if i < m then
      return (go0(tab, a, m))
    else
      return (go0(tab, m, b))
    end
end

def plus_petit0( tab, len )
    return (go0(tab, 0, len))
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
printf "%d", plus_petit0(tab, len)

