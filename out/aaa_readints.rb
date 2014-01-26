
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

def read_int_matrix( x, y )
    tab = [];
    for z in (0 ..  y - 1) do
      out_ = read_int_line(x)
      scanf("%*\n");
      tab[z] = out_;
    end
    return (tab);
end

l0 = read_int_line(1)
len = l0[0]
printf "%d%s", len, "=len\n"
tab1 = read_int_line(len)
for i in (0 ..  len - 1) do
  printf "%d%s", i, "=>"
  a = tab1[i]
  printf "%d%s", a, "\n"
end
l0 = read_int_line(1);
len = l0[0];
tab2 = read_int_matrix(len, len - 1)
for i in (0 ..  len - 2) do
  for j in (0 ..  len - 1) do
    b = tab2[i][j]
    printf "%d%s", b, " "
  end
  print "\n";
end

