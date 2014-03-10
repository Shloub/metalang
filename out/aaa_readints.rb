
require "scanf.rb"

def read_int(  )
    out_ = 0
    out_=scanf("%d")[0];
    scanf("%*\n");
    return (out_);
end

def read_int_line( n )
    tab = [];
    for i in (0 ..  n - 1) do
      t_ = 0
      t_=scanf("%d")[0];
      scanf("%*\n");
      tab[i] = t_;
    end
    return (tab);
end

def read_int_matrix( x, y )
    tab = [];
    for z in (0 ..  y - 1) do
      scanf("%*\n");
      tab[z] = read_int_line(x);
    end
    return (tab);
end

len = read_int()
printf "%d=len\n", len
tab1 = read_int_line(len)
for i in (0 ..  len - 1) do
  printf "%d=>", i
  a = tab1[i]
  printf "%d\n", a
end
len = read_int();
tab2 = read_int_matrix(len, len - 1)
for i in (0 ..  len - 2) do
  for j in (0 ..  len - 1) do
    b = tab2[i][j]
    printf "%d ", b
  end
  print "\n";
end

