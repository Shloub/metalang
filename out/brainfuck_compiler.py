
"""
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
"""
input = ' ';
current_pos = 500;
a = 1000;
mem_ = [None] * a
for i in range(0, a):
  mem_[i] = 0;
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
while (mem_[current_pos] != 0):
  mem_[current_pos] = mem_[current_pos] - 1;
  current_pos -= 1
  mem_[current_pos] = mem_[current_pos] + 1;
  b = mem_[current_pos];
  print("%c" % b, end='')
  current_pos += 1

