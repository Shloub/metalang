
require "scanf.rb"

def read_int_line( n )
    tab = [];
    for i in (0 ..  n - 1) do
      t = 0
      t=scanf("%d")[0];
      scanf("%*\n");
      tab[i] = t;
    end
    return (tab);
end

l0 = read_int_line(1)
len = l0[0]
printf "%d", len
printf "%s", "=len\n"
tab1 = read_int_line(len)
for i in (0 ..  len - 1) do
  printf "%d", i
  printf "%s", "=>"
  a = tab1[i]
  printf "%d", a
  printf "%s", "\n"
end
tab2 = read_int_line(len)
for i in (0 ..  len - 1) do
  printf "%d", i
  printf "%s", "=>"
  b = tab2[i]
  printf "%d", b
  printf "%s", "\n"
end

