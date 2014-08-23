require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

=begin

Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip

=end

b = 0
b=scanf("%d")[0];
scanf("%*\n");
len = b
printf "%d=len\n", len
e = [];
for f in (0 ..  len - 1) do
  g = 0
  g=scanf("%d")[0];
  scanf("%*\n");
  e[f] = g;
end
tab = e
for i in (0 ..  len - 1) do
  printf "%d=>%d ", i, tab[i]
end
print "\n";
k = [];
for l in (0 ..  len - 1) do
  m = 0
  m=scanf("%d")[0];
  scanf("%*\n");
  k[l] = m;
end
tab2 = k
for i_ in (0 ..  len - 1) do
  printf "%d==>%d ", i_, tab2[i_]
end
p = 0
p=scanf("%d")[0];
scanf("%*\n");
strlen = p
printf "%d=strlen\n", strlen
r = [];
for s in (0 ..  strlen - 1) do
  u = "_"
  u=scanf("%c")[0];
  r[s] = u;
end
scanf("%*\n");
tab4 = r
for i3 in (0 ..  strlen - 1) do
  tmpc = tab4[i3]
  c = tmpc.ord
  printf "%c:%d ", tmpc, c
  if tmpc != " " then
    c = mod((c - "a".ord) + 13, 26) + "a".ord;
  end
  tab4[i3] = c;
end
for j in (0 ..  strlen - 1) do
  printf "%c", tab4[j]
end

