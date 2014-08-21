require "scanf.rb"
def read_int_matrix( x, y )
    tab = [];
    for z in (0 ..  y - 1) do
      b = [];
      for c in (0 ..  x - 1) do
        d = 0
        d=scanf("%d")[0];
        scanf("%*\n");
        b[c] = d;
      end
      a = b
      tab[z] = a;
    end
    return (tab);
end

f = 0
f=scanf("%d")[0];
scanf("%*\n");
e = f
len = e
printf "%d=len\n", len
h = [];
for k in (0 ..  len - 1) do
  l = 0
  l=scanf("%d")[0];
  scanf("%*\n");
  h[k] = l;
end
g = h
tab1 = g
for i in (0 ..  len - 1) do
  printf "%d=>%d\n", i, tab1[i]
end
o = 0
o=scanf("%d")[0];
scanf("%*\n");
m = o
len = m;
tab2 = read_int_matrix(len, len - 1)
for i in (0 ..  len - 2) do
  for j in (0 ..  len - 1) do
    printf "%d ", tab2[i][j]
  end
  print "\n";
end

