
require "scanf.rb"



=begin

Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante

=end

input = ' '
current_pos = 500
a = 1000
mem_ = [];
for i in (0 ..  a - 1) do
  mem_[i] = 0;
end
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
current_pos += 1
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
mem_[current_pos] = mem_[current_pos] + 1;
while mem_[current_pos] != 0 do
  mem_[current_pos] = mem_[current_pos] - 1;
  current_pos -= 1
  mem_[current_pos] = mem_[current_pos] + 1;
  b = mem_[current_pos]
  printf "%c", b
  current_pos += 1
end

