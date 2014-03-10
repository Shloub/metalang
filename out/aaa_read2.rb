
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

def read_char_line( n )
    tab = [];
    for i in (0 ..  n - 1) do
      t_ = '_'
      t_=scanf("%c")[0];
      tab[i] = t_;
    end
    scanf("%*\n");
    return (tab);
end


=begin

Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip

=end

len = read_int()
printf "%d=len\n", len
tab = read_int_line(len)
for i in (0 ..  len - 1) do
  printf "%d=>", i
  a = tab[i]
  printf "%d ", a
end
print "\n";
tab2 = read_int_line(len)
for i_ in (0 ..  len - 1) do
  printf "%d==>", i_
  b = tab2[i_]
  printf "%d ", b
end
strlen = read_int()
printf "%d=strlen\n", strlen
tab4 = read_char_line(strlen)
for i3 in (0 ..  strlen - 1) do
  tmpc = tab4[i3]
  c = tmpc.ord
  printf "%c:%d ", tmpc, c
  if tmpc != ' ' then
    c = ((c - 'a'.ord) + 13) % 26 + 'a'.ord;
  end
  tab4[i3] = c;
end
for j in (0 ..  strlen - 1) do
  d = tab4[j]
  printf "%c", d
end

