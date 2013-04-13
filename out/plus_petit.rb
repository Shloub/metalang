
require "scanf.rb"

def go( tab, a, b )
    m = a + b / 2
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
        i = i + 1;
      else
        j = j - 1;
        tab[i] = tab[j];
        tab[j] = e;
      end
    end
    if i < m then
      return (go(tab, a, m));
    else
      return (go(tab, m, b));
    end
end

def plus_petit_( tab, len )
    return (go(tab, 0, len));
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
p = plus_petit_(tab, len)
printf "%d", p

