#include<stdio.h>
#include<stdlib.h>


/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
int main(void){
  char input = ' ';
  int current_pos = 500;
  int a = 1000;
  int *mem_ = malloc( a * sizeof(int));
  {
    int i;
    for (i = 0 ; i < a; i++)
      mem_[i] = 0;
  }
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
  current_pos ++;
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
  while (mem_[current_pos] != 0)
  {
    mem_[current_pos] = mem_[current_pos] - 1;
    current_pos --;
    mem_[current_pos] = mem_[current_pos] + 1;
    char b = mem_[current_pos];
    printf("%c", b);
    current_pos ++;
  }
  return 0;
}


