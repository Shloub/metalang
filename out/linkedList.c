#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }

struct intlist;
typedef struct intlist {
  int head;
  struct intlist * tail;
} intlist;

int main(void){
  
  return 0;
}


