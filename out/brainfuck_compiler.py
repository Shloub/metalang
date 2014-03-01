
"""
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
"""
input = ' ';
current_pos = 500;
a = 1000;
mem = [None] * a
for i in range(0, a):
  mem[i] = 0;
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
current_pos += 1
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
while (mem[current_pos] != 0):
  mem[current_pos] = mem[current_pos] - 1;
  current_pos -= 1
  mem[current_pos] = mem[current_pos] + 1;
  b = mem[current_pos];
  print("%c" % b, end='')
  current_pos += 1

