#include<stdio.h>
#include<stdlib.h>

void foo(int a){
  a = 4;
}

int main(void){
  int a = 0;
  foo(a);
  printf("%d%s", a, "\n");
  return 0;
}


