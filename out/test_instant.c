#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }


int main(void){
  printf("%d", 10);
  return 0;
}


