
require "scanf.rb"

def devine_( nombre, tab, len )
    min_ = tab[0]
    max_ = tab[1]
    for i in (2 ..  len - 1) do
      if tab[i] > max_ || tab[i] < min_ then
        return (false);
      end
      if tab[i] < nombre then
        min_ = tab[i];
      end
      if tab[i] > nombre then
        max_ = tab[i];
      end
      if tab[i] == nombre && len != i + 1 then
        return (false);
      end
    end
    return (true);
end

nombre = 0
nombre=scanf("%d")[0];
scanf("%*\n");
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
k = devine_(nombre, tab, len)
if k then
  printf "%s", "True"
else
  printf "%s", "False"
end

