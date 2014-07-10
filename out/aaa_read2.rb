require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

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

def read_char_line( n )
    tab = [];
    for i in (0 ..  n - 1) do
      t = "_"
      t=scanf("%c")[0];
      tab[i] = t;
    end
    scanf("%*\n");
    return (tab);
end


=begin

Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip

=end

b = 0
b=scanf("%d")[0];
scanf("%*\n");
a = b
len = a
printf "%d=len\n", len
e = len
f = [];
for g in (0 ..  e - 1) do
  h = 0
  h=scanf("%d")[0];
  scanf("%*\n");
  f[g] = h;
end
d = f
tab = d
for i in (0 ..  len - 1) do
  printf "%d=>%d ", i, tab[i]
end
print "\n";
l = len
m = [];
for o in (0 ..  l - 1) do
  p = 0
  p=scanf("%d")[0];
  scanf("%*\n");
  m[o] = p;
end
k = m
tab2 = k
for i_ in (0 ..  len - 1) do
  printf "%d==>%d ", i_, tab2[i_]
end
r = 0
r=scanf("%d")[0];
scanf("%*\n");
q = r
strlen = q
printf "%d=strlen\n", strlen
u = strlen
v = [];
for w in (0 ..  u - 1) do
  x = "_"
  x=scanf("%c")[0];
  v[w] = x;
end
scanf("%*\n");
s = v
tab4 = s
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

