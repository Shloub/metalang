#include<stdio.h>
#include<stdlib.h>

/*
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
*/
int main(void){
  int j = 0;
  j = 0;
  printf("%d", j);
  printf("%s", "\n");
  j = 1;
  printf("%d", j);
  printf("%s", "\n");
  j = 2;
  printf("%d", j);
  printf("%s", "\n");
  j = 3;
  printf("%d", j);
  printf("%s", "\n");
  j = 4;
  printf("%d", j);
  printf("%s", "\n");
  return 0;
}


