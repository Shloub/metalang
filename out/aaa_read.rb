require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

=begin

Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip

=end

len=scanf("%d")[0]
scanf("%*\n")
printf "%d=len\n", len
len *= 2
printf "len*2=%d\n", len
len = (len.to_f / 2).to_i
tab = [*0..len - 1].map { |i|
  tmpi1=scanf("%d")[0]
  scanf("%*\n")
  printf "%d=>%d ", i, tmpi1
  next (tmpi1)
  }
print "\n"
tab2 = [*0..len - 1].map { |i_|
  tmpi2=scanf("%d")[0]
  scanf("%*\n")
  printf "%d==>%d ", i_, tmpi2
  next (tmpi2)
  }
strlen=scanf("%d")[0]
scanf("%*\n")
printf "%d=strlen\n", strlen
tab4 = [*0..strlen - 1].map { |toto|
  tmpc=scanf("%c")[0]
  c = tmpc.ord
  printf "%c:%d ", tmpc, c
  if tmpc != " " then
    c = mod(c - "a".ord + 13, 26) + "a".ord
  end
  next ((c).chr)
  }
for j in (0 ..  strlen - 1) do
  printf "%c", tab4[j]
end

