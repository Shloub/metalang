
require "scanf.rb"

def devine_( nombre, tab, len )
    min_ = tab[0]
    max_ = tab[1]
    for i in (2 ..  len - 1) do
      printf "%d => ", i
      a = tab[i]
      printf "%d\n", a
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
printf "%d %d\n", nombre, len
tab = [];
for i in (0 ..  len - 1) do
  tmp = 0
  tmp=scanf("%d")[0];
  scanf("%*\n");
  printf "%d ", tmp
  tab[i] = tmp;
end
print "\n";
b = devine_(nombre, tab, len)
if b then
  print "True";
else
  print "False";
end

