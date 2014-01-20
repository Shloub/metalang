
require "scanf.rb"




=begin

Ce test effectue un rot13 sur une chaine lue en entrée

=end

strlen = 0
strlen=scanf("%d")[0];
scanf("%*\n");
tab4 = [];
for toto in (0 ..  strlen - 1) do
  tmpc = '_'
  tmpc=scanf("%c")[0];
  c = tmpc.ord
  if tmpc != ' ' then
    c = ((c - 'a'.ord) + 13) % 26 + 'a'.ord;
  end
  tab4[toto] = c;
end
for j in (0 ..  strlen - 1) do
  a = tab4[j]
  printf "%c", a
end

