require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

=begin

Ce test effectue un rot13 sur une chaine lue en entrée

=end

strlen=scanf("%d")[0]
scanf("%*\n")
tab4 = [*0..strlen - 1].map { |toto|
  tmpc=scanf("%c")[0]
  c = tmpc.ord
  if tmpc != " " then
    c = mod((c - "a".ord) + 13, 26) + "a".ord
  end
  next ((c).chr)
  }
for j in (0 ..  strlen - 1) do
  printf "%c", tab4[j]
end

