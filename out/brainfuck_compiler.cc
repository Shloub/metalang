#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>

/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/

int main(void){
  char input = ' ';
  int current_pos = 500;
  int a = 1000;
  std::vector<int > mem( a );
  for (int i = 0 ; i < a; i++)
    mem.at(i) = 0;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  current_pos ++;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  mem.at(current_pos) = mem.at(current_pos) + 1;
  while (mem.at(current_pos) != 0)
  {
    mem.at(current_pos) = mem.at(current_pos) - 1;
    current_pos --;
    mem.at(current_pos) = mem.at(current_pos) + 1;
    char b = mem.at(current_pos);
    std::cout << b;
    current_pos ++;
  }
  return 0;
}

