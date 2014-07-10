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
      b = x
      c = [];
      for d in (0 ..  b - 1) do
        e = 0
        e=scanf("%d")[0];
        scanf("%*\n");
        c[d] = e;
      end
      a = c
      tab[z] = a;
    end
    return (tab);
end

g = 0
g=scanf("%d")[0];
scanf("%*\n");
f = g
len = f
printf "%d=len\n", len
k = len
l = [];
for m in (0 ..  k - 1) do
  o = 0
  o=scanf("%d")[0];
  scanf("%*\n");
  l[m] = o;
end
h = l
tab1 = h
for i in (0 ..  len - 1) do
  printf "%d=>%d\n", i, tab1[i]
end
q = 0
q=scanf("%d")[0];
scanf("%*\n");
p = q
len = p;
tab2 = read_int_matrix(len, len - 1)
for i in (0 ..  len - 2) do
  for j in (0 ..  len - 1) do
    printf "%d ", tab2[i][j]
  end
  print "\n";
end

