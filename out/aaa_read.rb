
require "scanf.rb"




=begin

Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip

=end

len = 0
len=scanf("%d")[0];
scanf("%*\n");
printf "%d%s", len, "=len\n"
tab = [];
for i in (0 ..  len - 1) do
  tmpi1 = 0
  tmpi1=scanf("%d")[0];
  scanf("%*\n");
  printf "%d%s%d%s", i, "=>", tmpi1, " "
  tab[i] = tmpi1;
end
print "\n";
tab2 = [];
for i_ in (0 ..  len - 1) do
  tmpi2 = 0
  tmpi2=scanf("%d")[0];
  scanf("%*\n");
  printf "%d%s%d%s", i_, "==>", tmpi2, " "
  tab2[i_] = tmpi2;
end
strlen = 0
strlen=scanf("%d")[0];
scanf("%*\n");
printf "%d%s", strlen, "=strlen\n"
tab4 = [];
for toto in (0 ..  strlen - 1) do
  tmpc = '_'
  tmpc=scanf("%c")[0];
  c = tmpc.ord
  printf "%c%s%d%s", tmpc, ":", c, " "
  if tmpc != ' ' then
    c = ((c - 'a'.ord) + 13) % 26 + 'a'.ord;
  end
  tab4[toto] = c;
end
for j in (0 ..  strlen - 1) do
  a = tab4[j]
  printf "%c", a
end

