#include<stdio.h>
#include<stdlib.h>

struct toto;
typedef struct toto {
  int foo;
  int bar;
} toto;

int main(void){
  struct toto * b = malloc (sizeof(b) );
  b->foo=0;
  b->bar=0;
  struct toto * param = b;
  scanf("%d", &param->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &param->foo);
  int a = param->bar + param->foo * param->bar;
  printf("%d", a);
  return 0;
}


