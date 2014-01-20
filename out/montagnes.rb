
require "scanf.rb"

def montagnes_( tab, len )
    max_ = 1
    j = 1
    i = len - 2
    while i >= 0 do
      x = tab[i]
      while j >= 0 && x > tab[len - j] do
        j -= 1;
      end
      j += 1;
      tab[len - j] = x;
      if j > max_ then
        max_ = j;
      end
      i -= 1;
    end
    return (max_);
end

len = 0
len=scanf("%d")[0];
scanf("%*\n");
tab = [];
for i in (0 ..  len - 1) do
  x = 0
  x=scanf("%d")[0];
  scanf("%*\n");
  tab[i] = x;
end
a = montagnes_(tab, len)
printf "%d", a

