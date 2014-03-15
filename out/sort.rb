
require "scanf.rb"

def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def sort_( tab, len )
    for i in (0 ..  len - 1) do
      for j in (i + 1 ..  len - 1) do
        if tab[i] > tab[j] then
          tmp = tab[i]
          tab[i] = tab[j];
          tab[j] = tmp;
        end
      end
    end
end

len = 2
len=scanf("%d")[0];
scanf("%*\n");
tab = [];
for i_ in (0 ..  len - 1) do
  tmp = 0
  tmp=scanf("%d")[0];
  scanf("%*\n");
  tab[i_] = tmp;
end
sort_(tab, len);
for i in (0 ..  len - 1) do
  a = tab[i]
  printf "%d", a
end

