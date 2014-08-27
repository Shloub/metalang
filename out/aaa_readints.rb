require "scanf.rb"
def read_int_matrix( x, y )
    tab = [];
    for z in (0 ..  y - 1) do
      b = [];
      for c in (0 ..  x - 1) do
        d=scanf("%d")[0];
        scanf("%*\n");
        b[c] = d;
      end
      a = b
      tab[z] = a;
    end
    return (tab);
end

f=scanf("%d")[0];
scanf("%*\n");
len = f
printf "%d=len\n", len
h = [];
for k in (0 ..  len - 1) do
  l=scanf("%d")[0];
  scanf("%*\n");
  h[k] = l;
end
tab1 = h
for i in (0 ..  len - 1) do
  printf "%d=>%d\n", i, tab1[i]
end
o=scanf("%d")[0];
scanf("%*\n");
len = o;
tab2 = read_int_matrix(len, len - 1)
for i in (0 ..  len - 2) do
  for j in (0 ..  len - 1) do
    printf "%d ", tab2[i][j]
  end
  print "\n";
end

