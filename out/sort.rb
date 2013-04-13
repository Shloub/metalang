
require "scanf.rb"

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
for i in (0 ..  len - 1) do
  tmp = 0
  tmp=scanf("%d")[0];
  scanf("%*\n");
  tab[i] = tmp;
end
sort_(tab, len);
for t in (0 ..  (tab.length) - 1) do
  printf "%d", tab[t]
end

