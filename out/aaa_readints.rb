require "scanf.rb"
f=scanf("%d")[0];
scanf("%*\n");
len = f
printf "%d=len\n", len
h = [];
for k in (0 ..  len - 1) do
  h[k]=scanf("%d")[0];
  scanf("%*\n");
end
tab1 = h
for i in (0 ..  len - 1) do
  printf "%d=>%d\n", i, tab1[i]
end
len=scanf("%d")[0];
scanf("%*\n");
r = [];
for s in (0 ..  len - 1 - 1) do
  u = [];
  for v in (0 ..  len - 1) do
    w=scanf("%d")[0];
    scanf("%*\n");
    u[v] = w;
  end
  r[s] = u;
end
tab2 = r
for i in (0 ..  len - 2) do
  for j in (0 ..  len - 1) do
    printf "%d ", tab2[i][j]
  end
  print "\n";
end

