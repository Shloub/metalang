var util = require("util");
/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
var input = ' ';
var current_pos = 500;
var mem = new Array(1000);
for (var i = 0; i < 1000; i++)
    mem[i] = 0;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
current_pos++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
mem[current_pos]++;
while (mem[current_pos] != 0)
{
    mem[current_pos]--;
    current_pos--;
    mem[current_pos]++;
    util.print(String.fromCharCode(mem[current_pos]));
    current_pos++;
}

