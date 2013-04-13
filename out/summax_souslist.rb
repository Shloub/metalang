
require "scanf.rb"

def summax( lst, len )
    current = 0
    max_ = 0
    for i in (0 ..  len - 1) do
      current = current + lst[i];
      if current < 0 then
        current = 0;
      end
      if max_ < current then
        max_ = current;
      end
    end
    return (max_);
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
result = summax(tab, len)
printf "%d", result

