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
  std::vector<int > mem_( a );
  for (int i = 0 ; i < a; i++)
    mem_.at(i) = 0;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  current_pos ++;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  mem_.at(current_pos) = mem_.at(current_pos) + 1;
  while (mem_.at(current_pos) != 0)
  {
    mem_.at(current_pos) = mem_.at(current_pos) - 1;
    current_pos --;
    mem_.at(current_pos) = mem_.at(current_pos) + 1;
    char b = mem_.at(current_pos);
    std::cout << b;
    current_pos ++;
  }
  return 0;
}

