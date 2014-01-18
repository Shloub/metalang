#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
typedef enum lng {
  LANG_C,
  LANG_Pas,
  LANG_Cc,
  LANG_Cs,
  LANG_Java,
  LANG_Js,
  LANG_Ml,
  LANG_Php,
  LANG_Rb,
  LANG_Py,
  LANG_Tex,
  LANG_Metalang
} lng;
/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/

int main(void){
  char input = ' ';
  int current_pos = 500;
  int d = 1000;
  std::vector<int > mem( d );
  for (int i = 0 ; i < d; i++)
    mem.at(i) = 0;
  return 0;
}

