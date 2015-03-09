require "scanf.rb"

=begin

Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante

=end

input = " "
current_pos = 500
mem = [*0..1000 - 1].map { |i|
  next (0)
  }
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
current_pos += 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
mem[current_pos] = mem[current_pos] + 1
while mem[current_pos] != 0 do
  mem[current_pos] = mem[current_pos] - 1
  current_pos -= 1
  mem[current_pos] = mem[current_pos] + 1
  printf "%c", mem[current_pos]
  current_pos += 1
end

