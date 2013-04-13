#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }


int main(void){
  printf("%s", "ma petite chaine");
  printf("%s", " en or");
  return 0;
}


