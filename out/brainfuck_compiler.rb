
require "scanf.rb"



=begin

Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante

=end

input = ' '
current_pos = 500
r = 1000
mem = [];
for i in (0 ..  r - 1) do
  mem[i] = 0;
end
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
current_pos += 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
mem[current_pos] = mem[current_pos] + 1;
while mem[current_pos] != 0 do
  mem[current_pos] = mem[current_pos] - 1;
  current_pos -= 1;
  mem[current_pos] = mem[current_pos] + 1;
  s = mem[current_pos]
  printf "%c", s
  current_pos += 1;
end

