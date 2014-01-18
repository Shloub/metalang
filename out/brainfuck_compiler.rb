
require "scanf.rb"



=begin

Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante

=end

input = ' '
current_pos = 500
k = 1000
mem = [];
for i in (0 ..  k - 1) do
  mem[i] = 0;
end

