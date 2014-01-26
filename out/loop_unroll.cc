#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
/*
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
*/

int main(void){
  int j = 0;
  j = 0;
  std::cout << j;
  std::cout << "\n";
  j = 1;
  std::cout << j;
  std::cout << "\n";
  j = 2;
  std::cout << j;
  std::cout << "\n";
  j = 3;
  std::cout << j;
  std::cout << "\n";
  j = 4;
  std::cout << j;
  std::cout << "\n";
  return 0;
}

