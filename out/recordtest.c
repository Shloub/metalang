#include<stdio.h>
#include<stdlib.h>

struct toto;
typedef struct toto {
  int foo;
  int bar;
} toto;

int main(void){
  struct toto * param = malloc (sizeof(param) );
  param->foo=0;
  param->bar=0;
  scanf("%d %d", &param->bar, &param->foo);
  int a = param->bar + param->foo * param->bar;
  printf("%d", a);
  return 0;
}


