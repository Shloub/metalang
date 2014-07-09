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
      tab[z] = read_int_line(x);
    end
    return (tab);
end

len = read_int()
printf "%d=len\n", len
tab1 = read_int_line(len)
for i in (0 ..  len - 1) do
  printf "%d=>%d\n", i, tab1[i]
end
len = read_int();
tab2 = read_int_matrix(len, len - 1)
for i in (0 ..  len - 2) do
  for j in (0 ..  len - 1) do
    printf "%d ", tab2[i][j]
  end
  print "\n";
end

