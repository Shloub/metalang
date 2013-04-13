#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }

struct toto;
typedef struct toto {
  int foo;
  int bar;
} toto;

int main(void){
  struct toto * param = malloc (sizeof(param) );
  param->foo=0;
  param->bar=0;
  scanf("%d", &param->bar);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &param->foo);
  int a = param->bar + (param->foo * param->bar);
  printf("%d", a);
  return 0;
}


