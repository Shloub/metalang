
require "scanf.rb"

def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def go_( tab, a, b )
    m = ((a + b).to_f / 2).to_i
    if a == m then
      if tab[a] == m then
        return (b);
      else
        return (a);
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
        tab[i] = tab[j];
        tab[j] = e;
      end
    end
    if i < m then
      return (go_(tab, a, m));
    else
      return (go_(tab, m, b));
    end
end

def plus_petit_( tab, len )
    return (go_(tab, 0, len));
end

len = 0
len=scanf("%d")[0];
scanf("%*\n");
tab = [];
for i in (0 ..  len - 1) do
  tmp = 0
  tmp=scanf("%d")[0];
  scanf("%*\n");
  tab[i] = tmp;
end
c = plus_petit_(tab, len)
printf "%d", c

