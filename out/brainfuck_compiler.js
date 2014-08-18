/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
var input = ' ';
var current_pos = 500;
var a = 1000;
var mem = new Array(a);
for (var i = 0 ; i <= a - 1; i++)
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
current_pos ++;
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
while (mem[current_pos] != 0)
{
  mem[current_pos] = mem[current_pos] - 1;
  current_pos --;
  mem[current_pos] = mem[current_pos] + 1;
  util.print(String.fromCharCode(mem[current_pos]));
  current_pos ++;
}

